import UIKit
import SceneKit

@objc public protocol SketchDelegate {
    func setup()
    func draw()
    @objc optional func touchStarted()
    @objc optional func touchMoved()
    @objc optional func touchEnded()
}

@IBDesignable open class Sketch: UIScrollView, UIScrollViewDelegate {
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
    
    public let LEFT = "left"
    public let RIGHT = "right"
    public let TOP = "top"
    public let BOTTOM = "bottom"
    public let BASELINE = "baseline"
    
    public weak var sketchDelegate: SketchDelegate?
    public var rect: CGRect = CGRect()
    public var width: CGFloat = 0
    public var height: CGFloat = 0
    public let deviceWidth = UIScreen.main.bounds.width
    public let deviceHeight = UIScreen.main.bounds.height

    
    public var isFaceMode: Bool = false
    public var isFaceFill: Bool = true
    
    public var frameCount: CGFloat = 0
    public var deltaTime: CGFloat = 1/60
    private var lastTime: CGFloat = CGFloat(CACurrentMediaTime())
    var fps: CGFloat = 60
    var fpsTimer: Timer?
    
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
    var touchRecongizer: UIGestureRecognizer!
    
    var isSetup: Bool = false
    open var context: CGContext?
    
    
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
        delegate = self
        sketchDelegate = self as? SketchDelegate
        createCanvas(0, 0, UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        loop()
    }
    
    override public func draw(_ rect: CGRect) {
        self.context = UIGraphicsGetCurrentContext()
        
        if self.context == nil {
            return
        }
        if !isSetup{
            sketchDelegate?.setup()
            isSetup = true
        }
        updateTimes()
        self.width = rect.width
        self.height = rect.height
        self.rect = rect
        sketchDelegate?.draw()
        updateScrollView()
        updateTouches()
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
    }
    
    open func pop() {
        context?.restoreGState()
        settings = settingsStack.pop()!
        settings.restore(sketch: self)
    }
}
