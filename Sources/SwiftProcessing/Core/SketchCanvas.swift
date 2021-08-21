/*
 * SwiftProcessing: Canvas
 *
 * */

import Foundation
import CoreGraphics
import UIKit

extension Sketch{
    
    /// Create a new canvas. Sets the size of the canvas that SwiftProcessing will draw to.
    
    open func createCanvas<X: Numeric, Y: Numeric, W: Numeric, H: Numeric>(_ x: X, _ y: Y, _ width: W, _ height: H){
        var cg_x, cg_y, cg_width, cg_height: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        cg_width = width.convert()
        cg_height = height.convert()
        // Changing to true. isOpaque can improve performance.
        self.isOpaque = true
        self.frame = CGRect(x: cg_x, y: cg_y, width: cg_width, height: cg_height)
    }
    
    /// Add a new view to the current sketch. Useful if you need to add another view into your current SwiftProcessing sketch.
    
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
    
    /// Add a new sketch to the current sketch. Useful if combining multiple SwiftProcessing sketches into a single view.
    
    open func addChildSketch(_ s: Sketch){
        self.addSubview(s)
    }
}
