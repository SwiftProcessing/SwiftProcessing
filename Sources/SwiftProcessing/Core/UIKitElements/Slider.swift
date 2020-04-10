
import Foundation
import UIKit

open class Slider: UIKitControlElement {
    init(_ view: UIView, _ min: Float, _ max: Float, _ value: Float?) {
        let slider = UISlider()
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        if let v = value{
            slider.value = Float(v)
        }
        super.init(view, slider)
    }
    
    open func value() -> Float{
        return (element as! UISlider).value
    }
    
    open func value(_ v: Float){
        (element as! UISlider).value = v
    }
}

extension Sketch{
    open func createSlider(_ min: Float, _ max: Float, _ value: Float? = nil) -> Slider{
        let s = Slider(self, min, max, value)
        viewRefs[s.id] = s
        return s
    }
}
