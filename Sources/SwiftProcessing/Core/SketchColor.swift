import UIKit
 
public extension Sketch {
 
    func clear() {
        context?.clear(CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
    }
 
    func background(_ color: SketchColor) {
        background(color.red, color.green, color.blue, color.alpha)
    }
 
    func background(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255) {
        push()
        fill(v1, v2, v3, a)
        rect(0, 0, width, height)
        pop()
    }
    

    func background(_ systemColorName: SketchColor.SystemColor) {
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

    func fill(_ color: SketchColor) {
        fill(color.red, color.green, color.blue, color.alpha)
    }
 
    func fill(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255) {
        context?.setFillColor(red: v1 / 255, green: v2 / 255, blue: v3 / 255, alpha: a / 255)
        settings.fill = SketchColor(v1, v2, v3, a)
    }

    
    func fill(_ systemColorName: SketchColor.SystemColor) {
        let systemColor = systemColorName.rawValue
        context?.setFillColor(red: systemColor.ciColor.red / 255, green: systemColor.ciColor.green / 255, blue: systemColor.ciColor.blue / 255, alpha: systemColor.ciColor.alpha / 255)
        settings.fill = SketchColor(systemColor.ciColor.red, systemColor.ciColor.green, systemColor.ciColor.blue, systemColor.ciColor.alpha)
    }
 

    func fill(_ v1: CGFloat,_ a: CGFloat = 255) {
        context?.setFillColor(red: v1 / 255, green: v1 / 255, blue: v1 / 255, alpha: a / 255)
        settings.fill = SketchColor(v1, v1, v1, a)
    }

    func noFill() {
        fill(0, 0, 0, 0)
    }
 
    func stroke(_ color: SketchColor) {
        stroke(color.red, color.green, color.blue, color.alpha)
    }
 
    func stroke(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255) {
        context?.setStrokeColor(red: v1 / 255, green: v2 / 255, blue: v3 / 255, alpha: a / 255)
        settings.stroke = SketchColor(v1, v2, v3, a)
    }

    func stroke(_ systemColorName: SketchColor.SystemColor) {
        let systemColor = systemColorName.rawValue
        context?.setStrokeColor(red: systemColor.ciColor.red / 255, green: systemColor.ciColor.green / 255, blue: systemColor.ciColor.blue / 255, alpha: systemColor.ciColor.alpha / 255)
        settings.stroke = SketchColor(systemColor.ciColor.red, systemColor.ciColor.green, systemColor.ciColor.blue, systemColor.ciColor.alpha)
    }
 
    func stroke(_ v1: CGFloat,_ a: CGFloat = 255) {
        context?.setStrokeColor(red: v1 / 255, green: v1 / 255, blue: v1 / 255, alpha: a / 255)
        settings.stroke = SketchColor(v1, v1, v1, a)
    }


    func noStroke() {
        stroke(0, 0, 0, 0)
    }
 
    func erase() {
        context?.setBlendMode(CGBlendMode.clear)
    }
 
    func noErase() {
        context?.setBlendMode(CGBlendMode.normal)
    }
 
    func color(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255) -> SketchColor {
        return SketchColor(v1, v2, v3, a)
    }
    
    func color(_ v1: CGFloat, _ a: CGFloat = 255) -> SketchColor {
        return SketchColor(v1, v1, v1, a)
    }

    func color(_ value: String) -> SketchColor {
        return hexStringToUIColor(hex: value)
    }
 
    func red(_ color: SketchColor) -> CGFloat {
        return red(color.toArray())
    }
 
    func red(_ color: [CGFloat]) -> CGFloat {
        return color[0]
    }
 
    func green(_ color: SketchColor) -> CGFloat {
        return green(color.toArray())
    }
 
    func green(_ color: [CGFloat]) -> CGFloat {
        return color[1]
    }
 
    func blue(_ color: SketchColor) -> CGFloat {
        return blue(color.toArray())
    }
 
    func blue(_ color: [CGFloat]) -> CGFloat {
        return color[2]
    }
 
    func alpha(_ color: SketchColor) -> CGFloat {
        return alpha(color.toArray())
    }
 
    func alpha(_ color: [CGFloat]) -> CGFloat {
        return color[3]
    }
 
    //credit https://stackoverflow.com/questions/24263007/how-to-use-hex-color-values
    private func hexStringToUIColor (hex: String) -> SketchColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
 
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
 
        if (cString.count) != 6 {
            assertionFailure("Invalid hex color")
        }
 
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
 
        return SketchColor(
            CGFloat((rgbValue & 0xFF0000) >> 16),
            CGFloat((rgbValue & 0x00FF00) >> 8),
            CGFloat(rgbValue & 0x0000FF),
            CGFloat(1.0)
        )
    }
}
 
open class SketchColor {
    
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
 
    public init(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255) {
        self.red = v1
        self.green = v2
        self.blue = v3
        self.alpha = a
    }
 
    func setRed(_ red: CGFloat) {
        self.red = red
    }
 
    func setGreen(_ green: CGFloat) {
        self.green = green
    }
 
    func setBlue(_ blue: CGFloat) {
        self.blue = blue
    }
 
    func setAlpha(_ alpha: CGFloat) {
        self.alpha = alpha
    }
 
    func uiColor() -> UIColor {
        return UIColor(red: self.red / 255, green: self.green / 255, blue: self.blue / 255, alpha: self.alpha / 255)
    }
 
    func toString() -> String {
        return "rgba(\(self.red),\(self.green),\(self.blue),\(self.blue))"
    }
 
    func toArray() -> [CGFloat] {
        return [red, green, blue, alpha]
    }
}
 
extension SketchColor {
    
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
 
extension SketchColor.SystemColor: RawRepresentable {
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


