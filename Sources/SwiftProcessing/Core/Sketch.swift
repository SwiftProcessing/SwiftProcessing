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
    
    /**
     The keyPressed() function is called once every time a key is pressed. The key that was pressed is stored in the key variable.
     
     For non-ASCII keys, use the keyCode variable. The keys included in the ASCII specification (BACKSPACE, TAB, ENTER, RETURN, ESC, and DELETE) do not require checking to see if the key is coded; for those keys, you should simply use the key variable directly (and not keyCode). If you're making cross-platform projects, note that the ENTER key is commonly used on PCs and Unix, while the RETURN key is used on Macs. Make sure your program will work on all platforms by checking for both ENTER and RETURN.
     
     Because of how operating systems handle key repeats, holding down a key may cause multiple calls to keyPressed(). The rate of repeat is set by the operating system, and may be configured differently on each computer.
     
     Note that there is a similarly named boolean variable called keyPressed. See its reference page for more information.
     
     Mouse and keyboard events only work when a program has draw(). Without draw(), the code is only run once and then stops listening for events.
     
     With the release of macOS Sierra, Apple changed how key repeat works, so keyPressed may not function as expected. See here for details of the problem and how to fix it.
     */
    
    @objc optional func keyPressed()
    
    /**
     The keyReleased() function is called once every time a key is released. The key that was released will be stored in the key variable. See key and keyCode for more information. Mouse and keyboard events only work when a program has draw(). Without draw(), the code is only run once and then stops listening for events.
     */
    
    @objc optional func keyReleased()
    
    /**
     The keyTyped() function is called once every time a key is pressed, but action keys such as Ctrl, Shift, and Alt are ignored. Because of how operating systems handle key repeats, holding down a key may cause multiple calls to keyTyped(). The rate of repeat is set by the operating system, and may be configured differently on each computer. Mouse and keyboard events only work when a program has draw(). Without draw(), the code is only run once and then stops listening for events.
     */
    
    @objc optional func keyTyped()
    
    /**
     The touchStarted() function is called once after every time a touch is registered.
     */
    
    @objc optional func touchStarted()
    
    /**
     The touchMoved() function is called every time a touch move is registered.
     */
    
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
        public static let degToRadian =   Double.pi / 180.0
        public static let radToDegree = 180.0 / Double.pi
    }
    
    /*
     * MARK: - KEYWORD CONSTANTS
     */
    
    /// The `Default` struct contains the defaults for the style states that SwiftProcessing keeps track of.
    
    public struct Default {
        public static let backgroundColor = Color(204.0, 204.0, 204.0, 255.0)
        public static let colorMode = ColorMode.rgb
        public static let fill = Color(255.0, 255.0, 255.0, 255.0)
        public static let stroke = Color(0.0, 0.0, 0.0, 0.0)
        public static let tint = Color(0.0, 0.0, 0.0, 0.0)
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
    
    
    /// The `colorMode()` function enables SwiftProcessing users to switch between RGB and HSB color modes.
    
    open func colorMode(_ mode: ColorMode) {
        settings.colorMode = mode
    }
    
    open func colorMode(_ mode: ColorMode, _ max: Numeric) {
        settings.colorMode = mode
        
        Color.v1Max = max.convert()
        Color.v2Max = max.convert()
        Color.v3Max = max.convert()
        
        Color.alphaMax = max.convert()
    }
    
    open func colorMode(_ mode: ColorMode,_ max1: Numeric,_ max2: Numeric,_ max3: Numeric) {
        settings.colorMode = mode
        
        Color.v1Max = max1.convert()
        Color.v2Max = max2.convert()
        Color.v3Max = max3.convert()
    }
    
    open func colorMode(_ mode: ColorMode,_ max1: Numeric,_ max2: Numeric,_ max3: Numeric, _ maxA: Numeric) {
        settings.colorMode = mode
        
        Color.v1Max = max1.convert()
        Color.v2Max = max2.convert()
        Color.v3Max = max3.convert()
        
        Color.alphaMax = maxA.convert()
    }
    
    /*
     * MARK: - SCREEN / DISPLAY PROPERTIES
     */
    
    public weak var sketchDelegate: SketchDelegate?
    public var width: Int = 0
    public var height: Int = 0
    public var nativeWidth: Double = 0
    public var nativeHeight: Double = 0
    public let deviceWidth = Double(UIScreen.main.bounds.width)
    public let deviceHeight = Double(UIScreen.main.bounds.height)
    
    public var isFaceMode: Bool = false
    public var isFaceFill: Bool = true
    
    /// The number of frames that have passed since the sketch started.
    public var frameCount: Int = 0
    
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
    var keyTyped: Bool = false
    open var context: CGContext?
    
    /*
     * MARK: - TEXT/TYPOGRAPHY
     */
    
    var fontErrorHasDisplayed = false;
    
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
            .font: UIFont(name: settings.textFont, size: CGFloat(settings.textSize)) ?? UIFont(name: Default.textFont, size: settings.textSize)!,
            .foregroundColor: settings.fill.uiColor(),
            .strokeWidth: -settings.strokeWeight,
            .strokeColor: settings.stroke.uiColor(),
            .paragraphStyle: paragraphStyle!
        ]
        
        if UIFont(name: settings.textFont, size: settings.textSize) == nil && !fontErrorHasDisplayed {
            print("ERROR: It looks like the font you are trying to call isn't installed. Font file names are not always the same as the name the system refers to them as. You can find out the internal name by iterating through the installed fonts. See reference for textFont().")
            fontErrorHasDisplayed = true
        }
        
    }
    
    /*
     * MARK: - KEYBOARD INTERACTION
     */
    
    open override var canBecomeFirstResponder: Bool {
        return true
    }
    
    /// The system variable `key` always contains the value of the most recent key on the keyboard that was used (either pressed or released). For non-ASCII keys, use the `keyCode` variable. The keys included in the ASCII specification (BACKSPACE, TAB, ENTER, RETURN, ESC, and DELETE) do not require checking to see if they key is coded, and you should simply use the key variable instead of keyCode If you're making cross-platform projects, note that the ENTER key is commonly used on PCs and Unix and the RETURN key is used instead on Macintosh. Check for both ENTER and RETURN to make sure your program will work for all platforms. There are issues with how keyCode behaves across different renderers and operating systems. Watch out for unexpected behavior as you switch renderers and operating systems.
    
    public var key: Character = "\0"
    
    @available(iOS 13.4, *)
    lazy var internalKey: UIKey = UIKey()
    
    /// The boolean system variable keyPressed is true if any key is pressed and false if no keys are pressed. Note that there is a similarly named function called keyPressed(). See its reference page for more information.
    
    @available(iOS 13.4, *)
    public lazy var keyPressed = false
    
    /// The variable keyCode is used to detect special keys such as the UP, DOWN, LEFT, RIGHT arrow keys and ALT, CONTROL, SHIFT.
    /// When checking for these keys, it can be useful to first check if the key is coded. This is done with the conditional if (key == CODED), as shown in the example above.
    /// The keys included in the ASCII specification (BACKSPACE, TAB, ENTER, RETURN, ESC, and DELETE) do not require checking to see if the key is coded; for those keys, you should simply use the key variable directly (and not keyCode). If you're making cross-platform projects, note that the ENTER key is commonly used on PCs and Unix, while the RETURN key is used on Macs. Make sure your program will work on all platforms by checking for both ENTER and RETURN.
    
    @available(iOS 13.4, *)
    public lazy var keyCode = KeyCode.none
    
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
        becomeFirstResponder() // Keyboard Input
        initNoise()
        initNotifications()
//        dateComponents = DateComponents(from: dateNow as! Decoder)
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
        
        // Update keypresses
        if #available(iOS 13.4, *) {
            if keyTyped {
                sketchDelegate?.keyTyped?()
                keyTyped = false
            }
            if keyPressed {
                sketchDelegate?.keyPressed?()
            }
        } else {
            // Fallback on earlier versions
        }
        
        postDraw3D()
        
        UIGraphicsPopContext()
        context?.restoreGState()
        
        // This makes the background persist if the background isn't cleared.
        let img = context!.makeImage() // <- This may be a speed bottleneck.
        layer.contents = img
        layer.contentsGravity = .resizeAspect
    }
    
    private func updateDimensions() {
        self.width = Int(self.frame.width)
        self.height = Int(self.frame.height)
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
