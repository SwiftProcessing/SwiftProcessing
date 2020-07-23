import Foundation
import UIKit

open class UIKitControlElement : UIKitViewElement, UIGestureRecognizerDelegate{
    open var touchUpAction: () -> Void = {}
    open var touchDownAction: () -> Void = {}
    open var valueChangedAction: () -> Void = {}

    override init(_ view: Sketch, _ element: UIView) {
        super.init(view, element)
        
        (element as! UIControl).addTarget(self, action: #selector(valueChangedHelper(_:)), for: .valueChanged)
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpInsideHelper))
        singleTapGesture.numberOfTapsRequired = 1
        singleTapGesture.delegate = self
        singleTapGesture.cancelsTouchesInView = false
        element.addGestureRecognizer(singleTapGesture)
            
    }
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
          if (touch.view as? UIControl) != nil{
              return true
          }else{
              return false
          }
      }
    
    @objc func touchUpInsideHelper(_ sender: UIView) {
       touchUpAction()
    }
    
    @objc func valueChangedHelper(_ sender: UIView) {
        valueChangedAction()
    }
    
   
    open func touchEnded(_ touchUpClosure: @escaping () -> Void){
        self.touchUpAction = touchUpClosure
    }
    
    open func tapped(_ touchUpClosure: @escaping () -> Void){
        self.touchUpAction = touchUpClosure
    }
    
    open func valueChanged(_ valueChangedClosure: @escaping () -> Void){
        self.valueChangedAction = valueChangedClosure
    }
  
}
