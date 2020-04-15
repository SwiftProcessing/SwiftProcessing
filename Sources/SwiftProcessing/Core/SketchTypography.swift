import UIKit

public extension Sketch {
    
    func textSize(_ theSize: CGFloat) {
        settings.textSize = theSize
    }
    
    func textFont(_ name: String) {
        settings.textFont = name
    }
    
    func textAlign(_ horizonalAlign: String, _ verticalAlign: String? = nil){
        settings.textAlignment = horizonalAlign
    }
    
    func text(_ str: String, _ x: CGFloat, _ y: CGFloat, _ x2: CGFloat? = nil, _ y2: CGFloat? = nil) {
        let fontSizeWidthRatio: CGFloat = 1.8
        let paragraphStyle = NSMutableParagraphStyle()
        
        var align: NSTextAlignment!
        switch settings.textAlignment {
        case LEFT:
            align = .left
        case RIGHT:
            align = .right
        case CENTER:
            align = .center
        default:
            align = .left
        }
        paragraphStyle.alignment = align
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont(name: settings.textFont, size: settings.textSize)!,
            .foregroundColor: settings.fill.uiColor(),
            .strokeWidth: -settings.strokeWeight,
            .strokeColor: settings.stroke.uiColor()
        ]
        
        if x2 == nil {
            str.draw(at: CGPoint(x: x, y: y), withAttributes: attributes)
        }else{
            str.draw(with: CGRect(x: x, y: y, width: (x2 != nil) ? x2! : width, height: (y2 != nil) ? y2! : height), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        }
    }
}
