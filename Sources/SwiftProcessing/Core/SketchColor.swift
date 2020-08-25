import UIKit

public extension Sketch {

    func clear() {
        context?.clear(CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
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

    func fill(_ color: Color) {
        fill(color.red, color.green, color.blue, color.alpha)
    }

    func fill(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255) {
        context?.setFillColor(red: v1 / 255, green: v2 / 255, blue: v3 / 255, alpha: a / 255)
        settings.fill = Color(v1, v2, v3, a)
    }

    func noFill() {
        fill(0, 0, 0, 0)
    }

    func stroke(_ color: Color) {
        stroke(color.red, color.green, color.blue, color.alpha)
    }

    func stroke(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255) {
        context?.setStrokeColor(red: v1 / 255, green: v2 / 255, blue: v3 / 255, alpha: a / 255)
        settings.stroke = Color(v1, v2, v3, a)
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

    func color(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255) -> Color {
        return Color(v1, v2, v3, a)
    }

    func color(_ value: String) -> Color {
        return hexStringToUIColor(hex: value)
    }

    func red(_ color: Color) -> CGFloat {
        return red(color.toArray())
    }

    func red(_ color: [CGFloat]) -> CGFloat {
        return color[0]
    }

    func green(_ color: Color) -> CGFloat {
        return green(color.toArray())
    }

    func green(_ color: [CGFloat]) -> CGFloat {
        return color[1]
    }

    func blue(_ color: Color) -> CGFloat {
        return blue(color.toArray())
    }

    func blue(_ color: [CGFloat]) -> CGFloat {
        return color[2]
    }

    func alpha(_ color: Color) -> CGFloat {
        return alpha(color.toArray())
    }

    func alpha(_ color: [CGFloat]) -> CGFloat {
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

open class Color {
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
