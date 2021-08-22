/*
 * SwiftProcessing: Typography
 *
 * */


import UIKit

public extension Sketch {
    
    /// Sets the text size.
    /// ```
    /// // Below sets the text size to 12 points.
    /// textSize(12)
    /// ```
    /// - Parameters:
    ///     - size: font size in points.
    
    func textSize<S: Numeric>(_ size: S) {
        settings.textSize = size.convert()
    }
    
    /// Sets the text font. For a list of pre-installed fonts on iOS, see here: https://developer.apple.com/fonts/system-fonts/#preinstalled
    /// ```
    /// // Below sets font to Courier.
    /// textFont("Courier")
    /// ```
    /// - Parameters:
    ///     - name: font name as a string.
    
    func textFont(_ name: String) {
        settings.textFont = name
    }
    
    /// Sets the text alignment horizontally and, optionally, vertically.
    /// ```
    /// // Below sets the horizontal alignment to be centered.
    /// textAlign(.center)
    /// // Below sets the horizontal alignment to be right and the vertical alignment to be bottom.
    /// textAlign(.right, .bottom)
    /// ```
    /// - Parameters:
    ///     - alignX: horizontal alignment. Possible values are `.center`, `.right`, and `.left`.
    ///     - alignY: vertical alignment. Possible values are `.top`, `.bottom`, and `.baseline`. `.baseline` is the default.
    
    func textAlign(_ alignX: Alignment, _ alignY: AlignmentY = Default.textAlignY){
        settings.textAlign = alignX
        settings.textAlignY = alignY
    }
    
    /// Sets the text leading, i.e. the space between lines of text.
    /// ```
    /// // Below sets the leading to 36 points.
    /// textLeading(36)
    /// // Below sets the horizontal alignment to be right and the vertical alignment to be bottom.
    /// textAlign(.right, .bottom)
    /// ```
    /// - Parameters:
    ///     - leading: space between lines in points
    
    func textLeading<L: Numeric>(_ leading: L) {
        settings.textLeading = leading.convert()
    }
    
    /// Draws a string of text to the screen using an x and y coordinate. Optionally you can specify a second x and y to draw within a rectangular space.
    /// ```
    /// // Draws "Hello world" at 100, 100
    /// text("Hello world", 100, 100)
    /// // Draws "Boxed in!" within the rectangular space between (200, 200) and (500, 500)
    /// text("Boxed in!", 200, 200, 500, 500)
    /// ```
    /// - Parameters:
    ///     - string: string you'd like to display on your sketch.
    ///     - x: x-position of string
    ///     - y: y-position of string
    ///     - x1: x-position of the lower-right hand corner of the string
    ///     - y2: y-positin of the lower-right hand corner of the string
    
    func text<X: Numeric, Y: Numeric, X2: Numeric, Y2: Numeric>(_ string: String, _ x: X, _ y: Y, _ x2: X2?, _ y2: Y2?) {
        let cg_x, cg_y: CGFloat
        let cg_x2, cg_y2: CGFloat?
        cg_x = x.convert()
        cg_y = y.convert()
        cg_x2 = x2?.convert()
        cg_y2 = y2?.convert()
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        var align: NSTextAlignment!
        switch settings.textAlign {
        case .left:
            align = .left
        case .right:
            align = .right
        case .center:
            align = .center
        }
        paragraphStyle.alignment = align
        paragraphStyle.lineSpacing = CGFloat(settings.textLeading)
        
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont(name: settings.textFont, size: CGFloat(settings.textSize))!,
            .foregroundColor: settings.fill.uiColor(),
            .strokeWidth: -settings.strokeWeight,
            .strokeColor: settings.stroke.uiColor()
        ]
        
        if cg_x2 == nil {
            string.draw(at: CGPoint(x: cg_x, y: cg_y), withAttributes: attributes)
        } else {
            string.draw(with: CGRect(x: cg_x, y: cg_y, width: (cg_x2 != nil) ? cg_x2! : CGFloat(width), height: (cg_y2 != nil) ? cg_y2! : CGFloat(height)), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        }
    }
    
    /// Draws a string of text to the screen using an x and y coordinate.
    /// ```
    /// // Draws "Hello world" at 100, 100
    /// text("Hello world", 100, 100)
    /// ```
    /// - Parameters:
    ///     - string: string you'd like to display on your sketch.
    ///     - x: x-position of string
    ///     - y: y-position of string
    
    func text<X: Numeric, Y: Numeric>(_ string: String, _ x: X, _ y: Y) {
        let cg_x1 = nil as CGFloat?
        let cg_x2 = nil as CGFloat?
        text(string, x, y, cg_x1, cg_x2)
    }
}
