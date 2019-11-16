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
    
    func textFont(_ name: String){
        settings.textFont = name
    }
    
    func text(_ str: String, _ x: CGFloat, _ y: CGFloat ){
        let paragraphStyle = NSMutableParagraphStyle()
        
        let attributes: [NSAttributedString.Key : Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont(name: settings.textFont, size: settings.textSize)!,
            .foregroundColor: settings.fill.uiColor(),
            .strokeWidth: -settings.strokeWeight,
            .strokeColor: settings.stroke.uiColor(),
        ]
       
        str.draw(with: CGRect(x: x, y: y, width: width, height: height), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
    }
}
