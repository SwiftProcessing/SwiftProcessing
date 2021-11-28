/*
 * SwiftProcessing: Color
 *
 * */

import UIKit

/*
 * MARK: - UICOLOR EXTENSION FOR PLAYGROUND LITERAL COLOR SUPPORT
 */

// Source: https://theswiftdev.com/uicolor-best-practices-in-swift/

public extension UIColor {
    // Only used internally, so no need to use Doubles.
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }
    
    // To better interface with SwiftProcessing
    var rgba255: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r * 255, g * 255, b * 255, a * 255)
    }
    
    var double_rgba: (red: Double, green: Double, blue: Double, alpha: Double) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (Double(r), Double(g), Double(b), Double(a))
    }
    
    var double_rgba255: (red: Double, green: Double, blue: Double, alpha: Double) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (Double(r) * 255, Double(g) * 255, Double(b) * 255, Double(a) * 255)
    }
    
    var hsba: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h, s, b, a)
    }
    
    var hsba360: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h * 360, s * 100, b * 100, a * 100)
    }
    
    var double_hsba360: (hue: Double, saturation: Double, brightness: Double, alpha: Double) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (Double(h * 360), Double(s * 100), Double(b * 100), Double(a * 100))
    }
}


// =======================================================================
// MARK: - EXTENSION: COLOR
// =======================================================================

public extension Sketch {
    
    /*
     * MARK: - COLOR MODE
     *
     * NOTE: This is an ongoing project that will have multiple steps:
     *
     * STEP 1 – Create a global color mode that will enable users to choose between RGB and HSB modes. Ranges will be fixed at first. In the beginning, we'll start with 0-255 for RGB, 0-360 for H, and 0-100 for SB. [COMPLETE]
     * STEP 2 — Expand Color class to have H, S, and B values and convert easily between HSV <-> RGB within the class. [COMPLETE]
     * Algorithms to use: https://en.wikipedia.org/wiki/HSL_and_HSV#From_HSV
     * STEP 3 – Allow users to set the desired ranges, as they can in Processing. [TO DO]
     *
     */
    
    private func colorModeHelper<V1: Numeric, V2: Numeric, V3: Numeric, A: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3, _ a: A) -> Color {
        let cg_v1, cg_v2, cg_v3, cg_a: CGFloat
        cg_v1 = v1.convert(); cg_v2 = v2.convert(); cg_v3 = v3.convert(); cg_a = a.convert()
        
        switch settings.colorMode {
        case .rgb:
            return Color(cg_v1, cg_v2, cg_v3, cg_a, .rgb)
        case .hsb:
            return Color(cg_v1, cg_v2, cg_v3, cg_a, .hsb)
        }
    }
    
    /// Clears the background if there is a color.
    ///
    
    func clear() {
        context?.clear(CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
    }
    
    /*
     * MARK: - BACKGROUND
     */
    
    /// Sets the background color with a UIColor.
    /// This enables Xcode and Swift Playground color literals.
    ///
    /// - Parameters:
    ///     - color: A UIColor value.
    func background(_ color: UIColor) {
        switch settings.colorMode {
        case .rgb:
            background(color.rgba255.red, color.rgba255.green, color.rgba255.blue, color.rgba255.alpha)
        case .hsb:
            background(color.hsba360.hue, color.hsba360.saturation, color.hsba360.brightness, color.hsba360.alpha)
        }
        
    }
    
    /// Sets the background color with a SketchProcessing Color object.
    ///
    /// - Parameters:
    ///     - color: A Color value.
    
    func background(_ color: Color) {
        switch settings.colorMode {
        case .rgb:
            background(color.red, color.green, color.blue, color.alpha)
        case .hsb:
            background(color.hue, color.saturation, color.brightness, color.alpha)
        }
    }
    
    /// Sets the background color with an RGB or HSB value. RGB is the default color mode.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255 (RGB). A hue value from 0-360 (HSB).
    ///     - v2: A green value from 0-255 (RGB). A saturation value from 0-100 (HSB).
    ///     - v3: A blue value from 0-255 (RGB). A brightness value from 0-100 (HSB).
    ///     - a: An optional alpha value from 0-255. Defaults to 255 (RGB). An alpha value from 0-100. Defaults to 255 (HSB). Defaults to 255.
    
    // Note: It's important to understand why we are *coercing* instead of
    // *type casting* in our generics (eg, T(255) in this definition).
    // Here is more information: https://stackoverflow.com/questions/33973724/typecasting-or-initialization-which-is-better-in-swift
    // Type casting causes runtime errors and should be avoided in generics
    // where integers and floating points are both accepted inputs.
    func background<V1: Numeric, V2: Numeric, V3: Numeric, A: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3, _ a: A){
        let cg_v1, cg_v2, cg_v3, cg_a: CGFloat
        cg_v1 = v1.convert()
        cg_v2 = v2.convert()
        cg_v3 = v3.convert()
        cg_a = a.convert()
        
        // Internal operations should never affect the user-facing SwiftProcessing settings state. Only API users should be able to change the settings state. And if we touch Core Graphics, we need to save and restore the state.
        // fill(v1, v2, v3, a) - Leaving this as a reminder. Avoid this approach and manipulate Core Graphics context directly when inside the API.
        context?.saveGState()
        context?.setFillColor(colorModeHelper(cg_v1, cg_v2, cg_v3, cg_a).cgColor())
        internalRect(0, 0, CGFloat(width), CGFloat(height))
        context?.restoreGState()
    }
    
    /// Sets the background color with an RGB or HSB value. RGB is the default color mode.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255 (RGB). A hue value from 0-360 (HSB).
    ///     - v2: A green value from 0-255 (RGB). A saturation value from 0-100 (HSB).
    ///     - v3: A blue value from 0-255 (RGB). A brightness value from 0-100 (HSB).
    ///     - a: An optional alpha value from 0-255. Defaults to 255 (RGB). An alpha value from 0-100. Defaults to 255 (HSB). Defaults to 255.
    
    func background<V1: Numeric, V2: Numeric, V3: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3){
        background(v1, v2, v3, 255.0)
    }
    
    /// Sets the background color with a system color name.
    ///
    /// - Parameters:
    ///     - systemColorName: A standard system color name, eg: .systemRed
    
    func background(_ systemColorName: Color.SystemColor) {
        let systemColor = systemColorName.rawValue
        switch settings.colorMode {
        case .rgb:
            background(systemColor.rgba255.red, systemColor.rgba255.green, systemColor.rgba255.blue, systemColor.rgba255.alpha)
        case .hsb:
            background(systemColor.hsba360.hue, systemColor.hsba360.saturation, systemColor.hsba360.brightness, systemColor.hsba360.alpha)
        }
    }
    
    /// Sets the background color with gray and alpha values.
    ///
    /// - Parameters:
    ///     - v1: A gray value from 0-255.
    ///     - a: An optional alpha value from 0-255. Defaults to 255.
    
    func background<V1: Numeric, A: Numeric>(_ v1: V1, _ a: A) {
        let bg = Color(v1, v1, v1, a, .rgb)
        background(bg)
    }
    
    /// Sets the background color with a single gray value.
    ///
    /// - Parameters:
    ///     - v1: A gray value from 0-255.
    
    func background<V1: Numeric>(_ v1: V1) {
        let bg = Color(v1, v1, v1, 255, .rgb)
        background(bg)
    }
    
    /*
     * MARK: FILL
     */
    
    /// Sets the fill color with a UIColor.
    /// This enables Xcode and Swift Playground color literals.
    ///
    /// - Parameters:
    ///     - color: A UIColor value.
    
    func fill(_ color: UIColor) {
        switch settings.colorMode {
        case .rgb:
            fill(color.rgba255.red, color.rgba255.green, color.rgba255.blue, color.rgba255.alpha)
        case .hsb:
            fill(color.hsba360.hue, color.hsba360.saturation, color.hsba360.brightness, color.hsba360.alpha)
        }
    }
    
    /// Sets the fill color with a SwiftProcessing Color object.
    ///
    /// - Parameters:
    ///     - color: A Color value.
    
    func fill(_ color: Color) {
        switch settings.colorMode {
        case .rgb:
            fill(color.red, color.green, color.blue, color.alpha)
        case .hsb:
            fill(color.hue, color.saturation, color.brightness, color.alpha)
        }
    }
    
    /// Sets the fill color with an RGB or HSB value. RGB is the default color mode.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255 (RGB). A hue value from 0-360 (HSB).
    ///     - v2: A green value from 0-255 (RGB). A saturation value from 0-100 (HSB).
    ///     - v3: A blue value from 0-255 (RGB). A brightness value from 0-100 (HSB).
    ///     - a: An optional alpha value from 0-255. Defaults to 255 (RGB). An alpha value from 0-100. Defaults to 255 (HSB). Defaults to 255.
    
    func fill<V1: Numeric, V2: Numeric, V3: Numeric, A: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3, _ a: A) {
        var cg_v1, cg_v2, cg_v3, cg_a: CGFloat
        cg_v1 = v1.convert()
        cg_v2 = v2.convert()
        cg_v3 = v3.convert()
        cg_a = a.convert()
        
        context?.setFillColor(colorModeHelper(cg_v1, cg_v2, cg_v3, cg_a).cgColor())
        settings.fill = Color(cg_v1, cg_v2, cg_v3, cg_a, settings.colorMode)
    }
    
    /// Sets the fill color with an RGB or HSB value. RGB is the default color mode.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255 (RGB). A hue value from 0-360 (HSB).
    ///     - v2: A green value from 0-255 (RGB). A saturation value from 0-100 (HSB).
    ///     - v3: A blue value from 0-255 (RGB). A brightness value from 0-100 (HSB).
    
    func fill<V1: Numeric, V2: Numeric, V3: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3) {
        fill(v1, v2, v3, 255.0)
    }
    
    /// Sets the fill color with a system color name.
    ///
    /// - Parameters:
    ///     - systemColorName: A standard system color name, eg: .systemRed
    
    func fill(_ systemColorName: Color.SystemColor) {
        let systemColor = systemColorName.rawValue
        
        context?.setFillColor(red: systemColor.rgba255.red, green: systemColor.rgba255.green, blue: systemColor.rgba255.blue, alpha: systemColor.rgba255.alpha)
        settings.fill = Color(systemColor.rgba255.red, systemColor.rgba255.green, systemColor.rgba255.blue, systemColor.rgba255.alpha, .rgb)
    }
    
    /// Sets the fill color with a gray and alpha values.
    ///
    /// - Parameters:
    ///     - v1: A gray value from 0-255.
    ///     - a: An optional alpha value from 0-255. Defaults to 255.
    
    func fill<V1: Numeric, A: Numeric>(_ v1: V1,_ a: A) {
        var cg_v1, cg_a: CGFloat
        cg_v1 = v1.convert()
        cg_a = a.convert()
        
        context?.setFillColor(red: cg_v1 / 255, green: cg_v1 / 255, blue: cg_v1 / 255, alpha: cg_a / 255)
        settings.fill = Color(cg_v1, cg_v1, cg_v1, cg_a, .rgb) // Single arguments always use .rgb range.
    }
    
    /// Sets the fill color with a single gray value.
    ///
    /// - Parameters:
    ///     - v1: A gray value from 0-255.
    
    func fill<V1: Numeric>(_ v1: V1) {
        fill(v1, 255.0)
    }
    
    /// Sets the fill to be completely clear.
    
    func noFill() {
        fill(0.0, 0.0, 0.0, 0.0) // Same in .rgb or .hsb mode
        // For future contributors: Question here about whether to just toggle the fill on or off rather than changing the state of the fill variable.
    }
    
    /*
     * MARK: STROKE
     */
    
    /// Sets the stroke color with a UIColor.
    /// This enables Xcode and Swift Playground color literals.
    ///
    /// - Parameters:
    ///     - color: A UIColor value.
    
    func stroke(_ color: UIColor) {
        switch settings.colorMode {
        case .rgb:
            stroke(color.rgba255.red, color.rgba255.green, color.rgba255.blue, color.rgba255.alpha)
        case .hsb:
            stroke(color.hsba360.hue, color.hsba360.saturation, color.hsba360.brightness, color.hsba360.alpha)
        }
    }
    
    /// Sets the stroke color with a SwiftProcessing Color object.
    ///
    /// - Parameters:
    ///     - color: A Color value.
    
    func stroke(_ color: Color) {
        switch settings.colorMode {
        case .rgb:
            stroke(color.red, color.green, color.blue, color.alpha)
        case .hsb:
            stroke(color.hue, color.saturation, color.brightness, color.alpha)
        }
    }
    
    /// Sets the stroke color with an RGB or HSB value. RGB is the default color mode.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255 (RGB). A hue value from 0-360 (HSB).
    ///     - v2: A green value from 0-255 (RGB). A saturation value from 0-100 (HSB).
    ///     - v3: A blue value from 0-255 (RGB). A brightness value from 0-100 (HSB).
    ///     - a: An optional alpha value from 0-255. Defaults to 255 (RGB). An alpha value from 0-100. Defaults to 255 (HSB). Defaults to 255.
    
    func stroke<V1: Numeric, V2: Numeric, V3: Numeric, A: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3, _ a: A) {
        var cg_v1, cg_v2, cg_v3, cg_a: CGFloat
        cg_v1 = v1.convert()
        cg_v2 = v2.convert()
        cg_v3 = v3.convert()
        cg_a = a.convert()
        
        context?.setStrokeColor(colorModeHelper(cg_v1, cg_v2, cg_v3, cg_a).cgColor())
        settings.stroke = Color(cg_v1, cg_v2, cg_v3, cg_a, settings.colorMode)
    }
    
    /// Sets the stroke color with an RGB or HSB value. RGB is the default color mode.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255 (RGB). A hue value from 0-360 (HSB).
    ///     - v2: A green value from 0-255 (RGB). A saturation value from 0-100 (HSB).
    ///     - v3: A blue value from 0-255 (RGB). A brightness value from 0-100 (HSB).
    
    func stroke<V1: Numeric, V2: Numeric, V3: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3) {
        stroke(v1, v2, v3, 255.0)
    }
    
    /// Sets the stroke color with a system color name.
    ///
    /// - Parameters:
    ///     - systemColorName: A standard system color name, eg: .systemRed
    
    func stroke(_ systemColorName: Color.SystemColor) {
        let systemColor = systemColorName.rawValue
        context?.setStrokeColor(red: systemColor.rgba255.red, green: systemColor.rgba255.green / 255, blue: systemColor.rgba255.blue / 255, alpha: systemColor.rgba255.alpha / 255)
        settings.stroke = Color(systemColor.rgba255.red, systemColor.rgba255.green, systemColor.rgba255.blue, systemColor.rgba255.alpha, .rgb)
    }
    
    /// Sets the fill color with a gray and alpha values.
    ///
    /// - Parameters:
    ///     - v1: A gray value from 0-255.
    ///     - a: An optional alpha value from 0-255. Defaults to 255.
    
    func stroke<V1: Numeric, A: Numeric>(_ v1: V1,_ a: A) {
        var cg_v1, cg_a: CGFloat
        cg_v1 = v1.convert()
        cg_a = a.convert()
        
        context?.setStrokeColor(red: cg_v1 / 255, green: cg_v1 / 255, blue: cg_v1 / 255, alpha: cg_a / 255)
        settings.stroke = Color(cg_v1, cg_v1, cg_v1, cg_a, .rgb) // Single arguments always use .rgb range.
    }
    
    /// Sets the stroke color with a single gray value.
    ///
    /// - Parameters:
    ///     - v1: A gray value from 0-255.
    
    func stroke<V1: Numeric>(_ v1: V1) {
        stroke(v1, 255.0)
    }
    
    /// Sets the stroke to be completely clear.
    
    func noStroke() {
        stroke(0.0, 0.0, 0.0, 0.0)
        // Same question as noFill()
    }
    
    /*
     * MARK: ERASE
     */
    
    /// Sets subsequent shapes drawn to the screen to erase each other.
    
    func erase() {
        context?.setBlendMode(CGBlendMode.clear)
    }
    
    /// Sets the compositing mode to normal.
    
    func noErase() {
        context?.setBlendMode(CGBlendMode.normal)
    }
    
    /*
     * MARK: LERP
     */
    
    /// Blends two colors to find a third color at a point you define between them.
    /// ```
    /// func setup() {
    ///    colorMode(.hsb)
    ///    stroke(255)
    ///    background(51)
    ///    let from = color(218, 165, 32)
    ///    let to = color(72, 61, 139)
    ///    colorMode(.hsb) // Try changing to HSB.
    ///    let interA = lerpColor(from, to, 0.33)
    ///    let interB = lerpColor(from, to, 0.66)
    ///    fill(from)
    ///    rect(10, 20, 20, 60)
    ///    fill(interA)
    ///    rect(30, 20, 20, 60)
    ///    fill(interB)
    ///    rect(50, 20, 20, 60)
    ///    fill(to)
    ///    rect(70, 20, 20, 60)
    /// }
    /// ```
    /// - Parameters:
    ///     - c1: First color. Should be a SwiftProcessing Color type.
    ///     - c2: Second color. Should be a SwiftProcessing Color type.
    ///     - amt: The amoutn to interpolate between two values where 0.0 is the first color and 1.0 is the second color.
    
    func lerpColor<T: Numeric>(_ c1: Color, _ c2: Color, _ amt: T) -> Color {
        
        let newColor: Color?
        
        switch settings.colorMode {
        case .rgb:
            let c1_r = c1.red
            let c1_g = c1.green
            let c1_b = c1.blue
            let c1_a = c1.alpha
            
            let c2_r = c2.red
            let c2_g = c2.green
            let c2_b = c2.blue
            let c2_a = c2.alpha
            
            let cg_amt: CGFloat = amt.convert()
            
            let cnst_amt = constrain(cg_amt, 0.0, 1.0)
            
            newColor = Color(
                lerp(c1_r, c2_r, cnst_amt),
                lerp(c1_g, c2_g, cnst_amt),
                lerp(c1_b, c2_b, cnst_amt),
                lerp(c1_a, c2_a, cnst_amt),
                .rgb
            )
        case .hsb:
            let c1_h = c1.hue
            let c1_s = c1.saturation
            let c1_b = c1.brightness
            let c1_a = c1.alpha
            
            let c2_h = c2.hue
            let c2_s = c2.saturation
            let c2_b = c2.brightness
            let c2_a = c2.alpha
            
            let cg_amt: CGFloat = amt.convert()
            
            let cnst_amt = constrain(cg_amt, 0.0, 1.0)
            
            newColor = Color(
                lerp(c1_h, c2_h, cnst_amt),
                lerp(c1_s, c2_s, cnst_amt),
                lerp(c1_b, c2_b, cnst_amt),
                lerp(c1_a, c2_a, cnst_amt),
                .hsb
            )
        }
        
        return newColor ?? Color(0)
    }
    
    /// Blends two colors using color literals to find a third color at a point you define between them. **Note:** Color literals only work in Playgrounds.
    /// ```
    /// // Note: This example will only work in a Playground.
    ///
    /// func setup() {
    ///     colorMode(.rgb)
    ///     stroke(255)
    ///     background(51)
    ///     let from = color(#colorLiteral(red: 0.8549019608, green: 0.6470588235, blue: 0.1254901961, alpha: 1))
    ///     let to = color(72, 61, 139)
    ///     let to = color(#colorLiteral(red: 0.2823529412, green: 0.2392156863, blue: 0.5450980392, alpha: 1))
    ///     colorMode(.rgb) // Try changing to HSB.
    ///     let interA = lerpColor(from, to, 0.33)
    ///     let interB = lerpColor(from, to, 0.66)
    ///     fill(from)
    ///     rect(10, 20, 20, 60)
    ///     fill(interA)
    ///     rect(30, 20, 20, 60)
    ///     fill(interB)
    ///     rect(50, 20, 20, 60)
    ///     fill(to)
    ///     rect(70, 20, 20, 60)
    /// }
    /// ```
    /// - Parameters:
    ///     - c1: First color. Should be a Playground color literal or a UIColor.
    ///     - c2: Second color. Should be a Playground color literal or a UIColor.
    ///     - amt: The amoutn to interpolate between two values where 0.0 is the first color and 1.0 is the second color.
    
    func lerpColor<T: Numeric>(_ c1: UIColor, _ c2: UIColor, _ amt: T) -> Color {
        return lerpColor(Color(c1), Color(c2), amt)
    }

    /*
     * MARK: COLOR
     */
    
    /// Returns a color object that can be stored in a variable.
    ///
    /// - Parameters:
    ///     - color: A UIColor value.
    
    func color(_ c: UIColor) -> Color {
        switch settings.colorMode {
        case .rgb:
            return Color(c.rgba255.red, c.rgba255.green, c.rgba255.blue, c.rgba255.alpha, .rgb)
        case .hsb:
            return Color(c.hsba360.hue, c.hsba360.saturation, c.hsba360.brightness, c.hsba360.alpha, .hsb)
        }
    }
    
    /// Returns a color object that can be stored in a variable using RGB or HSB values. RGB is the default color mode.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255 (RGB). A hue value from 0-360 (HSB).
    ///     - v2: A green value from 0-255 (RGB). A saturation value from 0-100 (HSB).
    ///     - v3: A blue value from 0-255 (RGB). A brightness value from 0-100 (HSB).
    ///     - a: An optional alpha value from 0-255. Defaults to 255 (RGB). An alpha value from 0-100. Defaults to 255 (HSB). Defaults to 255.
    
    func color<V1: Numeric, V2: Numeric, V3: Numeric, A: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3, _ a: A) -> Color {
        return Color(v1, v2, v3, a, settings.colorMode)
    }
    
    /// Returns a color object that can be stored in a variable using RGB or HSB values. RGB is the default color mode.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255 (RGB). A hue value from 0-360 (HSB).
    ///     - v2: A green value from 0-255 (RGB). A saturation value from 0-100 (HSB).
    ///     - v3: A blue value from 0-255 (RGB). A brightness value from 0-100 (HSB).
    
    func color<V1: Numeric, V2: Numeric, V3: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3) -> Color {
        return Color(v1, v2, v3, 255.0, settings.colorMode)
    }
    
    /// Returns a color object that can be stored in a variable.
    ///
    /// - Parameters:
    ///     - v1: A gray value from 0-255.
    ///     - a: An optional alpha value from 0-255. Defaults to 255.
    
    func color<V1: Numeric, A: Numeric>(_ v1: V1, _ a: A) -> Color {
        return Color(v1, v1, v1, a, .rgb) // Single arguments always use .rgb range.
    }
    
    /// Returns a color object that can be stored in a variable.
    ///
    /// - Parameters:
    ///     - v1: A gray value from 0-255.
    
    func color<V1: Numeric>(_ v1: V1) -> Color {
        return Color(v1, v1, v1, 255.0, .rgb) // Single arguments always use .rgb range.
    }
    
    /// Returns a color object that can be stored in a variable.
    ///
    /// - Parameters:
    ///     - value: hex string for a color.
    
    func color(_ value: String) -> Color {
        return hexStringToUIColor(hex: value)
    }
    
    /*
     * MARK: COMPONENT-WISE COLOR
     */
    
    /// Returns the red value of a SwiftProcessing color object.
    ///
    /// - Parameters:
    ///     - color: A SwiftProcessing color object.
    
    func red(_ color: Color) -> Double {
        return color.red
    }
    
    /// Returns the red value of a color stored in an array
    ///
    /// - Parameters:
    ///     - color: A color stored in an array, e.g. [R, G, B, A].
    
    func red<T: Numeric>(_ color: [T]) -> Double {
        return color[0].convert()
    }
    
    /// Returns the green value of a SwiftProcessing color object.
    ///
    /// - Parameters:
    ///     - color: A SwiftProcessing color object.
    
    func green(_ color: Color) -> Double {
        return color.green
    }
    
    /// Returns the green value of a color stored in an array
    ///
    /// - Parameters:
    ///     - color: A color stored in an array, e.g. [R, G, B, A].
    
    func green<T: Numeric>(_ color: [T]) -> Double {
        return color[1].convert()
    }
    
    /// Returns the blue value of a SwiftProcessing color object.
    ///
    /// - Parameters:
    ///     - color: A SwiftProcessing color object.
    
    func blue(_ color: Color) -> Double {
        return color.blue
    }
    
    /// Returns the blue value of a color stored in an array
    ///
    /// - Parameters:
    ///     - color: A color stored in an array, e.g. [R, G, B, A].
    
    func blue<T: Numeric>(_ color: [T]) -> Double {
        return color[2].convert()
    }
    
    /// Returns the alpha value of a SwiftProcessing color object.
    ///
    /// - Parameters:
    ///     - color: A SwiftProcessing color object.
    
    func alpha(_ color: Color) -> Double {
        return color.alpha
    }
    
    /// Returns the alpha value of a color stored in an array
    ///
    /// - Parameters:
    ///     - color: A color stored in an array, e.g. [R, G, B, A] or [H, S, B, A].
    
    func alpha<T: Numeric>(_ color: [T]) -> Double {
        return color[3].convert()
    }
    
    /// Returns the hue value of a SwiftProcessing color object.
    ///
    /// - Parameters:
    ///     - color: A SwiftProcessing color object.
    
    func hue(_ color: Color) -> Double {
        return color.hue
    }
    
    /// Returns the hue value of a color stored in an array
    ///
    /// - Parameters:
    ///     - color: A color stored in an array, e.g. [H, S, B, A].
    
    func hue<T: Numeric>(_ color: [T]) -> Double {
        return color[0].convert()
    }
    
    /// Returns the saturation value of a SwiftProcessing color object.
    ///
    /// - Parameters:
    ///     - color: A SwiftProcessing color object.
    
    func saturation(_ color: Color) -> Double {
        return color.saturation
    }
    
    /// Returns the saturation value of a color stored in an array
    ///
    /// - Parameters:
    ///     - color: A color stored in an array, e.g. [H, S, B, A].
    
    func saturation<T: Numeric>(_ color: [T]) -> Double {
        return color[1].convert()
    }
    
    /// Returns the brightness value of a SwiftProcessing color object.
    ///
    /// - Parameters:
    ///     - color: A SwiftProcessing color object.
    
    func brightness(_ color: Color) -> Double {
        return color.brightness
    }
    
    /// Returns the brightness value of a color stored in an array
    ///
    /// - Parameters:
    ///     - color: A color stored in an array, e.g. [H, S, B, A].
    
    func brightness<T: Numeric>(_ color: [T]) -> Double {
        return color[2].convert()
    }
    
    // Source: https://stackoverflow.com/questions/24263007/how-to-use-hex-color-values
    private func hexStringToUIColor (hex: String) -> Color {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count) != 6 {
            assertionFailure("Invalid hex color")
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return Color(
            CGFloat((rgbValue & 0xFF0000) >> 16),
            CGFloat((rgbValue & 0x00FF00) >> 8),
            CGFloat(rgbValue & 0x0000FF),
            CGFloat(1.0),
            .rgb
        )
    }
}

// =======================================================================
// MARK: - CLASS: COLOR
// =======================================================================

public extension Sketch {
    class Color {
        
        public static var hueMax:CGFloat = 360
        public static var saturationMax:CGFloat = 100
        public static var brightnessMax:CGFloat = 100
        
        public static var redMax:CGFloat = 255
        public static var greenMax:CGFloat = 255
        public static var blueMax:CGFloat = 255
        
        public static var alphaMax:CGFloat!
        
        public var red: Double
        public var green: Double
        public var blue: Double
        
        public var hue: Double
        public var saturation: Double
        public var brightness: Double
        
        public var alpha: Double
        
        private var mode: ColorMode
        
        public convenience init<V1: Numeric, A: Numeric>(_ v1: V1, _ a: A) {
            self.init(v1, v1, v1, a, .rgb)
        }
        
        public convenience init<V1: Numeric>(_ v1: V1) {
            self.init(v1, v1, v1, 255.0, .rgb)
        }
        
        public convenience init<V1: Numeric, V2: Numeric, V3: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3) {
            self.init(v1, v2, v3, 255.0, .rgb)
        }
        
        public init<V1: Numeric, V2: Numeric, V3: Numeric, A: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3, _ a: A, _ mode: ColorMode = .rgb) {
            self.mode = mode
            
            var d_v1, d_v2, d_v3, d_a: Double
            d_v1 = v1.convert(); d_v2 = v2.convert(); d_v3 = v3.convert(); d_a = a.convert()
            
            // Set everything to zero so we have access to self to use clamp.
            // There may be a more optimized way of doing this.
            self.red = 0; self.green = 0; self.blue = 0; self.alpha = 0; self.hue = 0.0; self.saturation = 0.0; self.brightness = 0.0
            
            switch mode {
            case .rgb:
                // Set RGB
                self.red = clamp(value: d_v1, minimum: 0.0, maximum: Color.redMax)
                self.green = clamp(value: d_v2, minimum: 0.0, maximum: Color.greenMax)
                self.blue = clamp(value: d_v3, minimum: 0.0, maximum: Color.blueMax)
                self.alpha = clamp(value: d_a, minimum: 0.0, maximum: Color.alphaMax ?? 255.0)
                
                // Extract and Set HSB
                // Doesn't feel right to create a temporary UIColor here.
                // For future contributors: Is further optimization necessary/possible here?
                let temp = UIColor(red: CGFloat(self.red / Color.redMax), green: CGFloat(self.green) / Color.greenMax, blue: CGFloat(self.blue / Color.blueMax), alpha: CGFloat(self.alpha / (Color.alphaMax ?? 255.0)))

                self.hue = temp.double_hsba360.hue
                self.saturation = temp.double_hsba360.saturation
                self.brightness = temp.double_hsba360.brightness
                
            case .hsb:
                // Set HSB
                self.hue = clamp(value: d_v1, minimum: 0.0, maximum: Color.hueMax)
                self.saturation = clamp(value: d_v2, minimum: 0.0, maximum: Color.saturationMax)
                self.brightness = clamp(value: d_v3, minimum: 0.0, maximum: Color.brightnessMax)
                self.alpha = clamp(value: d_a, minimum: 0.0, maximum: Color.alphaMax ?? 100.0)
                
                // Extract and Set RGB
                // Doesn't feel right to create a temporary UIColor here.
                // For future contributors: Is further optimization necessary/possible here?
                let temp = UIColor(hue: CGFloat(self.hue / Color.hueMax), saturation: CGFloat(self.saturation / Color.saturationMax), brightness: CGFloat(self.brightness / Color.brightnessMax), alpha: CGFloat(self.alpha / (Color.alphaMax ?? 100)))

                // Extract and Set RGB
                self.red = temp.double_rgba255.red
                self.green = temp.double_rgba255.green
                self.blue = temp.double_rgba255.blue
            }
        }

        
        public init(_ color: UIColor) {
            self.mode = .rgb // RGB will be the default value here. It matters because alpha will range from 0-255.
            
            self.red = color.double_rgba255.red
            self.green = color.double_rgba255.green
            self.blue = color.double_rgba255.blue
            self.alpha = color.double_rgba255.alpha
            
            self.hue = Double(color.hsba360.hue)
            self.saturation = Double(color.hsba.saturation)
            self.brightness = Double(color.hsba.brightness)
        }
        
        func setRed<T: Numeric>(_ red: T) {
            self.red = red.convert()
        }
        
        func setGreen<T: Numeric>(_ green: T) {
            self.green = green.convert()
        }
        
        func setBlue<T: Numeric>(_ blue: T) {
            self.blue = blue.convert()
        }
        
        func setAlpha<T: Numeric>(_ alpha: T) {
            self.alpha = alpha.convert()
        }
        
        func setHue<T: Numeric>(_ hue: T) {
            self.hue = hue.convert()
        }
        
        func setSaturation<T: Numeric>(_ saturation: T) {
            self.saturation = saturation.convert()
        }
        
        func setBrightness<T: Numeric>(_ brightness: T) {
            self.brightness = brightness.convert()
        }
        
        func uiColor() -> UIColor {
            switch mode {
            case .rgb:
                return UIColor(red: self.red.convert() / Color.redMax, green: self.green.convert() / Color.greenMax, blue: self.blue.convert() / Color.blueMax, alpha: self.alpha.convert() / (Color.alphaMax ?? 255.0))
            case .hsb:
                return UIColor(hue: self.hue.convert() / Color.hueMax, saturation: self.saturation.convert() / Color.saturationMax, brightness: self.brightness.convert() / Color.brightnessMax, alpha: self.alpha.convert() / (Color.alphaMax ?? 100.0))
            }
        }
        
        func cgColor() -> CGColor {
            switch mode {
            case .rgb:
                return UIColor(red: self.red.convert() / Color.redMax, green: self.green.convert() / Color.greenMax, blue: self.blue.convert() / Color.blueMax, alpha: self.alpha.convert() / (Color.alphaMax ?? 255.0)).cgColor
            case .hsb:
                return UIColor(hue: self.hue.convert() / Color.hueMax, saturation: self.saturation.convert() / Color.saturationMax, brightness: self.brightness.convert() / Color.brightnessMax, alpha: self.alpha.convert() / (Color.alphaMax ?? 100.0)).cgColor
            }
        }
        
        func toString() -> String {
            return """
                rgba: (\(self.red),\(self.green),\(self.blue),\(self.alpha))
                hsba: (\(self.hue),\(self.saturation),\(self.brightness),\(self.alpha))
                """
        }
        
        func toArrayRGB() -> [Double] {
            return [red, green, blue, alpha]
        }
        
        func toArrayHSB() -> [Double] {
            return [hue, saturation, brightness, alpha]
        }
        
        // https://developer.apple.com/library/archive/samplecode/AppChat/Listings/AppChat_MathUtilities_swift.html#//apple_ref/doc/uid/TP40017298-AppChat_MathUtilities_swift-DontLinkElementID_18
        private func clamp<T: Comparable>(value: T, minimum: T, maximum: T) -> T {
            return Swift.min(Swift.max(value, minimum), maximum)
        }
        
        open func debugPrint() {
            if mode == .rgb {
            print("initialized rgb:\r\n" + self.toString())
            } else {
                print("initialized hsb:\r\n" + self.toString())
            }
        }

    }
    
}

// =======================================================================
// MARK: - COLOR EXTENSION FOR CONSTANTS
// =======================================================================

extension Sketch.Color {
    
    public enum SystemColor {
        case systemRed
        case systemBlue
        case systemPink
        case systemTeal
        case systemGreen
        case systemGray
        case systemGray2
        case systemGray3
        case systemGray4
        case systemGray5
        case systemGray6
        case systemOrange
        case systemYellow
        case systemPurple
        case systemIndigo
    }
}

extension Sketch.Color.SystemColor: RawRepresentable {
    public typealias RawValue = UIColor
    
    public init?(rawValue: RawValue) {
        
        switch rawValue {
        case UIColor.systemRed: self = .systemRed
        case UIColor.systemBlue: self = .systemBlue
        case UIColor.systemPink: self = .systemPink
        case UIColor.systemTeal: self = .systemTeal
        case UIColor.systemGreen: self = .systemGreen
        case UIColor.systemGray: self = .systemGray
        case UIColor.systemGray2: self = .systemGray2
        case UIColor.systemGray3: self = .systemGray3
        case UIColor.systemGray4: self = .systemGray4
        case UIColor.systemGray5: self = .systemGray5
        case UIColor.systemGray6: self = .systemGray6
        case UIColor.systemOrange: self = .systemOrange
        case UIColor.systemYellow: self = .systemYellow
        case UIColor.systemPurple: self = .systemPurple
        case UIColor.systemIndigo: self = .systemIndigo
        default:
            return nil
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case .systemRed: return UIColor.systemRed
        case .systemBlue: return UIColor.systemBlue
        case .systemPink: return UIColor.systemPink
        case .systemTeal: return UIColor.systemTeal
        case .systemGreen: return UIColor.systemGreen
        case .systemGray: return UIColor.systemGray
        case .systemGray2: return UIColor.systemGray2
        case .systemGray3: return UIColor.systemGray3
        case .systemGray4: return UIColor.systemGray4
        case .systemGray5: return UIColor.systemGray5
        case .systemGray6: return UIColor.systemGray6
        case .systemOrange: return UIColor.systemOrange
        case .systemYellow: return UIColor.systemYellow
        case .systemPurple: return UIColor.systemPurple
        case .systemIndigo: return UIColor.systemIndigo
        }
    }
}


