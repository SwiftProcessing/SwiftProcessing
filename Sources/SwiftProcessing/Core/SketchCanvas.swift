import Foundation
import CoreGraphics
import UIKit

extension Sketch{
    
    open func createCanvas(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat){
        self.isOpaque = false
        self.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    open func addSketch(_ s: UIView){
        addSketchHelper(self.superview, s)
    }
    
    func addSketchHelper(_ p: UIView?, _ s: UIView){
        if p?.superview == nil{
            p?.addSubview(s)
        }else{
            addSketchHelper(p?.superview!, s)
        }
    }
    
    open func addChildSketch(_ s: Sketch){
        self.addSubview(s)
    }
}
