/*
 * SwiftProcessing
 *
 * */


import UIKit
import SceneKit
import GameplayKit

// =======================================================================
// MARK: - Delegate/Protocol
// =======================================================================

@objc public protocol SketchDelegate {
    func setup()
    func draw()
    @objc optional func touchStarted()
    @objc optional func touchMoved()
    @objc optional func touchEnded()
}

@IBDesignable open class Sketch: UIView {
    
    // =======================================================================
    // MARK: - Processing Constants
    // =======================================================================
    
    // NOTE: Swift design guidelines implicitly discourage all-caps constants.
    // This is very Java- or JavaScript-ey. A more Swift-ey way of doing this
    // would be to create categorical enums. Enums would also leverage auto-
    // complete in the same way that these constants would. For the constants
    // that have values, another approach would be to create structs.
    
    // https://swift.org/documentation/api-design-guidelines/#conventions
    
    /*
     * MARK: - MATH CONSTANTS
     */
    
    /// The `Math` struct contains all of the constant values that can be used in SwiftProcessing for mathematics. **Note:** Values are returned as Doubles.
    
    public struct Math {
        public static let half_pi = Double.pi / 2
        public static let pi = Double.pi
        public static let quarter_pi = Double.pi / 4
        public static let two_pi = Double.pi * 2
        public static let tau = Double.pi * 2
        public static let e = M_E
    }
    
    /*
     * MARK: - KEYWORD CONSTANTS
     */
    
    /// The `Default` struct contains the defaults for the style states that SwiftProcessing keeps track of.
    
    public struct Default {
        public static let backgroundColor = Color(204)
        public static let colorMode = ColorMode.rgb
        public static let fill = Color(255)
        public static let stroke = Color(0.0)
        public static let tint = Color(0.0, 0.0)
        public static let strokeWeight = 1.0
        public static let strokeJoin = StrokeJoin.miter
        public static let strokeCap = StrokeCap.round
        public static let rectMode = ShapeMode.corner
        public static let ellipseMode = ShapeMode.center
        public static let imageMode = ShapeMode.corner
        public static let textFont = "HelveticaNeue"
        public static let textSize = 32.0
        public static let textLeading = 38.4 // Generally 120% of size. This is derived from Adobe's default treatment of leading.
        public static let textAlign = Alignment.left
        public static let textAlignY = AlignmentY.baseline
        public static let blendMode = CGBlendMode.normal
        public static let perlinSize = 4096
        public static let perlinOctaves = 4
        public static let perlinFalloff = 0.5
    }
    
    
    /// The `colorMode()` function enables SwiftProcessing users to switch between
    
    open func colorMode(_ mode: ColorMode) {
        settings.colorMode = mode
    }
    
    /*
     * MARK: - SCREEN / DISPLAY PROPERTIES
     */
    
    public weak var sketchDelegate: SketchDelegate?
    public var width: Double = 0
    public var height: Double = 0
    public var nativeWidth: Double = 0
    public var nativeHeight: Double = 0
    public let deviceWidth = Double(UIScreen.main.bounds.width)
    public let deviceHeight = Double(UIScreen.main.bounds.height)
    
    public var isFaceMode: Bool = false
    public var isFaceFill: Bool = true
    
    public var frameCount: Double = 0
    public var deltaTime: Double = 1/60
    var lastTime: Double = CACurrentMediaTime()
    var millsOffset: Int = Int(NSDate().timeIntervalSince1970 * 1000)
    
    var fps: Double = 60
    
    var fpsTimer: CADisplayLink?
    
    var isFill: Bool = true
    var isStroke: Bool = true
    var isErase: Bool = false
    
    var isScrollX: Bool = false
    var isScrollY: Bool = true
    var minX: Double = 0
    var maxX: Double = 0
    var minY: Double = 0
    var maxY: Double = 0
    
    public var settingsStack: SketchSettingsStack = SketchSettingsStack()
    public var matrixStack: SketchMatrixStack = SketchMatrixStack()
    public var settings: SketchSettings = SketchSettings()
    
    open var pixels: [UInt8] = []
    
    open var touches: [Vector] = []
    open var touched: Bool = false
    open var touchX: Double = -1
    open var touchY: Double = -1
 
    var touchMode: TouchMode = .sketch
    var touchRecongizer: UIGestureRecognizer!
    
    var notificationActionsWithData: [String: (_ data: [AnyHashable : Any]) -> Void] = [:]
    var notificationActions: [String: () -> Void] = [:]
    
    var isSetup: Bool = false
    open var context: CGContext?
    
    /*
     * MARK: - TEXT/TYPOGRAPHY
     */
    
    var paragraphStyle: NSMutableParagraphStyle?
    var attributes: [NSAttributedString.Key: Any] = [:]
    
    func setTextAttributes() {
        paragraphStyle = NSMutableParagraphStyle()
        
        switch settings.textAlign {
        case .left:
            paragraphStyle?.alignment = .left
        case .right:
            paragraphStyle?.alignment = .right
        case .center:
            paragraphStyle?.alignment = .center
        }
    
        paragraphStyle?.lineSpacing = CGFloat(settings.textLeading)
        
        attributes = [
            .font: UIFont(name: settings.textFont, size: CGFloat(settings.textSize))!,
            .foregroundColor: settings.fill.uiColor(),
            .strokeWidth: -settings.strokeWeight,
            .strokeColor: settings.stroke.uiColor(),
            .paragraphStyle: paragraphStyle!
        ]
    }
    
    /*
     * MARK: - VERTICES
     */

    var vertexMode: VertexMode = .normal
    var isContourStarted: Bool = false
    var contourPoints: [CGPoint] = []
    var shapePoints: [CGPoint] = []
    
    private var curveVertices = [[CGFloat]]()
    private var curveVertexCount: Int = 0
    
    /*
     * MARK: - TRANSFORMATION PROPERTIES
     */
    
    var scene: SCNScene = SCNScene()
    var lightNode: SCNNode = SCNNode()
    var ambientLightNode: SCNNode = SCNNode()
    var cameraNode: SCNNode = SCNNode()
    var lookAtNode: SCNNode = SCNNode()
    var rootNode: TransitionSCNNode = TransitionSCNNode()
    
    var stackOfTransformationNodes: [TransitionSCNNode] = []
    var lastFrameTransformationNodes: [TransitionSCNNode] = []
    var currentTransformationNode: TransitionSCNNode = TransitionSCNNode()
    var currentStack: [TransitionSCNNode] = []
    
    var globalPosition: SIMD4<Float> = simd_float4(0,0,0,0)
    var globalRotation: SIMD4<Float> = simd_float4(0,0,0,0)
    
    var texture: Image? = nil
    var textureID: String = ""
    var textureEnabled: Bool = false
    var scnmat: SCNMaterial = SCNMaterial()
    var enable3DMode: Bool = false
    
    /*
     * MARK: - NOISE
     */
    
    var noiseSource = GKPerlinNoiseSource()
    var noise = GKNoise()
    
    func initNoise(_ size: Int = Default.perlinSize, _ detail: Int = Default.perlinOctaves, _ falloff: Double = Default.perlinFalloff) {
        noiseSource = GKPerlinNoiseSource()
        noiseSource.octaveCount = detail
        noiseSource.persistence = falloff
        noise = GKNoise(noiseSource)
    }
    
    // Used to store references to UIKitViewElements created using SwiftProcessing. Storing references avoids the elements being deallocated from memory. This is needed to have the touch events continue to function
    
    open var viewRefs: [String: UIKitViewElement?] = [:]
    
    // =======================================================================
    // MARK: - INIT
    // =======================================================================
    
    public init() {
        super.init(frame: CGRect())
        initHelper()
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)!
        initHelper()
    }
    
    private func initHelper(){
        initTouch()
        initNoise()
        initNotifications()
        sketchDelegate = self as? SketchDelegate
        createCanvas(0.0, 0.0, UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        self.layer.drawsAsynchronously = true
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), true, 1.0)
        
        self.context = UIGraphicsGetCurrentContext()
        
        UIGraphicsEndImageContext()
        
        loop()
    }
    
    // The graphics context also needs to have all of the initial global states set up. Restore was created to mimic Core Graphics restore function, but it also works perfectly to sync up our default SwiftProcessing global states with Core Graphics' states.
    
    private func initializeGlobalContextStates() {
        Sketch.SketchSettings.defaultSettings(self)
        setTextAttributes()
    }
    
    // ========================================================
    // MARK: - DRAW LOOP
    // ========================================================
    
    /// `beginDraw()` sets the global state. It ensures that the Core Graphics context and SwiftProcessing's global settings start out in sync. Overridable if anything needs to be done before `setup()` is run.
    
    open func beginDraw() {
        initializeGlobalContextStates()
    }
    
    override public func draw(_ rect: CGRect) {
        // This override is not actually called but required for the UIView to call the display function. This is a reference to the UIView's draw, not Processing's draw loop.
    }
    
    override public func display(_ layer: CALayer) {
        preDraw3D()
        
        updateDimensions()
        updateTimes()

        // Refresh all of the settings just in case to maintain state.
        settings.reapplySettings(self)
        context?.saveGState()
        
        // Having two pushes (.saveGState() and below) might seem redundant, but UIGraphicsPush is necessary for UIImages.
        UIGraphicsPushContext(context!)

        scale(UIScreen.main.scale, UIScreen.main.scale)
        
        // To ensure setup only runs once.
        if !isSetup{
            background(Default.backgroundColor)
            sketchDelegate?.setup()
            isSetup = true
        }
        
        // Should happen right before draw and inside of the push() and pop().
        updateTouches()
        
        sketchDelegate?.draw() // All instructions go into current context.
        
        postDraw3D()
        
        UIGraphicsPopContext()
        context?.restoreGState()
        
        // This makes the background persist if the background isn't cleared.
        let img = context!.makeImage() // <- This may be a speed bottleneck.
        layer.contents = img
        layer.contentsGravity = .resizeAspect
    }
    
    private func updateDimensions() {
        self.width = Double(self.frame.width)
        self.height = Double(self.frame.height)
        self.nativeWidth = Double(self.frame.width) * Double(UIScreen.main.scale)
        self.nativeHeight = Double(self.frame.height) * Double(UIScreen.main.scale)
        
        //recreate the backing ImageContext when the native dimensions do not match the context dimensions
        if (self.context?.width != Int(nativeWidth)
                || self.context?.height != Int(nativeHeight)) {
            UIGraphicsBeginImageContext(CGSize(width: nativeWidth, height: nativeHeight))
            self.context = UIGraphicsGetCurrentContext()
            UIGraphicsEndImageContext()
        }
    }
    
    /// `endDraw()` is an overridable function that runs after `noLoop()` is run. It can be used for any last minute cleanup after the last `draw()` loop has executed.
    
    open func endDraw() {
    }
    
 
}
