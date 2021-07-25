/*
 * SwiftProcessing: Slider
 *
 *
 * */

import Foundation
import UIKit

// =======================================================================
// MARK: - Slider Class
// =======================================================================

open class Slider : UIKitControlElement, LabelControl {
    
    
    /*
     * MARK: - LABEL PROTOCOL FUNCTIONS
     */
    
    func setText(_ text: String) {
        self.label.text(text)
    }
    
    func setFontSize<S>(_ size: S) where S : Numeric {
        self.label.fontSize(size)
    }
    
    func setTextAlignment(_ alignment: TextAlignment) {
        self.label.textAlignment(alignment)
    }
    
    func setTextColor<V1, V2, V3, A>(_ v1: V1, _ v2: V2, _ v3: V3, _ alpha: A) where V1 : Numeric, V2 : Numeric, V3 : Numeric, A : Numeric {
        let cg_v1, cg_v2, cg_v3, cg_alpha: CGFloat
        cg_v1 = v1.convert()
        cg_v2 = v2.convert()
        cg_v3 = v3.convert()
        cg_alpha = alpha.convert()
        
        self.label.textColor(cg_v1, cg_v2, cg_v3, cg_alpha)
    }
    
    func setTextColor<V1, V2, V3>(_ v1: V1, _ v2: V2, _ v3: V3) where V1 : Numeric, V2 : Numeric, V3 : Numeric {
        let cg_v1, cg_v2, cg_v3: CGFloat
        cg_v1 = v1.convert()
        cg_v2 = v2.convert()
        cg_v3 = v3.convert()
        
        self.label.textColor(cg_v1, cg_v2, cg_v3)
    }
    
    func setTextColor<G, A>(_ gray: G, _ alpha: A) where G : Numeric, A : Numeric {
        let cg_gray, cg_alpha: CGFloat
        cg_gray = gray.convert()
        cg_alpha = alpha.convert()
        
        self.label.textColor(cg_gray, cg_alpha)
    }
    
    func setTextColor<G>(_ gray: G) where G : Numeric {
        let cg_gray: CGFloat
        cg_gray = gray.convert()
        
        self.label.textColor(cg_gray)
    }
    
    
    /*
     * MARK: - CONSTANTS
     */
    
    let THUMB_SIZE: CGFloat = 32
    
    /*
     * MARK: - PROPERTIES
     */
    
    open var label: Label!
    
    // Added these overrides to update the label position.
    // Unsure whether there's a better way to do this.
    // For example, is possible to add the label to the slider's
    // view hierarchy to avoid this kind of setting and getting?
    
    override open var x: Double {
        get {
            return Double(self.element.layer.position.x)
        }
        set(x) {
            element.layer.position.x = CGFloat(x)
            self.label.position(CGFloat(x), element.layer.position.y + 20)
        }
    }
    
    override open var y: Double {
        get {
            return Double(self.element.layer.position.y)
        }
        set(y) {
            element.layer.position.y = CGFloat(y)
            self.label.position(element.layer.position.x, CGFloat(y) + 20)
        }
    }
    
    // Keeping here in case slider values ever want to be changed to be accessed by property instead of method. p5.js and Processing both use methods.
    
    /*
     open var value: Double {
     get {
     return Double((self.element as! UISlider).value)
     }
     set(value) {
     (self.element as! UISlider).value = Float(value)
     }
     }
     */
    
    /*
     * MARK: - INIT
     */
    
    init<MIN: Numeric, MAX: Numeric, V: Numeric>(_ view: Sketch, _ min: MIN, _ max: MAX, _ value: V?) {
        var f_min, f_max: Float
        f_min = min.convert()
        f_max = max.convert()
        
        let slider = UISlider()
        slider.minimumValue = f_min
        slider.maximumValue = f_max
        if let f_value: Float = value?.convert() {
            slider.value = f_value
        }
        
        super.init(view, slider)
        
        label = Label(view, self.x, self.y, width, height)
        
        // Set default size values.
        x = 50.0
        y = 17.0
        width = 100.0
        height = 34.0
    }
    
    /*
     * MARK: - METHODS
     */
    
    /// Returns the value of the slider.
    
    open func value() -> Double{
        return Double((self.element as! UISlider).value)
    }
    
    /// Sets the value of the slider.
    ///
    /// - Parameters:
    ///     - value: value to set the slider to.
    
    open func value<V: Numeric>(_ value: V){
        let f_value: Float = value.convert()
        
        (self.element as! UISlider).value = f_value
    }
    
    /// Sets the thumb color.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255.
    ///     - v2: A green value from 0-255.
    ///     - v3: A blue value from 0-255.
    ///     - a: An optional alpha value from 0-255. Defaults to 255.
    
    open func thumbColor<V1: Numeric, V2: Numeric, V3: Numeric, A: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3, _ a: A = A(255)){
        let cg_v1, cg_v2, cg_v3, cg_a: CGFloat
        cg_v1 = v1.convert()
        cg_v2 = v2.convert()
        cg_v3 = v3.convert()
        cg_a = a.convert()
        
        (self.element as! UISlider).thumbTintColor = UIColor(red: cg_v1 / 255, green: cg_v2 / 255, blue: cg_v3 / 255, alpha: cg_a / 255)
    }
    
    /// Sets the thumb image.
    ///
    /// - Parameters:
    ///     - image: A SwiftProcessing Image object.
    ///     - resize: A boolean value that either resizes or keeps the existing image size. Defaults to `true`.
    
    open func thumbImage(_ i: Image, _ resize: Bool = true){
        if resize && (i.width != Double(THUMB_SIZE) || i.height != Double(THUMB_SIZE)){
            i.resize(THUMB_SIZE, THUMB_SIZE)
        }
        (self.element as! UISlider).setThumbImage(i.currentFrame(), for: .normal)
    }
    
    /// Sets the color of the slider bar uniformly.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255.
    ///     - v2: A green value from 0-255.
    ///     - v3: A blue value from 0-255.
    ///     - a: An optional alpha value from 0-255. Defaults to 255.
    
    open func color<V1: Numeric, V2: Numeric, V3: Numeric, A: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3, _ a: A = A(255)){
        let cg_v1, cg_v2, cg_v3, cg_a: CGFloat
        cg_v1 = v1.convert()
        cg_v2 = v2.convert()
        cg_v3 = v3.convert()
        cg_a = a.convert()
        
        minColor(cg_v1, cg_v2, cg_v3, cg_a)
        maxColor(cg_v1, cg_v2, cg_v3, cg_a)
    }
    
    /// Sets the min side's color.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255.
    ///     - v2: A green value from 0-255.
    ///     - v3: A blue value from 0-255.
    ///     - a: An optional alpha value from 0-255. Defaults to 255.
    
    open func minColor<V1: Numeric, V2: Numeric, V3: Numeric, A: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3, _ a: A = A(255)){
        let cg_v1, cg_v2, cg_v3, cg_a: CGFloat
        cg_v1 = v1.convert()
        cg_v2 = v2.convert()
        cg_v3 = v3.convert()
        cg_a = a.convert()
        
        (self.element as! UISlider).minimumTrackTintColor = UIColor(red: cg_v1 / 255, green: cg_v2 / 255, blue: cg_v3 / 255, alpha: cg_a / 255)
    }
    
    /// Sets the max side's color.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255.
    ///     - v2: A green value from 0-255.
    ///     - v3: A blue value from 0-255.
    ///     - a: An optional alpha value from 0-255. Defaults to 255.
    
    open func maxColor<V1: Numeric, V2: Numeric, V3: Numeric, A: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3, _ a: A = A(255)){
        let cg_v1, cg_v2, cg_v3, cg_a: CGFloat
        cg_v1 = v1.convert()
        cg_v2 = v2.convert()
        cg_v3 = v3.convert()
        cg_a = a.convert()
        
        (self.element as! UISlider).maximumTrackTintColor = UIColor(red: cg_v1 / 255, green: cg_v2 / 255, blue: cg_v3 / 255, alpha: cg_a / 255)
    }
}

// =======================================================================
// MARK: - SwiftProcessing Method to Programmatically Create a Slider
// =======================================================================


extension Sketch{
    
    /// Creates a slider programmatically.
    ///
    /// - Parameters:
    ///     - min: The minimum setting of the slider.
    ///     - max: The maximum setting of the slider.
    
    open func createSlider<MIN: Numeric, MAX: Numeric>(_ min: MIN, _ max: MAX) -> Slider {
        let s = Slider(self, min, max, Optional<Double>.none)
        viewRefs[s.self.id] = s.self
        return s
    }
    
    /// Creates a slider programmatically.
    ///
    /// - Parameters:
    ///     - min: The minimum setting of the slider.
    ///     - max: The maximum setting of the slider.
    ///     - value: The value the slider starts at. Defaults to `nil`
    
    open func createSlider<MIN: Numeric, MAX: Numeric, V: Numeric>(_ min: MIN, _ max: MAX, _ value: V) -> Slider {
        let s = Slider(self, min, max, value)
        viewRefs[s.self.id] = s.self
        return s
    }
}

