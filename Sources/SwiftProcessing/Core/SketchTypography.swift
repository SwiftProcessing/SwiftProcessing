import UIKit

public extension Sketch {
    
    func textSize<T: Numeric>(_ theSize: T) {
        settings.textSize = theSize.convert()
    }
    
    func textFont(_ name: String) {
        settings.textFont = name
    }
    
    func textAlign(_ horizonalAlign: String, _ verticalAlign: String? = nil){
        settings.textAlignment = horizonalAlign
    }
    
    func text<T: Numeric>(_ str: String, _ x: T, _ y: T, _ x2: T? = nil, _ y2: T? = nil) {
        var cg_x, cg_y: CGFloat
        var cg_x2, cg_y2: CGFloat?
        cg_x = x.convert()
        cg_y = y.convert()
        cg_x2 = x2?.convert()
        cg_y2 = y2?.convert()
        
        //let fontSizeWidthRatio: CGFloat = 1.8
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
            .font: UIFont(name: settings.textFont, size: CGFloat(settings.textSize))!,
            .foregroundColor: settings.fill.uiColor(),
            .strokeWidth: -settings.strokeWeight,
            .strokeColor: settings.stroke.uiColor()
        ]
        
        if cg_x2 == nil {
            str.draw(at: CGPoint(x: cg_x, y: cg_y), withAttributes: attributes)
        }else{
            str.draw(with: CGRect(x: cg_x, y: cg_y, width: (cg_x2 != nil) ? cg_x2! : CGFloat(width), height: (cg_y2 != nil) ? cg_y2! : CGFloat(height)), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        }
    }
}
