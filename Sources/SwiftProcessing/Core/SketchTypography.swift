import UIKit

public extension Sketch {
    
    func textSize(_ theSize: CGFloat) {
        settings.textSize = theSize
    }
    
    func textFont(_ name: String) {
        settings.textFont = name
    }
    
    func textAlign(_ horizonalAlign: String, _ verticalAlign: String? = nil){
        settings.horizontalTextAlignment = horizonalAlign
        settings.verticalTextAlignment = verticalAlign
    }
    
    func text(_ str: String, _ x: CGFloat, _ y: CGFloat, _ x2: CGFloat? = nil, _ y2: CGFloat? = nil) {
        let fontSizeWidthRatio: CGFloat = 1.8
        let paragraphStyle = NSMutableParagraphStyle()
        
        var align: NSTextAlignment!
        switch settings.horizontalTextAlignment {
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
        
        if let width = x2 {
            let h = y2 ?? height
            let size = str.size(withAttributes: attributes)
            let centeredRect: CGRect
            if let verticalTextAlignment = settings.verticalTextAlignment {
                switch verticalTextAlignment {
                case TOP:
                    centeredRect = CGRect(x: x,
                                          y: y,
                                          width: width,
                                          height: size.height)
                case CENTER:
                    centeredRect = CGRect(x: x,
                                          y: y + h * 0.5 - size.height * 0.5,
                                          width: width,
                                          height: size.height)
                case BOTTOM:
                    centeredRect = CGRect(x: x,
                                          y: y + h - size.height,
                                          width: width,
                                          height: size.height)
                default:
                    centeredRect = CGRect(x: x, y: y, width: (x2 != nil) ? x2! : width, height: (y2 != nil) ? y2! : height)
                }
                str.draw(with: centeredRect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            } else {
                str.draw(with: CGRect(x: x, y: y, width: (x2 != nil) ? x2! : width, height: (y2 != nil) ? y2! : height), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            }
            
            
        } else {
            str.draw(at: CGPoint(x: x, y: y), withAttributes: attributes)
        }
    }
}
