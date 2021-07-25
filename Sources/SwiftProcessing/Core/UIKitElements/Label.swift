/*
 * SwiftProcessing: Label
 *
 *
 * */

import Foundation
import UIKit

/*
 * MARK: - SIMPLIFIED ENUM
 */

// NOTE: Consider putting all SwiftProcessing enums in their own .swift file.

// This deviates from Processing because of a difference in the Java, JavaScript, and Swift design guidelines. Regarding naming conventions for enums and constants.
// Although it's different, the thought here is to honor Swift's design guidelines.
// Strings could also be used, but they are prone to error and don't give new learners access to auto-complete.
// Source: https://stackoverflow.com/questions/24244326/swift-global-constant-naming-convention

public enum TextAlignment {
    case natural
    case left
    case center
    case right
    case justified
}

// =======================================================================
// MARK: - Label Class
// =======================================================================

open class Label : UIKitViewElement {
    
    /*
     * MARK: - INIT
     */
    
    init<X: Numeric, Y: Numeric, W: Numeric, H: Numeric>(_ view: Sketch, _ x: X, _ y: Y, _ width: W, _ height: H) {
        var cg_x, cg_y, cg_width, cg_height: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        cg_width = width.convert()
        cg_height = height.convert()
        
        let label = UILabel(frame: CGRect(x: cg_x, y: cg_y, width: cg_width, height: cg_height))
        super.init(view, label)
        
        // label.textAlignment
        // label.text
        // label.textColor
        // label.backgroundColor
        // label.font
    }
    
    /*
     * MARK: - METHODS
     */
    
    /// Returns the value of the slider.
    
    open func text(_ text: String) {
        (self.element as! UILabel).text = text
    }
    
    /// Sets the text alignment. The values are standard alignment values. Natural may be unfamiliar, but it honors the typing direction of the region the phone is set up in. Natural is the default on iOS.
    ///
    /// - Parameters:
    ///     - alignment: Possible values are TextAlignment.natural, TextAlignment.center, TextAlignment.left, TextAlignment.right, TextAlignment.justified
    
    open func textAlignment(_ alignment: TextAlignment){
        switch alignment {
        case TextAlignment.natural:
            (self.element as! UILabel).textAlignment = NSTextAlignment.natural
        case TextAlignment.center:
            (self.element as! UILabel).textAlignment = NSTextAlignment.center
        case TextAlignment.left:
            (self.element as! UILabel).textAlignment = NSTextAlignment.left
        case TextAlignment.right:
            (self.element as! UILabel).textAlignment = NSTextAlignment.right
        case TextAlignment.justified:
            (self.element as! UILabel).textAlignment = NSTextAlignment.justified
        }
    }
    
    /// Sets the text color.
    ///
    /// - Parameters:
    ///     - gray: A gray value from 0-255.
    
    open func textColor<G: Numeric>(_ gray: G){
        let cg_gray: CGFloat = gray.convert()
        
        (self.element as! UILabel).textColor = UIColor(red: cg_gray, green: cg_gray, blue: cg_gray, alpha: 255)
    }
    
    /// Sets the text color.
    ///
    /// - Parameters:
    ///     - gray: A gray value from 0-255.
    ///     - alpha: A gray value from 0-255.
    
    open func textColor<G: Numeric, A: Numeric>(_ gray: G, _ alpha: A){
        let cg_gray: CGFloat = gray.convert()
        let cg_alpha: CGFloat = alpha.convert()
        
        (self.element as! UILabel).textColor = UIColor(red: cg_gray, green: cg_gray, blue: cg_gray, alpha: cg_alpha)
    }
    
    /// Sets the text color.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255.
    ///     - v2: A green value from 0-255.
    ///     - v3: A blue value from 0-255.
    
    open func textColor<V1: Numeric, V2: Numeric, V3: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3){
        var cg_v1, cg_v2, cg_v3: CGFloat
        cg_v1 = v1.convert()
        cg_v2 = v2.convert()
        cg_v3 = v3.convert()
        
        (self.element as! UILabel).textColor = UIColor(red: cg_v1, green: cg_v2, blue: cg_v3, alpha: 255)
    }
    
    /// Sets the text color.
    ///
    /// - Parameters:
    ///     - v1: A red value from 0-255.
    ///     - v2: A green value from 0-255.
    ///     - v3: A blue value from 0-255.
    ///     - alpha: An optional alpha value from 0-255. Defaults to 255.
    
    open func textColor<V1: Numeric, V2: Numeric, V3: Numeric, A: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3, _ alpha: A){
        var cg_v1, cg_v2, cg_v3, cg_alpha: CGFloat
        cg_v1 = v1.convert()
        cg_v2 = v2.convert()
        cg_v3 = v3.convert()
        cg_alpha = alpha.convert()
        
        (self.element as! UILabel).textColor = UIColor(red: cg_v1, green: cg_v2, blue: cg_v3, alpha: cg_alpha)
    }
    
    /// Sets the font of the text.
    ///
    /// - Parameters:
    ///     - font: A UIFont.
    
    open func font(_ font: UIFont) {
        (self.element as! UILabel).font = font
    }
    
    /// Sets the size of the font.
    ///
    /// - Parameters:
    ///     - size: A UIFont.
    
    open func fontSize<S: Numeric>(_ size: S) {
        let cg_size: CGFloat = size.convert()
        
        (self.element as! UILabel).font = UIFont.systemFont(ofSize: cg_size)
    }
}

// =======================================================================
// MARK: - SwiftProcessing Method to Programmatically Create a Slider
// =======================================================================

extension Sketch {
    
    /// Creates a text label programmatically.
    ///
    /// - Parameters:
    ///     - min: The minimum setting of the slider.
    ///     - max: The maximum setting of the slider.
    ///     - value: The value the slider starts at. Defaults to `nil`
    
    open func createLabel<X: Numeric, Y: Numeric, W: Numeric, H: Numeric>(_ view: Sketch, _ x: X, _ y: Y, _ width: W, _ height: H) -> Label {
        let l = Label(view, x, y, width, height)
        viewRefs[l.self.id] = l.self
        return l
    }
}

// https://stackoverflow.com/questions/38464134/how-to-make-extension-for-multiple-classes-swift

protocol LabelControl {
    
    func setText(_ text: String)
    
    func setFontSize<S: Numeric>(_ size: S)
    
    func setTextAlignment(_ alignment: TextAlignment)
    
    func setTextColor<V1: Numeric, V2: Numeric, V3: Numeric, A: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3, _ alpha: A)
    
    func setTextColor<V1: Numeric, V2: Numeric, V3: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3)
    
    func setTextColor<G: Numeric, A: Numeric>(_ gray: G, _ alpha: A)
    
    func setTextColor<G: Numeric>(_ gray: G)
    
}

extension LabelControl {
    // If multiple UI elements need labels. I wonder if it's possible to write the function definitions as an extension so we don't have to implement the protocol manually in each class. An extension should work, but I don't have access to the self.label property here. Wonder if there's a workaround.

}
