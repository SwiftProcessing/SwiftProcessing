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
    
    var strokeWeight: CGFloat = 1
    var isFill: Bool = true
    var isStroke: Bool = true
    
    var context: CGContext?
    
    override init(frame: CGRect){
        super.init(frame: frame);
        delegate = self as? SketchDelegate
        startAnimation()
    }
    
    required public init(coder: NSCoder){
        super.init(coder: coder)!;
        delegate = self as? SketchDelegate
        startAnimation()
    }
    
    private func startAnimation(){
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { [weak self] _ in
                self?.setNeedsDisplay();
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    
    override public func draw(_ rect: CGRect) {
        self.context = UIGraphicsGetCurrentContext()
        self.width = rect.width
        self.height = rect.height
        self.rect = rect
        delegate?.draw()
    }
    
}
