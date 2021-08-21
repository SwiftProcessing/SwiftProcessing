/*
 * SwiftProcessing: Stepper
 *
 *
 * */


import Foundation
import UIKit

public extension Sketch {
    class Stepper: UIKitControlElement {
        
        init(_ view: Sketch, _ min: Float, _ max: Float, _ value: Float?, _ step: Float?) {
            let stepper = UIStepper()
            stepper.minimumValue = Double(min)
            stepper.maximumValue = Double(max)
            if let v = value{
                stepper.value = Double(v)
            }
            if let s = step{
                stepper.stepValue = Double(s)
            }
            super.init(view, stepper)
        }
        
        open func value() -> Double{
            return (element as! UIStepper).value
        }
        
        open func value(_ v: Double){
            (element as! UIStepper).value = v
        }
        
        open func plusImage(_ i: Image){
            (self.element as! UIStepper).setIncrementImage(i.currentFrame(), for: .normal)
        }
        
        open func minusImage(_ i: Image){
            (self.element as! UIStepper).setDecrementImage(i.currentFrame(), for: .normal)
        }
    }
    
    func createStepper(_ min: Float, _ max: Float, _ value: Float? = nil, _ step: Float? = nil) -> Stepper{
        let s = Stepper(self, min, max, value, step)
        viewRefs[s.id] = s
        return s
    }
}
