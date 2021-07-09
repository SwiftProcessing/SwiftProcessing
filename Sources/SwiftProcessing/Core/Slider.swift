
import Foundation
import UIKit

open class Slider {
    
    // Removed subclassing. Making the attachment to UIKit a bit more internal so that we can use Doubles instead of CGFloats.
    
    var uiKitInterface: UIKitControlElement!
    
    // Adding x, y, width, and height along with setters and getters.
    // These will correspond to element as! UISlider).frame's minX, maxX, minY, maxY
    
    open var x: Double {
        get {
            return Double(uiKitInterface.element.layer.frame.minX)
        }
        set (x){
            uiKitInterface.element.layer.frame = CGRect(x: x, y: self.y, width: self.width, height: self.height)
        }
    }
    
    open var y: Double {
        get {
            return Double(uiKitInterface.element.layer.frame.minY)
        }
        set (y){
            uiKitInterface.element.layer.frame = CGRect(x: self.x, y: y, width: self.width, height: self.height)
        }
    }
    
    open var width: Double {
        get {
            return Double(uiKitInterface.element.layer.frame.width)
        }
        set (width){
            uiKitInterface.element.layer.frame = CGRect(x: self.x, y: self.y, width: width, height: self.height)
        }
    }
    
    open var height: Double {
        get {
            return Double(uiKitInterface.element.layer.frame.height)
        }
        set (height){
            uiKitInterface.element.layer.frame = CGRect(x: self.x, y: self.y, width: self.width, height: height)
        }
    }
    
    open var value: Double {
        get {
            return Double((uiKitInterface.element as! UISlider).value)
        }
        set(value) {
            (uiKitInterface.element as! UISlider).value = Float(value)
        }
    }
    
    let THUMB_SIZE: CGFloat = 32
    
    init(_ view: Sketch, _ min: Float, _ max: Float, _ value: Float?) {
        
        let slider = UISlider()
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        if let v = value{
            slider.value = Float(v)
        }
        uiKitInterface = UIKitControlElement(view, slider)
        
        // Set default size values.
        self.x = 50.0
        self.y = 17.0
        self.width = 100.0
        self.height = 34.0
    }
    
    // A Processing user/beginner programmer would expect attributes to return values,
    // not methods. Recommend complete removal, but leaving them in commented out.
    
    /*
    open func value() -> Double{
        return Double((uiKitInterface.element as! UISlider).value)
    }

    open func value(_ v: Double){
        (uiKitInterface.element as! UISlider).value = Float(v)
    }
    */
    
    open func thumbColor(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255){
        (uiKitInterface.element as! UISlider).thumbTintColor = UIColor(red: v1 / 255, green: v2 / 255, blue: v3 / 255, alpha: a / 255)
    }
    
    open func thumbImage(_ i: Image, _ resize: Bool = true){
        if resize && (i.width != Double(THUMB_SIZE) || i.height != Double(THUMB_SIZE)){
            i.resize(THUMB_SIZE, THUMB_SIZE)
        }
        (uiKitInterface.element as! UISlider).setThumbImage(i.currentFrame(), for: .normal)
    }
    
    open func color(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255){
        minColor(v1, v2, v3, a)
        maxColor(v1, v2, v3, a)
    }
    
    open func minColor(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255){
        (uiKitInterface.element as! UISlider).minimumTrackTintColor = UIColor(red: v1 / 255, green: v2 / 255, blue: v3 / 255, alpha: a / 255)
    }
    
    open func maxColor(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255){
        (uiKitInterface.element as! UISlider).maximumTrackTintColor = UIColor(red: v1 / 255, green: v2 / 255, blue: v3 / 255, alpha: a / 255)
    }
    
    
}

extension Sketch{
    open func createSlider(_ min: Float, _ max: Float, _ value: Float? = nil) -> Slider{
        let s = Slider(self, min, max, value)
        viewRefs[s.uiKitInterface.id] = s.uiKitInterface
        return s
    }
    
    open func createSlider(_ min: Double, _ max: Double, _ value: Double? = nil) -> Slider{
        let s = Slider(self, Float(min), Float(max), Float(value!))
        viewRefs[s.uiKitInterface.id] = s.uiKitInterface
        return s
    }
}
