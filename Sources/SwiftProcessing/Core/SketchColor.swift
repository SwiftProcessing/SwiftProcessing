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
     * STEP 1 – Create a global color mode that will enable users to choose between RGB and HSB modes. Ranges will be fixed at first. In the beginning, we'll start with 0-255 for RGB, 0-360 for H, and 0-100 for SB.
     * STEP 2 — Expand Color class to have H, S, and B values and convert easily between HSV <-> RGB within the class.
     * Algorithms to use: https://en.wikipedia.org/wiki/HSL_and_HSV#From_HSV
     * STEP 3 – Allow users to set the desired ranges, as they can in Processing.
     *
     */
    
    private func colorModeHelper<V1: Numeric, V2: Numeric, V3: Numeric>(_ v1: V1, _ v2: V2, v3: V3) {
        switch colorMode {
        case ColorMode.RGB:
            print("RGB")
        case ColorMode.HSB:
            print("HSB")
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
        background(color.rgba255.red, color.rgba255.green, color.rgba255.blue, color.rgba255.alpha)
    }
    
    /// Sets the background color with a SketchProcessing Color object.
    ///
    /// - Parameters:
    ///     - color: A Color value.
    
    func background(_ color: Color) {
        background(color.red, color.green, color.blue, color.alpha)
    }
    
    /// Sets the background color with an RGB value.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255.
    ///     - v2: A green value from 0-255.
    ///     - v3: A blue value from 0-255.
    ///     - a: An optional alpha value from 0-255. Defaults to 255.
    
    // Note: It's important to understand why we are *coercing* instead of
    // *type casting* in our generics (eg, T(255) in this definition).
    // Here is more information: https://stackoverflow.com/questions/33973724/typecasting-or-initialization-which-is-better-in-swift
    // Type casting causes runtime errors and should be avoided in generics
    // where integers and floating points are both accepted inputs.
    func background<T: Numeric>(_ v1: T, _ v2: T, _ v3: T, _ a: T = T(255)){
        push()
        fill(v1, v2, v3, a)
        rect(0, 0, CGFloat(width), CGFloat(height))
        pop()
    }
    
    /// Sets the background color with a system color name.
    ///
    /// - Parameters:
    ///     - systemColorName: A standard system color name, eg: .systemRed
    
    func background(_ systemColorName: Color.SystemColor) {
        let systemColor = systemColorName.rawValue
        push()
        fill(systemColor.ciColor.red, systemColor.ciColor.green, systemColor.ciColor.blue, systemColor.ciColor.alpha)
        rect(0, 0, CGFloat(width), CGFloat(height))
        pop()
    }
    
    /// Sets the background color with a single gray value.
    ///
    /// - Parameters:
    ///     - v1: A gray value from 0-255.
    ///     - a: An optional alpha value from 0-255. Defaults to 255.
    
    func background<T: Numeric>(_ v1: T, _ a: T = T(255)) {
        push()
        fill(v1, v1, v1, a)
        rect(0, 0, CGFloat(width), CGFloat(height))
        pop()
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
        fill(color.rgba255.red, color.rgba255.green, color.rgba255.blue, color.rgba255.alpha)
    }
    
    /// Sets the fill color with a SwiftProcessing Color object.
    ///
    /// - Parameters:
    ///     - color: A Color value.
    
    func fill(_ color: Color) {
        fill(color.red, color.green, color.blue, color.alpha)
    }
    
    /// Sets the fill color with red, green, blue, and, optionally, alpha values.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255.
    ///     - v2: A green value from 0-255.
    ///     - v3: A blue value from 0-255.
    ///     - a: An optional alpha value from 0-255. Defaults to 255.
    
    func fill<T: Numeric>(_ v1: T, _ v2: T, _ v3: T, _ a: T = T(255.0)) {
        var cg_v1, cg_v2, cg_v3, cg_a: CGFloat
        cg_v1 = v1.convert()
        cg_v2 = v2.convert()
        cg_v3 = v3.convert()
        cg_a = a.convert()
        
        context?.setFillColor(red: cg_v1 / 255, green: cg_v2 / 255, blue: cg_v3 / 255, alpha: cg_a / 255)
        settings.fill = Color(cg_v1, cg_v2, cg_v3, cg_a)
    }
    
    /// Sets the fill color with red, green, and blue values.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255.
    ///     - v2: A green value from 0-255.
    ///     - v3: A blue value from 0-255.
    
    func fill<T: Numeric>(_ v1: T, _ v2: T, _ v3: T) {
        var cg_v1, cg_v2, cg_v3: CGFloat
        cg_v1 = v1.convert()
        cg_v2 = v2.convert()
        cg_v3 = v3.convert()
        
        context?.setFillColor(red: cg_v1 / 255, green: cg_v2 / 255, blue: cg_v3 / 255, alpha: 255)
        settings.fill = Color(cg_v1, cg_v2, cg_v3, 255)
    }
    
    /// Sets the fill color with a system color name.
    ///
    /// - Parameters:
    ///     - systemColorName: A standard system color name, eg: .systemRed
    
    func fill(_ systemColorName: Color.SystemColor) {
        let systemColor = systemColorName.rawValue
        context?.setFillColor(red: systemColor.ciColor.red / 255, green: systemColor.ciColor.green / 255, blue: systemColor.ciColor.blue / 255, alpha: systemColor.ciColor.alpha / 255)
        settings.fill = Color(systemColor.ciColor.red, systemColor.ciColor.green, systemColor.ciColor.blue, systemColor.ciColor.alpha)
    }
    
    /// Sets the fill color with a single gray value.
    ///
    /// - Parameters:
    ///     - v1: A gray value from 0-255.
    ///     - a: An optional alpha value from 0-255. Defaults to 255.
    
    func fill<T: Numeric>(_ v1: T,_ a: T = T(255.0)) {
        var cg_v1, cg_a: CGFloat
        cg_v1 = v1.convert()
        cg_a = a.convert()
        
        context?.setFillColor(red: cg_v1 / 255, green: cg_v1 / 255, blue: cg_v1 / 255, alpha: cg_a / 255)
        settings.fill = Color(cg_v1, cg_v1, cg_v1, cg_a)
    }
    
    /// Sets the background color with a single gray value.
    ///
    /// - Parameters:
    ///     - v1: A gray value from 0-255.
    
    func fill<T: Numeric>(_ v1: T) {
        var cg_v1: CGFloat
        cg_v1 = v1.convert()
        
        context?.setFillColor(red: cg_v1 / 255, green: cg_v1 / 255, blue: cg_v1 / 255, alpha: 255)
        settings.fill = Color(cg_v1, cg_v1, cg_v1, 255)
    }
    
    /// Sets the fill to be completely clear.
    
    func noFill() {
        fill(0.0, 0.0, 0.0, 0.0)
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
        let red = color.rgba255.red
        let green = color.rgba255.green
        let blue = color.rgba255.blue
        let alpha = color.rgba255.alpha
        stroke(red, green, blue, alpha)
    }
    
    /// Sets the stroke color with a SwiftProcessing Color object.
    ///
    /// - Parameters:
    ///     - color: A Color value.
    
    func stroke(_ color: Color) {
        stroke(color.red, color.green, color.blue, color.alpha)
    }
    
    /// Sets the stroke color with red, green, blue, and, optionally, alpha values.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255.
    ///     - v2: A green value from 0-255.
    ///     - v3: A blue value from 0-255.
    ///     - a: An optional alpha value from 0-255. Defaults to 255.
    
    func stroke<T:Numeric>(_ v1: T, _ v2: T, _ v3: T, _ a: T = T(255.0)) {
        var cg_v1, cg_v2, cg_v3, cg_a: CGFloat
        cg_v1 = v1.convert()
        cg_v2 = v2.convert()
        cg_v3 = v3.convert()
        cg_a = a.convert()
        
        context?.setStrokeColor(red: cg_v1 / 255, green: cg_v2 / 255, blue: cg_v3 / 255, alpha: cg_a / 255)
        settings.stroke = Color(cg_v1, cg_v2, cg_v3, cg_a)
    }
    
    /// Sets the stroke color with a system color name.
    ///
    /// - Parameters:
    ///     - systemColorName: A standard system color name, eg: .systemRed
    
    func stroke(_ systemColorName: Color.SystemColor) {
        let systemColor = systemColorName.rawValue
        context?.setStrokeColor(red: systemColor.ciColor.red / 255, green: systemColor.ciColor.green / 255, blue: systemColor.ciColor.blue / 255, alpha: systemColor.ciColor.alpha / 255)
        settings.stroke = Color(systemColor.ciColor.red, systemColor.ciColor.green, systemColor.ciColor.blue, systemColor.ciColor.alpha)
    }
    
    /// Sets the stroke color with a single gray value.
    ///
    /// - Parameters:
    ///     - v1: A gray value from 0-255.
    ///     - a: An optional alpha value from 0-255. Defaults to 255.
    
    func stroke<T: Numeric>(_ v1: T,_ a: T = T(255.0)) {
        var cg_v1, cg_a: CGFloat
        cg_v1 = v1.convert()
        cg_a = a.convert()
        
        context?.setStrokeColor(red: cg_v1 / 255, green: cg_v1 / 255, blue: cg_v1 / 255, alpha: cg_a / 255)
        settings.stroke = Color(cg_v1, cg_v1, cg_v1, cg_a)
    }
    
    /// Sets the stroke to be completely clear.
    
    func noStroke() {
        stroke(0.0, 0.0, 0.0, 0.0)
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
     * MARK: COLOR
     */
    
    /// Returns a color object that can be stored in a variable.
    ///
    /// - Parameters:
    ///     - color: A UIColor value.
    
    func color(_ c: UIColor) -> Color {
        return Color(c.rgba255.red, c.rgba255.green, c.rgba255.blue, c.rgba255.alpha)
    }
    
    /// Returns a color object that can be stored in a variable.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255.
    ///     - v2: A green value from 0-255.
    ///     - v3: A blue value from 0-255.
    ///     - a: An optional alpha value from 0-255. Defaults to 255.
    
    func color<T: Numeric>(_ v1: T, _ v2: T, _ v3: T, _ a: T = T(255.0)) -> Color {
        return Color(v1, v2, v3, a)
    }
    
    /// Returns a color object that can be stored in a variable.
    ///
    /// - Parameters:
    ///     - v1: A gray value from 0-255.
    ///     - a: An optional alpha value from 0-255. Defaults to 255.
    
    func color<T: Numeric>(_ v1: T, _ a: T = T(255.0)) -> Color {
        return Color(v1, v1, v1, a)
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
    
    func red(_ color: Color) -> CGFloat {
        return red(color.toArray())
    }
    
    /// Returns the red value of a color stored in an array
    ///
    /// - Parameters:
    ///     - color: A color stored in an array, e.g. [R, G, B, A].
    
    func red<T: Numeric>(_ color: [T]) -> CGFloat {
        return color[0].convert()
    }
    
    /// Returns the green value of a SwiftProcessing color object.
    ///
    /// - Parameters:
    ///     - color: A SwiftProcessing color object.
    
    func green(_ color: Color) -> CGFloat {
        return green(color.toArray())
    }
    
    /// Returns the green value of a color stored in an array
    ///
    /// - Parameters:
    ///     - color: A color stored in an array, e.g. [R, G, B, A].
    
    func green<T: Numeric>(_ color: [T]) -> CGFloat {
        return color[1].convert()
    }
    
    /// Returns the blue value of a SwiftProcessing color object.
    ///
    /// - Parameters:
    ///     - color: A SwiftProcessing color object.
    
    func blue(_ color: Color) -> CGFloat {
        return blue(color.toArray())
    }
    
    /// Returns the blue value of a color stored in an array
    ///
    /// - Parameters:
    ///     - color: A color stored in an array, e.g. [R, G, B, A].
    
    func blue<T: Numeric>(_ color: [T]) -> CGFloat {
        return color[2].convert()
    }
    
    /// Returns the alpha value of a SwiftProcessing color object.
    ///
    /// - Parameters:
    ///     - color: A SwiftProcessing color object.
    
    func alpha(_ color: Color) -> CGFloat {
        return alpha(color.toArray())
    }
    
    /// Returns the alpha value of a color stored in an array
    ///
    /// - Parameters:
    ///     - color: A color stored in an array, e.g. [R, G, B, A].
    
    func alpha<T: Numeric>(_ color: [T]) -> CGFloat {
        return color[3].convert()
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
            CGFloat(1.0)
        )
    }
}

// =======================================================================
// MARK: - CLASS: COLOR
// =======================================================================

open class Color {
    
    public var red: Double
    public var green: Double
    public var blue: Double
    public var alpha: Double
    
    public init<T: Numeric>(_ v1: T, _ v2: T, _ v3: T, _ a: T = T(255.0)) {
        self.red = v1.convert()
        self.green = v2.convert()
        self.blue = v3.convert()
        self.alpha = a.convert()
    }
    
    public init(_ color: UIColor) {
        self.red = color.double_rgba255.red
        self.green = color.double_rgba255.green
        self.blue = color.double_rgba255.blue
        self.alpha = color.double_rgba255.alpha
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
    
    func uiColor() -> UIColor {
        return UIColor(red: self.red.convert() / 255.0, green: self.green.convert() / 255.0, blue: self.blue.convert() / 255.0, alpha: self.alpha.convert() / 255.0)
    }
    
    func cgColor() -> CGColor {
        return CGColor(red: self.red.convert(), green: self.green.convert(), blue: self.blue.convert(), alpha: self.alpha.convert())
    }
    
    func toString() -> String {
        return "rgba(\(self.red),\(self.green),\(self.blue),\(self.blue))"
    }
    
    func toArray() -> [Double] {
        return [red, green, blue, alpha]
    }
}

// =======================================================================
// MARK: - COLOR EXTENSION FOR CONSTANTS
// =======================================================================

extension Color {
    
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

extension Color.SystemColor: RawRepresentable {
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


