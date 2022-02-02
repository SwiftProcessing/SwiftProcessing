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
    
    var double_rgba: (red: Double, green: Double, blue: Double, alpha: Double) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (Double(r), Double(g), Double(b), Double(a))
    }
    
    var hsba: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h, s, b, a)
    }
    
    var double_hsba: (hue: Double, saturation: Double, brightness: Double, alpha: Double) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (Double(h), Double(s), Double(b), Double(a))
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
    
    /*
     * MARK: - COLOR METHODS
     */
    
    /// Returns a color object that can be stored in a variable.
    ///
    /// - Parameters:
    ///     - color: A UIColor value.
    
    func color(_ c: UIColor) -> Color {
        switch settings.colorMode {
        case .rgb:
            return Color(c.double_rgba.red * Color.v1Max, c.double_rgba.green * Color.v2Max, c.double_rgba.blue * Color.v3Max, c.double_rgba.alpha * Color.alphaMax, .rgb)
        case .hsb:
            return Color(c.double_hsba.hue * Color.v1Max, c.double_hsba.saturation * Color.v2Max, c.double_hsba.brightness * Color.v3Max, c.double_hsba.alpha * Color.alphaMax, .hsb)
        }
    }
    
    /// Returns a color object that can be stored in a variable.
    ///
    /// - Parameters:
    ///     - value: hex string for a color.
    
    func color(_ value: String) -> Color {
        return hexStringToColor(hex: value)
    }
    
    // These help us bypass limitations of inner classes and check Processing's state before creating a color. Colors should only be created using these methods, whether internally in the framework or by humans externally.
    
    /// Creates a SwiftProcessing color object.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255 by default unless you've specified a specific maximum via `colorMode()`
    ///     - v2: A green value from 0-255 by default unless you've specified a specific maximum via `colorMode()`
    ///     - v3: A blue value from 0-255 by default unless you've specified a specific maximum via `colorMode()`
    ///     - a: An alpha value from 0-255 by default unless you've specified a specific maximum via `colorMode()`
    func color<V1: Numeric, V2: Numeric, V3: Numeric, A: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3, _ a: A) -> Color {
        return Color(v1, v2, v3, a, settings.colorMode)
    }
    
    /// Creates a SwiftProcessing color object.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255 by default unless you've specified a specific maximum via `colorMode()`
    ///     - v2: A green value from 0-255 by default unless you've specified a specific maximum via `colorMode()`
    ///     - v3: A blue value from 0-255 by default unless you've specified a specific maximum via `colorMode()`
    func color<V1: Numeric, V2: Numeric, V3: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3) -> Color {
        return Color(v1, v2, v3, Color.alphaMax, settings.colorMode)
    }
    
    /// Creates a SwiftProcessing color object.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255 by default unless you've specified a specific maximum via `colorMode()`
    ///     - a: An alpha value from 0-255 by default unless you've specified a specific maximum via `colorMode()`
    func color<V1: Numeric, A: Numeric>(_ v1: V1, _ a: A) -> Color {
        return Color(v1 / Color.v1Max, v1 / Color.v1Max, v1 / Color.v1Max, a / Color.alphaMax, .rgb, true)
    }
    
    /// Creates a SwiftProcessing color object.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255 by default unless you've specified a specific maximum via `colorMode()`
    func color<V1: Numeric>(_ v1: V1) -> Color {
        return Color(v1 / Color.v1Max, v1 / Color.v1Max, v1 / Color.v1Max, 1.0, .rgb, true)
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
            background(color.double_rgba.red * Color.v1Max, color.double_rgba.green * Color.v2Max, color.double_rgba.blue * Color.v3Max, color.double_rgba.alpha * Color.alphaMax)
        case .hsb:
            background(color.double_hsba.hue * Color.v1Max, color.double_hsba.saturation * Color.v2Max, color.double_hsba.brightness * Color.v3Max, color.double_hsba.alpha * Color.alphaMax)
        }
        
    }
    
    /// Sets the background color with a SketchProcessing Color object.
    ///
    /// - Parameters:
    ///     - color: A Color value.
    
    func background(_ color: Color) {
        context?.saveGState()
        context?.setFillColor(color.cgColor())
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
        background(v1, v2, v3, Color.alphaMax)
    }
    
    /// Sets the background color with a system color name.
    ///
    /// - Parameters:
    ///     - systemColorName: A standard system color name, eg: .systemRed
    
    func background(_ systemColorName: Color.SystemColor) {
        let systemColor = systemColorName.rawValue
        switch settings.colorMode {
        case .rgb:
            background(systemColor.double_rgba.red * Color.v1Max, systemColor.double_rgba.green * Color.v2Max, systemColor.double_rgba.blue * Color.v3Max, systemColor.double_rgba.alpha * Color.alphaMax)
        case .hsb:
            background(systemColor.double_hsba.hue * Color.v1Max, systemColor.double_hsba.saturation * Color.v2Max, systemColor.double_hsba.brightness * Color.v3Max, systemColor.double_hsba.alpha * Color.alphaMax)
        }
    }
    
    /// Sets the background color with gray and alpha values.
    ///
    /// - Parameters:
    ///     - v1: A gray value from 0-255.
    ///     - a: An optional alpha value from 0-255. Defaults to 255.
    
    func background<V1: Numeric, A: Numeric>(_ v1: V1, _ a: A) {
        let bg = color(v1, a)
        background(bg)
    }
    
    /// Sets the background color with a single gray value.
    ///
    /// - Parameters:
    ///     - v1: A gray value from 0-255.
    
    func background<V1: Numeric>(_ v1: V1) {
        let bg = color(v1)
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
            fill(color.double_rgba.red * Color.v1Max, color.double_rgba.green * Color.v2Max, color.double_rgba.blue * Color.v3Max, color.double_rgba.alpha * Color.alphaMax)
        case .hsb:
            fill(color.double_hsba.hue * Color.v1Max, color.double_hsba.saturation * Color.v2Max, color.double_hsba.brightness * Color.v3Max, color.double_hsba.alpha * Color.alphaMax)
        }
    }
    
    /// Sets the fill color with a SwiftProcessing Color object.
    ///
    /// - Parameters:
    ///     - color: A Color value.
    
    func fill(_ color: Color) {
        context?.setFillColor(color.cgColor())
        settings.fill = color
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
        setTextAttributes()
    }
    
    /// Sets the fill color with an RGB or HSB value. RGB is the default color mode.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255 (RGB). A hue value from 0-360 (HSB).
    ///     - v2: A green value from 0-255 (RGB). A saturation value from 0-100 (HSB).
    ///     - v3: A blue value from 0-255 (RGB). A brightness value from 0-100 (HSB).
    
    func fill<V1: Numeric, V2: Numeric, V3: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3) {
        fill(v1, v2, v3, Color.alphaMax)
    }
    
    /// Sets the fill color with a system color name.
    ///
    /// - Parameters:
    ///     - systemColorName: A standard system color name, eg: .systemRed
    
    func fill(_ systemColorName: Color.SystemColor) {
        let systemColor = systemColorName.rawValue
        
        context?.setFillColor(red: systemColor.rgba.red, green: systemColor.rgba.green, blue: systemColor.rgba.blue, alpha: systemColor.rgba.alpha)
        
        switch settings.colorMode {
        case .rgb:
            settings.fill = Color(systemColor.double_rgba.red * Color.v1Max, systemColor.double_rgba.green * Color.v2Max, systemColor.double_rgba.blue * Color.v3Max, systemColor.double_rgba.alpha * Color.alphaMax, .rgb)
        case .hsb:
            settings.fill = Color(systemColor.double_hsba.hue * Color.v1Max, systemColor.double_hsba.saturation * Color.v2Max, systemColor.double_hsba.brightness * Color.v3Max, systemColor.double_hsba.alpha * Color.alphaMax, .hsb)
        }
        
        setTextAttributes()
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
        
        context?.setFillColor(Color(cg_v1 / Color.v1Max, cg_v1 / Color.v1Max, cg_v1 / Color.v1Max, cg_a / Color.alphaMax, .rgb, true).cgColor())
        settings.fill = Color(cg_v1 / Color.v1Max, cg_v1 / Color.v1Max, cg_v1 / Color.v1Max, cg_a / Color.alphaMax, .rgb, true)
        setTextAttributes()
    }
    
    /// Sets the fill color with a single gray value.
    ///
    /// - Parameters:
    ///     - v1: A gray value from 0-255.
    
    func fill<V1: Numeric>(_ v1: V1) {
        fill(v1, Color.alphaMax)
    }
    
    /// Sets the fill to be completely clear.
    
    func noFill() {
        fill(0.0, 0.0) // Same in .rgb or .hsb mode
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
            stroke(color.double_rgba.red * Color.v1Max, color.double_rgba.green * Color.v2Max, color.double_rgba.blue * Color.v3Max, color.double_rgba.alpha * Color.alphaMax)
        case .hsb:
            stroke(color.double_hsba.hue * Color.v1Max, color.double_hsba.saturation * Color.v2Max, color.double_hsba.brightness * Color.v3Max, color.double_hsba.alpha * Color.alphaMax)
        }
    }
    
    /// Sets the stroke color with a SwiftProcessing Color object.
    ///
    /// - Parameters:
    ///     - color: A Color value.
    
    func stroke(_ color: Color) {
        context?.setStrokeColor(color.cgColor())
        settings.stroke = color
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
        setTextAttributes()
    }
    
    /// Sets the stroke color with an RGB or HSB value. RGB is the default color mode.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255 (RGB). A hue value from 0-360 (HSB).
    ///     - v2: A green value from 0-255 (RGB). A saturation value from 0-100 (HSB).
    ///     - v3: A blue value from 0-255 (RGB). A brightness value from 0-100 (HSB).
    
    func stroke<V1: Numeric, V2: Numeric, V3: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3) {
        stroke(v1, v2, v3, Color.alphaMax)
    }
    
    /// Sets the stroke color with a system color name.
    ///
    /// - Parameters:
    ///     - systemColorName: A standard system color name, eg: .systemRed
    
    func stroke(_ systemColorName: Color.SystemColor) {
        let systemColor = systemColorName.rawValue
        context?.setStrokeColor(red: systemColor.rgba.red, green: systemColor.rgba.green, blue: systemColor.rgba.blue, alpha: systemColor.rgba.alpha)
        switch settings.colorMode {
        case .rgb:
            settings.stroke = Color(systemColor.double_rgba.red * Color.v1Max, systemColor.double_rgba.green * Color.v2Max, systemColor.double_rgba.blue * Color.v3Max, systemColor.double_rgba.alpha * Color.alphaMax, .rgb)
        case .hsb:
            settings.stroke = Color(systemColor.double_hsba.hue * Color.v1Max, systemColor.double_hsba.saturation * Color.v2Max, systemColor.double_hsba.brightness * Color.v3Max, systemColor.double_hsba.alpha * Color.alphaMax, .hsb)
        }
        
        setTextAttributes()
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
        
        context?.setStrokeColor(Color(cg_v1 / Color.v1Max, cg_v1 / Color.v1Max, cg_v1 / Color.v1Max, cg_a / Color.alphaMax, .rgb, true).cgColor())
        settings.stroke = Color(cg_v1 / Color.v1Max, cg_v1 / Color.v1Max, cg_v1 / Color.v1Max, cg_a / Color.alphaMax, .rgb, true)
        
        setTextAttributes()
    }
    
    /// Sets the stroke color with a single gray value.
    ///
    /// - Parameters:
    ///     - v1: A gray value from 0-255.
    
    func stroke<V1: Numeric>(_ v1: V1) {
        stroke(v1, Color.alphaMax)
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
        
        let c1_v1 = c1.v1
        let c1_v2 = c1.v2
        let c1_v3 = c1.v3
        let c1_a = c1.a
        
        let c2_v1 = c2.v1
        let c2_v2 = c2.v2
        let c2_v3 = c2.v3
        let c2_a = c2.a
        
        let cg_amt: CGFloat = amt.convert()
        
        let cnst_amt = constrain(cg_amt, 0.0, 1.0)
        
        newColor = Color(
            lerp(c1_v1, c2_v1, cnst_amt),
            lerp(c1_v2, c2_v2, cnst_amt),
            lerp(c1_v3, c2_v3, cnst_amt),
            lerp(c1_a, c2_a, cnst_amt),
            settings.colorMode
        )
        
        return newColor ?? color(0)
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
     * MARK: COMPONENT-WISE COLOR
     */
    
    /// Returns the red value of a SwiftProcessing color object.
    ///
    /// - Parameters:
    ///     - color: A SwiftProcessing color object.
    
    func red(_ color: Color) -> Double {
        // There may be an easier way to do this, but this seems the most reliable at the moment.
        return color.uiColor().double_rgba.red * Color.v1Max
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
        switch settings.colorMode {
        case .rgb:
            return color.uiColor().double_rgba.red * Color.v1Max
        case .hsb:
            return color.uiColor().double_hsba.hue * Color.v1Max
        }
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
        return color.v3
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
        return color.a
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
        return color.v1
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
        return color.v2
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
        return color.v3
    }
    
    /// Returns the brightness value of a color stored in an array
    ///
    /// - Parameters:
    ///     - color: A color stored in an array, e.g. [H, S, B, A].
    
    func brightness<T: Numeric>(_ color: [T]) -> Double {
        return color[2].convert()
    }
    
    // Source: https://stackoverflow.com/questions/24263007/how-to-use-hex-color-values
    private func hexStringToColor (hex: String) -> Color {
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

// Processing's Color class is *very simple*. What we have here is error prone and complex. We're going to try to reduce complexity.

// TO DO: Restructure class to allow for bit shifting as is possible in Processing.
// Source: https://processing.org/reference/red_.html

public extension Sketch {
    class Color {
        
        //        public static var maximums: String {
        //            let description = """
        //            hueMax = \(hueMax)
        //            saturationMax = \(saturationMax)
        //            brightnessMax = \(brightnessMax)
        //
        //            redMax = \(redMax)
        //            greenMax = \(greenMax)
        //            blueMax = \(blueMax)
        //
        //            alphaMax = \(String(describing: alphaMax))
        //            """
        //            return description
        //        }
        
        /// Max value for red (or hue) set by colorMode
        public static var v1Max:CGFloat = 255
        
        /// Max value for green (or saturation) set by colorMode
        public static var v2Max:CGFloat = 255
        
        /// Max value for blue (or value) set by colorMode
        public static var v3Max:CGFloat = 255
        
        /// Max value for alpha set by colorMode
        public static var alphaMax:CGFloat = 255
        
        // Set these to 0 so that we can use private methods before they've been assigned.
        public var v1 = 0.0
        public var v2 = 0.0
        public var v3 = 0.0
        public var a = 0.0
        
        // For dependency injection only. Swift doesn't allow inner classes to access outer class properties.
        private var mode: ColorMode
        
        internal init<V1: Numeric, V2: Numeric, V3: Numeric, A: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3, _ a: A, _ mode: ColorMode = .rgb,_ normalized: Bool = false) {
            self.mode = mode
            
            var d_v1, d_v2, d_v3, d_a: Double
            d_v1 = v1.convert(); d_v2 = v2.convert(); d_v3 = v3.convert(); d_a = a.convert()
            
            switch normalized {
            case true:
                // Set RGB
                self.v1 = clamp(value: d_v1 * Double(Color.v1Max), minimum: 0.0, maximum: Double(Color.v1Max))
                self.v2 = clamp(value: d_v2 * Double(Color.v2Max), minimum: 0.0, maximum: Double(Color.v2Max))
                self.v3 = clamp(value: d_v3 * Double(Color.v3Max), minimum: 0.0, maximum: Double(Color.v3Max))
                self.a = clamp(value: d_a * Double(Color.alphaMax), minimum: 0.0, maximum: Double(Color.alphaMax))
            case false:
                // Set RGB
                self.v1 = clamp(value: d_v1, minimum: 0.0, maximum: Double(Color.v1Max))
                self.v2 = clamp(value: d_v2, minimum: 0.0, maximum: Double(Color.v2Max))
                self.v3 = clamp(value: d_v3, minimum: 0.0, maximum: Double(Color.v3Max))
                self.a = clamp(value: d_a, minimum: 0.0, maximum: Double(Color.alphaMax))
            }

        }
        
        // This initializer is to enable Color Literals in playgrounds. It feels clunky and I doubt new learners will understand that they need to specify the current color mode. Without some kind of dependendy injection here, it's impossible to assess the state of SwiftProcessing's settings to assess color mode. For now, setting a default of .rgb will capture most cases, but this will cause confusion and is not a desirable solution.
        
        internal init(_ color: UIColor, mode: ColorMode = .rgb) {
            self.mode = mode
            
            switch mode {
            case .rgb:
                self.v1 = color.double_rgba.red * Color.v1Max
                self.v2 = color.double_rgba.blue * Color.v2Max
                self.v3 = color.double_rgba.green * Color.v3Max
                self.a = color.double_rgba.alpha * Color.alphaMax
            case .hsb:
                self.v1 = color.double_hsba.hue * Color.v1Max
                self.v2 = color.double_hsba.saturation * Color.v2Max
                self.v3 = color.double_hsba.brightness * Color.v3Max
                self.a = color.double_hsba.alpha * Color.alphaMax
            }
        }
        
        func uiColor() -> UIColor {
            switch mode {
            case .rgb:
                return UIColor(red: CGFloat(v1) / Color.v1Max, green: CGFloat(v2) / Color.v2Max, blue: CGFloat(v3) / Color.v3Max, alpha: CGFloat(a) / Color.alphaMax)
            case .hsb:
                return UIColor(hue: CGFloat(v1) / Color.v1Max, saturation: CGFloat(v2) / Color.v2Max, brightness: CGFloat(v3) / Color.v3Max, alpha: CGFloat(a) / Color.alphaMax)
            }
        }
        
        func cgColor() -> CGColor {
            switch mode {
            case .rgb:
                return UIColor(red: CGFloat(v1) / Color.v1Max, green: CGFloat(v2) / Color.v2Max, blue: CGFloat(v3) / Color.v3Max, alpha: CGFloat(a) / Color.alphaMax).cgColor
            case .hsb:
                return UIColor(hue: CGFloat(v1) / Color.v1Max, saturation: CGFloat(v2) / Color.v2Max, brightness: CGFloat(v3) / Color.v3Max, alpha: CGFloat(a) / Color.alphaMax).cgColor
            }
        }
        
        func toArray() -> [Double] {
            return [v1, v2, v3, a]
        }
        
        func toString() -> String {
            return """
                v1 v2 v3 a: (\(v1),\(v2),\(v3),\(a))
                """
        }
        
        // https://developer.apple.com/library/archive/samplecode/AppChat/Listings/AppChat_MathUtilities_swift.html#//apple_ref/doc/uid/TP40017298-AppChat_MathUtilities_swift-DontLinkElementID_18
        private func clamp<T: Comparable>(value: T, minimum: T, maximum: T) -> T {
            return Swift.min(Swift.max(value, minimum), maximum)
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


