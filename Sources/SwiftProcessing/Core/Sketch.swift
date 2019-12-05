import UIKit
import SceneKit

public protocol SketchDelegate: Sketch {
    func setup()
    func draw()
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
    
    public let CLOSE = "close"
    
    public weak var sketchDelegate: SketchDelegate?
    public var rect: CGRect = CGRect()
    public var width: CGFloat = 0
    public var height: CGFloat = 0
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
    
    var settingsStack: SketchSettingsStack = SketchSettingsStack()
    var settings: SketchSettings = SketchSettings()
   
    var isContourStarted: Bool = false
    var contourPoints: [CGPoint] = []
    var shapePoints: [CGPoint] = []
    
    open var pixels: [UInt8] = []
    
    open var context: CGContext?
    
    public init(){
        super.init(frame: CGRect())
        sketchDelegate = self as? SketchDelegate
        sketchDelegate?.setup()
        loop()
    }
    
    required public init(coder: NSCoder){
        super.init(coder: coder)!;
        sketchDelegate = self as? SketchDelegate
        sketchDelegate?.setup()
        loop()
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(touches.count)
        if let touch = touches.first {
            let position = touch.location(in: self)
            print(position)
        }
    }
    
    override public func draw(_ rect: CGRect) {
        updateTimes()
        self.context = UIGraphicsGetCurrentContext()
        self.width = rect.width
        self.height = rect.height
        self.rect = rect
        sketchDelegate?.draw()
    }
    
    private func updateTimes() {
        frameCount =  frameCount + 1
        let newTime = CGFloat(CACurrentMediaTime())
        deltaTime = newTime - lastTime
        lastTime = newTime
    }
    
    open func push(){
        context?.saveGState()
        settingsStack.push(settings: settings)
    }
    
    open func pop(){
        context?.restoreGState()
        settings = settingsStack.pop()!
        settings.restore(sketch: self)
    }
}
