import Foundation
import UIKit

open class UIKitControlElement : UIKitViewElement{
    open var touchUpAction: () -> Void = {}
    open var touchDownAction: () -> Void = {}
    open var valueChangedAction: () -> Void = {}

    override init(_ view: Sketch, _ element: UIView) {
        super.init(view, element)
        (element as! UIControl).addTarget(self, action: #selector(touchUpInsideHelper(_:)), for: .touchUpInside)
        (element as! UIControl).addTarget(self, action: #selector(touchDownHelper(_:)), for: .touchDown)
        (element as! UIControl).addTarget(self, action: #selector(valueChangedHelper(_:)), for: .valueChanged)
    }
    
    @objc func touchUpInsideHelper(_ sender: UIView) {
       touchUpAction()
    }
    
    @objc func touchDownHelper(_ sender: UIView) {
       touchDownAction()
    }
    
    @objc func valueChangedHelper(_ sender: UIView) {
        valueChangedAction()
    }
    
    open func touchStarted(_ touchDownClosure: @escaping () -> Void){
        self.touchDownAction = touchDownClosure
    }
    
    open func touchEnded(_ touchUpClosure: @escaping () -> Void){
        self.touchUpAction = touchUpClosure
    }
    
    open func valueChanged(_ valueChangedClosure: @escaping () -> Void){
        self.valueChangedAction = valueChangedClosure
    }
  
}
