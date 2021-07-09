/*
 * SwiftProcessing: Canvas
 *
 * */

import Foundation
import CoreGraphics
import UIKit

extension Sketch{
    
    open func createCanvas<T: Numeric>(_ x: T, _ y: T, _ width: T, _ height: T){
        var cg_x, cg_y, cg_width, cg_height: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        cg_width = width.convert()
        cg_height = height.convert()
        // Changing to true. isOpaque can improve performance.
        self.isOpaque = true
        self.frame = CGRect(x: cg_x, y: cg_y, width: cg_width, height: cg_height)
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
