
import Foundation
import UIKit

open class Slider: UIKitControlElement {
    
    let THUMB_SIZE: CGFloat = 32
    
    init(_ view: Sketch, _ min: Float, _ max: Float, _ value: Float?) {
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
    
    open func thumbColor(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255){
        (element as! UISlider).thumbTintColor = UIColor(red: v1 / 255, green: v2 / 255, blue: v3 / 255, alpha: a / 255)
    }
    
    open func thumbImage(_ i: Image, _ resize: Bool = true){
        if resize && (i.width != THUMB_SIZE || i.height != THUMB_SIZE){
            i.resize(THUMB_SIZE, THUMB_SIZE)
        }
        (element as! UISlider).setThumbImage(i.currentFrame(), for: .normal)
    }
    
    open func color(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255){
        minColor(v1, v2, v3, a)
        maxColor(v1, v2, v3, a)
    }
    
    open func minColor(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255){
        (element as! UISlider).minimumTrackTintColor = UIColor(red: v1 / 255, green: v2 / 255, blue: v3 / 255, alpha: a / 255)
    }
    
    open func maxColor(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255){
        (element as! UISlider).maximumTrackTintColor = UIColor(red: v1 / 255, green: v2 / 255, blue: v3 / 255, alpha: a / 255)
    }
    
    
}

extension Sketch{
    open func createSlider(_ min: Float, _ max: Float, _ value: Float? = nil) -> Slider{
        let s = Slider(self, min, max, value)
        viewRefs[s.id] = s
        return s
    }
}
