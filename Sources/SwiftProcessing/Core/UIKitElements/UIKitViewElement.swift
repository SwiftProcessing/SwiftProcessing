/*
 * SwiftProcessing: UIKitViewElement
 *
 * A simplified interface for modifying the layer and visibility
 * of a UIKit element for SwiftProcessing
 *
 * */

import Foundation
import UIKit

// =======================================================================
// MARK: - UIKitViewElement Class
// =======================================================================

open class UIKitViewElement: NSObject{
    
    /*
     * MARK: - PROPERTIES
     */
    
    open var id: String = UUID().uuidString
    
    open var x: Double {
         get {
            return Double(self.element.layer.position.x)
         }
         set(x) {
            element.layer.position.x = CGFloat(x)
         }
     }
    
    open var y: Double {
        get {
           return Double(self.element.layer.position.y)
        }
        set(y) {
           element.layer.position.y = CGFloat(y)
        }
    }
    
    open var width: Double  {
        get {
            return Double(self.element.layer.frame.width)
        }
        set(width) {
            let frame = element.layer.frame
            element.layer.frame = CGRect(x: frame.minX, y: frame.minY, width: CGFloat(width), height: frame.height)
        }
    }
    
    open var height: Double  {
        get {
           return Double(self.element.layer.position.x)
        }
        set(height) {
            let frame = element.layer.frame
            element.layer.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: CGFloat(height))
        }
    }
    
    open var element: UIView!
    
    open var sketch: Sketch!
    
    /*
     * MARK: - INIT
     */
    
    init(_ view: Sketch, _ element: UIView) {
        self.element = element
        view.addSubview(element)
        element.layer.anchorPoint = CGPoint(x: 0,y: 0)
        sketch = view
    }
    
    /*
     * MARK: - METHODS
     */
    
    /// Sets the border color with red, green, blue, and, optionally, alpha values.
    ///
    /// - Parameters:
    ///     - gray: A gray value between 0–255.
    ///     - a: An optional alpha value from 0–255. Defaults to 255.
    

    open func borderColor<G: Numeric, A: Numeric>(_ gray: G, _ alpha: A = A(255)){
        var cg_gray, cg_a: CGFloat
        cg_gray = gray.convert()
        cg_a = alpha.convert()
        
        self.element.layer.borderColor = CGColor(srgbRed: cg_gray / 255, green: cg_gray / 255, blue: cg_gray / 255, alpha: cg_a / 255)
    }
    
    /// Sets the border color with red, green, blue, and, optionally, alpha values.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0–255.
    ///     - v2: A green value from 0–255.
    ///     - v3: A blue value from 0–255.
    ///     - a: An optional alpha value from 0–255. Defaults to 255.
    

    open func borderColor<V1: Numeric, V2: Numeric, V3: Numeric, A: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3, _ alpha: A = A(255)){
        var cg_v1, cg_v2, cg_v3, cg_a: CGFloat
        cg_v1 = v1.convert()
        cg_v2 = v2.convert()
        cg_v3 = v3.convert()
        cg_a = alpha.convert()
        
        self.element.layer.borderColor = CGColor(srgbRed: cg_v1 / 255, green: cg_v2 / 255, blue: cg_v3 / 255, alpha: cg_a / 255)
    }
    
    /// Sets the border width. Borders expand from the border on both sides.
    ///
    /// - Parameters:
    ///     - w: width of border.
    
    open func borderWidth<T: Numeric>(_ width: T){
        let cg_w:CGFloat = width.convert()
        self.element.layer.borderWidth = cg_w
    }
    
    /// Sets the background color with red, green, blue, and, optionally, alpha values.
    ///
    /// - Parameters:
    ///     - gray: A gray value between 0–255.
    ///     - a: An optional alpha value from 0–255. Defaults to 255.
    
    open func backgroundColor<G: Numeric, A: Numeric>(_ gray: G, _ alpha: A = A(255)){
        var cg_gray, cg_a: CGFloat
        cg_gray = gray.convert()
        cg_a = alpha.convert()
        
        self.element.layer.backgroundColor = CGColor(srgbRed: cg_gray / 255, green: cg_gray / 255, blue: cg_gray / 255, alpha: cg_a / 255)
    }
    
    /// Sets the background color with red, green, blue, and, optionally, alpha values.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255.
    ///     - v2: A green value from 0-255.
    ///     - v3: A blue value from 0-255.
    ///     - a: An optional alpha value from 0-255. Defaults to 255.
    
    open func backgroundColor<T: Numeric>(_ v1: T, _ v2: T, _ v3: T, _ alpha: T = T(255)){
        var cg_v1, cg_v2, cg_v3, cg_a: CGFloat
        cg_v1 = v1.convert()
        cg_v2 = v2.convert()
        cg_v3 = v3.convert()
        cg_a = alpha.convert()
        
        self.element.layer.backgroundColor = CGColor(srgbRed: cg_v1 / 255, green: cg_v2 / 255, blue: cg_v3 / 255, alpha: cg_a / 255)
    }
   
    /// Sets the opacity.
    ///
    /// - Parameters:
    ///     - o: Opacity value from 0 to 1.0, 1.0 being completely opaque.
    
    open func opacity<O: Numeric>(_ opacity: O){
        let f_o: Float = opacity.convert()
        
        self.element.layer.opacity = f_o
    }
    
    /// Sets the corner radius, which affects the rounding of corners.
    ///
    /// - Parameters:
    ///     - r: A positive value will round the corners.
    
    open func cornerRadius<R: Numeric>(_ radius: R){
        let cg_r: CGFloat = radius.convert()
        
        self.element.layer.cornerRadius = cg_r
    }
    
    /// Sets the size of the element.
    ///
    /// - Parameters:
    ///     - w: Width of the element.
    ///     - h: Height of the element.

    open func size<W: Numeric, H: Numeric>(_ width: W, _ height: H){
        var cg_w, cg_h: CGFloat
        cg_w = width.convert()
        cg_h = height.convert()
        
        let s = sketch.scale
        element.frame = CGRect(x: element.frame.minX, y: element.frame.minY, width: cg_w * CGFloat(s.x), height: cg_h * CGFloat(s.y))
    }
    
    /// Sets the position of the element.
    ///
    /// - Parameters:
    ///     - x: Width of the element.
    ///     - y: Height of the element.
    
    open func position<W: Numeric, H: Numeric>(_ x: W, _ y: H){
        var cg_x, cg_y: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        
        let t = sketch.translation
        element.layer.position = CGPoint(x: cg_x + CGFloat(t.x) , y: cg_y + CGFloat(t.y))
    }
    
    /// Hides the element.

    open func hide(){
        element.isHidden = true
    }
    
    /// Shows the element.
    
    open func show(){
        element.isHidden = false
    }
    
    /// Removes the element from the view. This can be seen as erasing.
    
    open func remove(){
        element.removeFromSuperview()
    }
}
