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
        public static let textFont = "HelveticaNeue-Thin"
        public static let textSize = 32.0 // Processing is 12, so let's test this out.
        public static let textLeading = 37.0 // Processing is 14. This is a similar increase.
        public static let textAlign = Alignment.left
        public static let textAlignY = AlignmentY.baseline
        public static let blendMode = CGBlendMode.normal
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
    
    // This is the last string-based constant in SwiftProcessing. Leaving this here for future contributors. It needs to be converted to an enum but .self cannot be the name of a member of an enum.
    var touchMode: TouchMode = .sketch
    var touchRecongizer: UIGestureRecognizer!
    
    var notificationActionsWithData: [String: (_ data: [AnyHashable : Any]) -> Void] = [:]
    var notificationActions: [String: () -> Void] = [:]
    
    var isSetup: Bool = false
    open var context: CGContext?
    
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
    
    let noiseSource = GKPerlinNoiseSource()
    var noise = GKNoise()
    
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
        initNotifications()
        sketchDelegate = self as? SketchDelegate
        createCanvas(0.0, 0.0, UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        self.layer.drawsAsynchronously = true
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), true, 1.0)
        
        self.context = UIGraphicsGetCurrentContext()
        
        UIGraphicsEndImageContext()
        
        self.clearsContextBeforeDrawing = false
        self.isOpaque = true
        
        loop()
    }
    
    // The graphics context also needs to have all of the initial global states set up. Restore was created to mimic Core Graphics restore function, but it also works perfectly to sync up our default SwiftProcessing global states with Core Graphics' states.
    
    private func initializeGlobalContextStates() {
        noise = GKNoise(noiseSource)
        Sketch.SketchSettings.defaultSettings(self)
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

        // Refresh all of the settings just in case to maintain state. At some point, we might be able to remove this. It is here as a precaution for now.
        settings.reapplySettings(self)
        context?.saveGState()
        
        // Having two pushes (.saveGState() and below) might seem redundant, but UIGraphicsPush is necessary for UIImages.
        UIGraphicsPushContext(context!)

        scale(UIScreen.main.scale, UIScreen.main.scale)
        
        // To ensure setup only runs once.
        if !isSetup{
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
