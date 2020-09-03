import Foundation
import UIKit

open class UIKitViewElement: NSObject{
    open var id: String = UUID().uuidString
    open var x: CGFloat = 0
    open var y: CGFloat = 0
    open var width: CGFloat = 0
    open var height: CGFloat = 0
    open var element: UIView!
    open var sketch: Sketch!
    
    init(_ view: Sketch, _ element: UIView) {
        self.element = element
        view.addSubview(element)
        element.layer.anchorPoint = CGPoint(x: 0,y: 0)
        sketch = view
    }
    
    open func borderColor(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255){
        self.element.layer.borderColor = CGColor(srgbRed: v1 / 255, green: v2 / 255, blue: v3 / 255, alpha: a / 255)
    }
    
    open func borderWidth(_ w: CGFloat){
        self.element.layer.borderWidth = w
    }
    
    open func backgroundColor(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255){
        self.element.layer.backgroundColor = CGColor(srgbRed: v1 / 255, green: v2 / 255, blue: v3 / 255, alpha: a / 255)
    }
   
    open func opacity(_ o: CGFloat){
        self.element.layer.opacity = Float(o)
    }
    
    open func cornerRadius(_ r: CGFloat){
        self.element.layer.cornerRadius = r
    }
    
    open func size(_ w: CGFloat, _ h: CGFloat){
        element.frame = CGRect(x: element.frame.minX, y: element.frame.minY, width: w, height: h)
    }
    
    open func position(_ x: CGFloat, _ y: CGFloat){
        element.layer.position = CGPoint(x: x, y: y)
    }
    
    open func hide(){
        element.isHidden = true
    }
    
    open func show(){
        element.isHidden = false
    }
    
    open func remove(){
        element.removeFromSuperview()
    }
}
