import Foundation
import UIKit

open class UIKitControlElement : UIKitViewElement{
    open var touchUpAction: () -> Void = {}
    open var touchDownAction: () -> Void = {}

    override init(_ view: UIView, _ element: UIView) {
        super.init(view, element)
        (element as! UIControl).addTarget(self, action: #selector(touchUpInsideHelper(_:)), for: .touchUpInside)
        (element as! UIControl).addTarget(self, action: #selector(touchDownHelper(_:)), for: .touchDown)
    }
    
    @objc func touchUpInsideHelper(_ sender: UIView) {
       touchUpAction()
    }
    
    @objc func touchDownHelper(_ sender: UIView) {
       touchDownAction()
    }
    
    open func touchStarted(_ touchUpClosure: @escaping () -> Void){
        self.touchUpAction = touchUpClosure
    }
    
    open func touchEnded(_ touchDownClosure: @escaping () -> Void){
        self.touchDownAction = touchDownClosure
    }
  
}
