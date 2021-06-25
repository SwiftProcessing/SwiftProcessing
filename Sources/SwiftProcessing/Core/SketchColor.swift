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
 
    func clear() {
        context?.clear(CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
    }
    
    /*
    * MARK: - BACKGROUND
    */
    
    // For Playground Literal Color Support
    func background(_ color: UIColor) {
        background(color.rgba255.red, color.rgba255.green, color.rgba255.blue, color.rgba255.alpha)
    }
    
    func background(_ color: Color) {
        background(color.red, color.green, color.blue, color.alpha)
    }
 
    func background(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255) {
        push()
        fill(v1, v2, v3, a)
        rect(0, 0, width, height)
        pop()
    }
    
    func background(_ v1: Double, _ v2: Double, _ v3: Double, _ a: Double = 255) {
        background(CGFloat(v1), CGFloat(v2), CGFloat(v3), CGFloat(a))
    }
    
    func background(_ systemColorName: Color.SystemColor) {
        let systemColor = systemColorName.rawValue
        push()
        fill(systemColor.ciColor.red, systemColor.ciColor.green, systemColor.ciColor.blue, systemColor.ciColor.alpha)
        rect(0, 0, width, height)
        pop()
    }
 
    func background(_ v1: CGFloat, _ a: CGFloat = 255) {
        push()
        fill(v1, v1, v1, a)
        rect(0, 0, width, height)
        pop()
    }
    
    func background(_ v1: Double, _ a: Double = 255) {
        background(CGFloat(v1), CGFloat(a))
    }

    /*
    * MARK: FILL
    */
    
    // For Playground Literal Color Support
    func fill(_ color: UIColor) {
        fill(color.rgba255.red, color.rgba255.green, color.rgba255.blue, color.rgba255.alpha)
    }
    
    func fill(_ color: Color) {
        fill(color.red, color.green, color.blue, color.alpha)
    }
 
    func fill(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255) {
        context?.setFillColor(red: v1 / 255, green: v2 / 255, blue: v3 / 255, alpha: a / 255)
        settings.fill = Color(v1, v2, v3, a)
    }

    func fill(_ v1: Double, _ v2: Double, _ v3: Double, _ a: Double = 255) {
        fill(CGFloat(v1), CGFloat(v2), CGFloat(v3), CGFloat(a))
    }
    
    func fill(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat) {
        context?.setFillColor(red: v1 / 255, green: v2 / 255, blue: v3 / 255, alpha: 255)
        settings.fill = Color(v1, v2, v3, 255)
    }

    func fill(_ v1: Double, _ v2: Double, _ v3: Double) {
        fill(CGFloat(v1), CGFloat(v2), CGFloat(v3))
    }
    
    func fill(_ systemColorName: Color.SystemColor) {
        let systemColor = systemColorName.rawValue
        context?.setFillColor(red: systemColor.ciColor.red / 255, green: systemColor.ciColor.green / 255, blue: systemColor.ciColor.blue / 255, alpha: systemColor.ciColor.alpha / 255)
        settings.fill = Color(systemColor.ciColor.red, systemColor.ciColor.green, systemColor.ciColor.blue, systemColor.ciColor.alpha)
    }
 

    func fill(_ v1: CGFloat,_ a: CGFloat = 255) {
        context?.setFillColor(red: v1 / 255, green: v1 / 255, blue: v1 / 255, alpha: a / 255)
        settings.fill = Color(v1, v1, v1, a)
    }
    
    func fill(_ v1: Double,_ a: Double = 255) {
        fill(CGFloat(v1), CGFloat(a))
    }
    
    func fill(_ v1: CGFloat) {
        context?.setFillColor(red: v1 / 255, green: v1 / 255, blue: v1 / 255, alpha: 255)
        settings.fill = Color(v1, v1, v1, 255)
    }
    
    func fill(_ v1: Double) {
        fill(CGFloat(v1))
    }

    func noFill() {
        fill(0.0, 0.0, 0.0, 0.0)
    }
    
    /*
    * MARK: STROKE
    */
    
    // For Playground Literal Color Support
    func stroke(_ color: UIColor) {
        let red = color.rgba255.red
        let green = color.rgba255.green
        let blue = color.rgba255.blue
        let alpha = color.rgba255.alpha
        stroke(red, green, blue, alpha)
    }
 
    func stroke(_ color: Color) {
        stroke(color.red, color.green, color.blue, color.alpha)
    }
 
    func stroke(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255) {
        context?.setStrokeColor(red: v1 / 255, green: v2 / 255, blue: v3 / 255, alpha: a / 255)
        settings.stroke = Color(v1, v2, v3, a)
    }
    
    func stroke(_ v1: Double, _ v2: Double, _ v3: Double, _ a: Double = 255) {
        stroke(CGFloat(v1), CGFloat(v2), CGFloat(v3), CGFloat(a))
    }

    func stroke(_ systemColorName: Color.SystemColor) {
        let systemColor = systemColorName.rawValue
        context?.setStrokeColor(red: systemColor.ciColor.red / 255, green: systemColor.ciColor.green / 255, blue: systemColor.ciColor.blue / 255, alpha: systemColor.ciColor.alpha / 255)
        settings.stroke = Color(systemColor.ciColor.red, systemColor.ciColor.green, systemColor.ciColor.blue, systemColor.ciColor.alpha)
    }
 
    func stroke(_ v1: CGFloat,_ a: CGFloat = 255) {
        context?.setStrokeColor(red: v1 / 255, green: v1 / 255, blue: v1 / 255, alpha: a / 255)
        settings.stroke = Color(v1, v1, v1, a)
    }

    func stroke(_ v1: Double,_ a: Double = 255) {
        stroke(CGFloat(v1), CGFloat(a))
    }


    func noStroke() {
        stroke(0.0, 0.0, 0.0, 0.0)
    }
    
    /*
    * MARK: ERASE
    */
 
    func erase() {
        context?.setBlendMode(CGBlendMode.clear)
    }
 
    func noErase() {
        context?.setBlendMode(CGBlendMode.normal)
    }
    
    /*
    * MARK: COLOR
    */
    
    // For Playground Literal Color Support
    func color(_ c: UIColor) -> Color {
        return Color(c.rgba255.red, c.rgba255.green, c.rgba255.blue, c.rgba255.alpha)
    }
    
    func color(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255) -> Color {
        return Color(v1, v2, v3, a)
    }
    
    func color(_ v1: Double, _ v2: Double, _ v3: Double, _ a: Double = 255) -> Color {
        return Color(v1, v2, v3, a)
    }
    
    func color(_ v1: CGFloat, _ a: CGFloat = 255) -> Color {
        return Color(v1, v1, v1, a)
    }
    
    func color(_ v1: Double, _ a: Double = 255) -> Color {
        return Color(v1, v1, v1, a)
    }

    func color(_ value: String) -> Color {
        return hexStringToUIColor(hex: value)
    }
    
    /*
    * MARK: COMPONENT-WISE COLOR
    */
 
    func red(_ color: Color) -> CGFloat {
        return red(color.toArray())
    }
 
    func red(_ color: [CGFloat]) -> CGFloat {
        return color[0]
    }
    
    func red(_ color: [Double]) -> Double {
        return color[0]
    }
 
    func green(_ color: Color) -> CGFloat {
        return green(color.toArray())
    }
 
    func green(_ color: [CGFloat]) -> CGFloat {
        return color[1]
    }
    
    func green(_ color: [Double]) -> Double {
        return color[1]
    }
 
    func blue(_ color: Color) -> CGFloat {
        return blue(color.toArray())
    }
 
    func blue(_ color: [CGFloat]) -> CGFloat {
        return color[2]
    }
    
    func blue(_ color: [Double]) -> Double {
        return color[2]
    }
 
    func alpha(_ color: Color) -> CGFloat {
        return alpha(color.toArray())
    }
 
    func alpha(_ color: [CGFloat]) -> CGFloat {
        return color[3]
    }
    
    func alpha(_ color: [Double]) -> Double {
        return color[3]
    }
 
    //credit https://stackoverflow.com/questions/24263007/how-to-use-hex-color-values
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
 
    public init(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255) {
        self.red = Double(v1)
        self.green = Double(v2)
        self.blue = Double(v3)
        self.alpha = Double(a)
    }
    
    public init(_ v1: Double, _ v2: Double, _ v3: Double, _ a: Double = 255) {
        self.red = v1
        self.green = v2
        self.blue = v3
        self.alpha = a
    }
    
    public init(_ color: UIColor) {
        self.red = color.double_rgba255.red
        self.green = color.double_rgba255.green
        self.blue = color.double_rgba255.blue
        self.alpha = color.double_rgba255.alpha
    }
 
    func setRed(_ red: CGFloat) {
        self.red = Double(red)
    }
 
    func setGreen(_ green: CGFloat) {
        self.green = Double(green)
    }
 
    func setBlue(_ blue: CGFloat) {
        self.blue = Double(blue)
    }
 
    func setAlpha(_ alpha: CGFloat) {
        self.alpha = Double(alpha)
    }
    
    func setRed(_ red: Double) {
        self.red = red
    }
    
    func setGreen(_ green: Double) {
        self.green = green
    }
    
    func setBlue(_ blue: Double) {
        self.blue = blue
    }
    
    func setAlpha(_ alpha: Double) {
        self.alpha = alpha
    }

    func uiColor() -> UIColor {
        return UIColor(red: CGFloat(self.red / 255.0), green: CGFloat(self.green / 255.0), blue: CGFloat(self.blue / 255.0), alpha: CGFloat(self.alpha / 255.0))
    }
 
    func toString() -> String {
        return "rgba(\(self.red),\(self.green),\(self.blue),\(self.blue))"
    }
 
    func toArray() -> [CGFloat] {
        return [CGFloat(red), CGFloat(green), CGFloat(blue), CGFloat(alpha)]
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


