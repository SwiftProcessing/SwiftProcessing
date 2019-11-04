//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 10/31/19.
//

import UIKit

public extension Sketch{
    
    func textSize(_ theSize: CGFloat){
        settings.textSize = theSize
    }
    
    
    func text(_ str: String, _ x: CGFloat, _ y: CGFloat ){
        let paragraphStyle = NSMutableParagraphStyle()
        
        let attrs = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: settings.textSize)!, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.strokeWidth: NSNumber(15.0), NSAttributedString.Key.strokeColor: settings.strokeColor.uiColor(), NSAttributedString.Key.foregroundColor: settings.strokeColor.uiColor()]
       
        str.draw(with: CGRect(x: x, y: y, width: width, height: height), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
    }
}
