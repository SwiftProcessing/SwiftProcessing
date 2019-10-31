import UIKit

public protocol SketchDelegate: Sketch {
    func setup()
    func draw()
}

@IBDesignable open class Sketch: UIView {
    weak var delegate: SketchDelegate?
    var rect: CGRect = CGRect()
    var width: CGFloat = 0
    var height: CGFloat = 0
    
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
        self.width = rect.width
        self.height = rect.height
        self.rect = rect
        delegate?.draw()
    }
    
}
