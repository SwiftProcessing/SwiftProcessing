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
        
        setTextAttributes()
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
        
        setTextAttributes()
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
        setTextAttributes()
        
        // Vertical alignment is not supported by UIKit outside of control elements.
        // We'll calculate it ourselves inside of text().
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
        
        setTextAttributes()
    }
    
    /// Returns the text ascent (height above the baseline) of the current font and text size setting, i.e. the space between the baseline and the top of the font.
    /// ```
    /// textFont("HelveticaNeue")
    /// textSize(65)
    /// print(textAscent())
    /// ```
    
    func textAscent() -> Double {
        let currentFont = UIFont(name: settings.textFont, size: CGFloat(settings.textSize))
        
        return Double(currentFont?.ascender ?? 0.0)
    }
    
    /// Returns the text descent (height below the baseline) of the current font and text size setting, i.e. the space between the baseline and the bottom of the font.
    /// ```
    /// textFont("HelveticaNeue")
    /// textSize(65)
    /// print(textDescent())
    /// ```
    
    func textDescent() -> Double {
        let currentFont = UIFont(name: settings.textFont, size: CGFloat(settings.textSize))
        
        return Double(currentFont?.descender ?? 0.0)
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
        
        let attributedString = NSAttributedString(string: string,
                                                  attributes: attributes)
        
        let textSize = attributedString.size()
        var xOffset: CGFloat = 0.0
        var yOffset: CGFloat = 0.0
        
        switch attributedString.getAlignment() {
        case .center:
            xOffset = -textSize.width / 2
        case .left:
            xOffset = 0.0
        case .right:
            xOffset = -textSize.width
        default:
            print("No alignment initialized.")
        }
        
        var x = cg_x
        var y = cg_y
        let width = (cg_x2 ?? CGFloat(width))
        let height = (cg_y2 ?? CGFloat(height))
        
        switch settings.textAlignY {
        case .baseline:
            if cg_y2 == nil {
                yOffset = -textSize.height - CGFloat(textDescent())
            } else {
                yOffset = 0.0
            }
        case .bottom:
            if cg_y2 == nil {
                yOffset = -textSize.height
            } else {
                yOffset = height - textSize.height
            }
        case .top:
            yOffset = 0.0
        case .center:
            if cg_y2 == nil {
                yOffset = -textSize.height / 2
            } else {
                yOffset = (height - textSize.height) / 2
            }
        }
        
        y = y + yOffset
        
        // Because draw(at:) does not honor alignment, we need to use draw(in:), which takes a rect. This means that calculation needs to be done so that SwiftProcessing's alignment attributes are honored.
        
        if cg_x2 == nil {
            x = x + xOffset
            attributedString.draw(in: CGRect(x: x, y: y, width: textSize.width, height: textSize.height))
        } else {
            attributedString.draw(in:
                                    CGRect(
                                        x: x,
                                        y: y,
                                        width: width,
                                        height: height))
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


extension NSAttributedString {
    func getAlignment() -> NSTextAlignment {
        
        var alignment: NSTextAlignment?
        
        self.enumerateAttribute(NSAttributedString.Key.paragraphStyle, in: NSRange(location: 0, length: self.length), options: [], using: { (value, range, stop) -> Void in
            guard let currentStyle = value as? NSParagraphStyle else {
                print("Paragraph style not set.")
                return
            }
            alignment = currentStyle.alignment
        } )
        
        return alignment ?? .left
    }
    
}
