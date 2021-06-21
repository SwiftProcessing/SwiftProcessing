/*
 * SwiftProcessing
 *
 * */


import UIKit
import SceneKit

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

    /*
    * MARK: - TRIGONOMETRY CONSTANTS
    */

    public let HALF_PI = Double.pi / 2
    public let PI = Double.pi
    public let QUARTER_PI = Double.pi / 4
    public let TWO_PI = Double.pi * 2
    public let TAU = Double.pi * 2
    
    /*
    * MARK: - KEYWORD CONSTANTS
    */
    
    public let DEGREES = "degrees"
    public let RADIANS = "radians"
    
    public let RADIUS = "radius"
    public let CORNER = "corner"
    public let CORNERS = "corners"
    public let CENTER = "center"
    
    public let PIE = "pie"
    public let CHORD = "chord"
    public let OPEN = "open"
    public let CLOSE = "close"
    public let NORMAL_VERTEX = "normal"
    public let CURVE_VERTEX = "curve"
    public let BEZIER_VERTEX = "bezier"
    
    public static let PIXELLATE = "pixellate"
    public let PIXELLATE = "pixellate"
    public static let HUE_ROTATE = "hue_rotate"
    public let HUE_ROTATE = "hue_rotate"
    public static let SEPIA_TONE = "sepia_tone"
    public let SEPIA_TONE = "sepia_tone"
    public static let TONAL = "tonal"
    public let TONAL = "tonal"
    public static let MONOCHROME = "monochrome"
    public let MONOCHROME = "monochrome"
    public static let INVERT = "invert"
    public let INVERT = "invert"
    
    public let LEFT = "left"
    public let RIGHT = "right"
    public let TOP = "top"
    public let BOTTOM = "bottom"
    public let BASELINE = "baseline"
    
    public let FRONT = "front"
    public let BACK = "back"
    
    public let HIGH = "high"
    public let MEDIUM = "medium"
    public let LOW = "low"
    public let VGA = "vga"
    public let HD = "hd"
    public let QHD = "qhd"
    
    public let UP = "up"
    public let UPSIDEDOWN = "upsidedown"
    
    public let CAMERA = "camera"
    public let PHOTO_LIBRARY = "photo library"
    public let CAMERA_ROLL = "camera roll"
    
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
    private var lastTime: Double = CACurrentMediaTime()
    var fps: Double = 60
    
    var fpsTimer: CADisplayLink?

    var strokeWeight: Double = 1
    var isFill: Bool = true
    var isStroke: Bool = true
    var isErase: Bool = false
    
    var isScrollX: Bool = false
    var isScrollY: Bool = true
    var minX: Double = 0
    var maxX: Double = 0
    var minY: Double = 0
    var maxY: Double = 0
    
    var settingsStack: SketchSettingsStack = SketchSettingsStack()
    var settings: SketchSettings = SketchSettings()
    
    var vertexMode: String = "normal"
    var isContourStarted: Bool = false
    var contourPoints: [CGPoint] = []
    var shapePoints: [CGPoint] = []
    
    open var pixels: [UInt8] = []
    
    open var touches: [Vector] = []
    open var touched: Bool = false
    open var touchX: Double = -1
    open var touchY: Double = -1
    
    var touchMode: String = "self"
    open var SELF: String = "self"
    open var ALL: String = "all"
    var touchRecongizer: UIGestureRecognizer!
    
    var notificationActionsWithData: [String: (_ data: [AnyHashable : Any]) -> Void] = [:]
    var notificationActions: [String: () -> Void] = [:]
    
    var isSetup: Bool = false
    open var context: CGContext?

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
    
    // used to store references to UIKitViewElements created using SwiftProcessing. Storing references avoids
    // the elements being deallocated from memory. This is needed to have the touch events continue to function
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
        createCanvas(0, 0, UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        self.layer.drawsAsynchronously = true
        UIGraphicsBeginImageContext(CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.context = UIGraphicsGetCurrentContext()
        UIGraphicsEndImageContext()
        loop()
    }
    
    // =======================================================================
    // MARK: - DRAW LOOP
    // =======================================================================

    override public func draw(_ rect: CGRect) {
        // this override is not actually called
        // but required for the UIView to call the
        // display function
            
        // This is a reference to the UIView's draw,
        // not Processing's draw loop.
    }
    
    override public func display(_ layer: CALayer) {

        preDraw3D()

        updateDimensions()
        UIGraphicsPushContext(context!)
        
        self.settingsStack.cleanup()
        currentStack = []
        self.settingsStack = SketchSettingsStack()
        updateTimes()
        updateTouches()
        
        push()
        scale(UIScreen.main.scale, UIScreen.main.scale)
        
        // To ensure setup only runs once.
        if !isSetup{
            sketchDelegate?.setup()
            isSetup = true
        }
        
        sketchDelegate?.draw()
        
        pop()
   
        postDraw3D()

        UIGraphicsPopContext()
        
        // This makes the background persist if the background isn't cleared.
        let img = context!.makeImage()
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
    
    private func updateTimes() {
        frameCount =  frameCount + 1
        let newTime = CACurrentMediaTime()
        deltaTime = newTime - lastTime
        lastTime = newTime
    }
        
    // =======================================================================
    // MARK: - FOR RETAINING GLOBAL PROCESSING STATES
    // =======================================================================
    
    open func push() {
        context?.saveGState()
        settingsStack.push(settings: settings)
        if (self.enable3DMode) {
            let rootTransformationNode = self.currentTransformationNode
            
            let newTransformationNode = rootTransformationNode.addNewTransitionNode()
            
            self.currentStack.append(newTransformationNode)
            self.stackOfTransformationNodes.append(newTransformationNode)
            
            self.translationNode(SCNVector3(0,0,0), "position", false)
        }
    }
    
    open func pop() {
        context?.restoreGState()
        settings = settingsStack.pop()!
        settings.restore(sketch: self)
        
        if(self.enable3DMode){
            self.currentTransformationNode = self.currentStack.popLast()!
        }
    }
}
