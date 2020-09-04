import UIKit
import SceneKit

@objc public protocol SketchDelegate {
    func setup()
    func draw()
    @objc optional func touchStarted()
    @objc optional func touchMoved()
    @objc optional func touchEnded()
}

@IBDesignable open class Sketch: UIView {
    //Processing Constants
    public let HALF_PI = CGFloat.pi / 2
    public let PI = CGFloat.pi
    public let QUARTER_PI = CGFloat.pi / 4
    public let TWO_PI = CGFloat.pi * 2
    public let TAU = CGFloat.pi * 2
    
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
    
    public weak var sketchDelegate: SketchDelegate?
    public var width: CGFloat = 0
    public var height: CGFloat = 0
    public var nativeWidth: CGFloat = 0
    public var nativeHeight: CGFloat = 0
    public let deviceWidth = UIScreen.main.bounds.width
    public let deviceHeight = UIScreen.main.bounds.height
    
    public var isFaceMode: Bool = false
    public var isFaceFill: Bool = true
    
    public var frameCount: CGFloat = 0
    public var deltaTime: CGFloat = 1/60
    private var lastTime: CGFloat = CGFloat(CACurrentMediaTime())
    var fps: CGFloat = 60
    
    var fpsTimer: CADisplayLink?

    var strokeWeight: CGFloat = 1
    var isFill: Bool = true
    var isStroke: Bool = true
    var isErase: Bool = false
    
    var isScrollX: Bool = false
    var isScrollY: Bool = true
    var minX: CGFloat = 0
    var maxX: CGFloat = 0
    var minY: CGFloat = 0
    var maxY: CGFloat = 0
    
    var settingsStack: SketchSettingsStack = SketchSettingsStack()
    var settings: SketchSettings = SketchSettings()
    
    var vertexMode: String = "normal"
    var isContourStarted: Bool = false
    var contourPoints: [CGPoint] = []
    var shapePoints: [CGPoint] = []
    
    open var pixels: [UInt8] = []
    
    open var touches: [Vector] = []
    open var touched: Bool = false
    open var touchX: CGFloat = -1
    open var touchY: CGFloat = -1
    
    var touchMode: String = "self"
    open var SELF: String = "self"
    open var ALL: String = "all"
    var touchRecongizer: UIGestureRecognizer!
    
    var notificationActionsWithData: [String: (_ data: [AnyHashable : Any]) -> Void] = [:]
    var notificationActions: [String: () -> Void] = [:]
    
    var isSetup: Bool = false
    open var context: CGContext?


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
    
    override public func draw(_ rect: CGRect) {
        //this override is not actually called
        //but required for the UIView to call the
        //display function
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
        if !isSetup{
            sketchDelegate?.setup()
            isSetup = true
        }       
        sketchDelegate?.draw()
        pop()
   
        
        postDraw3D()

        UIGraphicsPopContext()
        let img = context!.makeImage()
        layer.contents = img
        layer.contentsGravity = .resizeAspect
    }
    
    private func updateDimensions() {
        self.width = self.frame.width
        self.height = self.frame.height
        self.nativeWidth = self.frame.width * UIScreen.main.scale
        self.nativeHeight = self.frame.height * UIScreen.main.scale
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
        let newTime = CGFloat(CACurrentMediaTime())
        deltaTime = newTime - lastTime
        lastTime = newTime
    }
    
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
