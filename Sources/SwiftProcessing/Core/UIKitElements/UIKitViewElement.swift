import Foundation
import UIKit

open class UIKitViewElement{
    open var x: CGFloat = 0
    open var y: CGFloat = 0
    open var width: CGFloat = 0
    open var height: CGFloat = 0
    open var element: UIView!
    
    init(_ view: UIView, _ element: UIView) {
        self.element = element
        view.addSubview(element)
    }
    
    open func size(_ w: CGFloat, _ h: CGFloat){
        element.frame = CGRect(x: element.frame.minX, y: element.frame.minY, width: w, height: h)
    }
       
    open func position(_ x: CGFloat, _ y: CGFloat){
        element.frame = CGRect(x: x, y: y, width: element.frame.width, height: element.frame.height)
    }
}
