import UIKit

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
    
    
    weak var delegate: SketchDelegate?
    public var rect: CGRect = CGRect()
    public var width: CGFloat = 0
    public var height: CGFloat = 0
    
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
    
    var context: CGContext?
    
    override init(frame: CGRect){
        super.init(frame: frame);
        delegate = self as? SketchDelegate
        delegate?.setup()
        startAnimation()
    }
    
    required public init(coder: NSCoder){
        super.init(coder: coder)!;
        delegate = self as? SketchDelegate
        delegate?.setup()
        startAnimation()
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(touches.count)
        if let touch = touches.first {
            let position = touch.location(in: self)
            print(position)
        }
    }
    
    private func startAnimation(){
        if #available(iOS 10.0, *) {
            fpsTimer = Timer.scheduledTimer(withTimeInterval: Double(1.0 / self.fps), repeats: true, block: {  _ in
                self.setNeedsDisplay();
            })
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    
    override public func draw(_ rect: CGRect) {
        updateTimes()
        self.context = UIGraphicsGetCurrentContext()
        self.width = rect.width
        self.height = rect.height
        self.rect = rect
        delegate?.draw()
    }
    
    private func updateTimes() {
        frameCount =  frameCount + 1
        let newTime = CGFloat(CACurrentMediaTime())
        deltaTime = newTime - lastTime
        lastTime = newTime
    }
    
    open func push(){
        settingsStack.push(settings: settings)
    }
    
    open func pop(){
        settings = settingsStack.pop()!
        settings.restore(sketch: self)
    }
}
