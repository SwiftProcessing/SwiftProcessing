import UIKit

public extension Sketch{
    //TODO support arc function
    //    func arc(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat, _ start: CGFloat, _ stop: CGFloat){
    //
    //    }
    
    func ellipse(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat = -1 ){
        var height = h
        if h == -1 {
            height = w
        }
        let path = UIBezierPath(ovalIn: CGRect(x: x, y: y, width: w, height: height))
        path.fill()
    }
    
    func circle(_ x: CGFloat, _ y: CGFloat, _ d: CGFloat){
        ellipse(x, y, d, d)
    }
    
    func line(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat){
        let path: UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: x1, y: y1));
        path.addLine(to: CGPoint(x: x2, y: y2));
    }
}

