
import Foundation
import UIKit

open class Switch: UIKitControlElement {
    init(_ view: UIView) {
        let s = UISwitch()
        super.init(view, s)
    }
    
    open func on(){
        return (element as! UISwitch).setOn(true, animated: false)
    }
    
    open func off(){
        return (element as! UISwitch).setOn(false, animated: false)
    }
    
    open func isOn() -> Bool{
        return (element as! UISwitch).isOn
    }
}

extension Sketch{
    open func createSwitch() -> Switch{
        let s = Switch(self)
        viewRefs[s.id] = s
        return s
    }
}
