import Foundation
import UIKit

open class TextField: UIKitControlElement {
    
    init(_ view: Sketch, _ title: String) {
        let textField = UITextField()
        textField.placeholder = title
        textField.sizeToFit()
        super.init(view, textField)
    }
    
    open func textColor(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat){
        (self.element as? UITextField)?.textColor = UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a / 255)
    }
    
    open func textFont(_ name: String){
        (self.element as! UITextField).font = UIFont(name: name, size: (self.element as! UITextField).font!.pointSize)
    }
    
    open func textSize(_ size: CGFloat){
        (self.element as! UITextField).font = UIFont(name: (self.element as! UITextField).font!.fontName, size: size)
    }
    
    open func text() -> String {
        return (self.element as! UITextField).text ?? ""
    }
}

extension Sketch{
    open func createTextField(_ t: String = "") -> TextField{
        let t = TextField(self, t)
        viewRefs[t.id] = t
        return t
    }
}
