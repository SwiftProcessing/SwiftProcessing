import Foundation
import CoreGraphics
import UIKit

extension Sketch{
    
    open func canvasSize(_ width: CGFloat, _ height: CGFloat){
        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: width, height: height)
    }
    open func canvasPosition(_ x: CGFloat, _ y: CGFloat){
        self.frame = CGRect(x: x, y: y, width: self.frame.width, height: self.frame.height)
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
        var currentTranslationX = context!.ctm.tx / UIScreen.main.scale
        var currentTranslationY = -(context?.ctm.ty)! / UIScreen.main.scale + frame.height
        s.frame = CGRect(x: currentTranslationX, y: currentTranslationY, width: s.frame.width, height: s.frame.height)
        self.addSubview(s)
    }
}
