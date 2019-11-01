//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 10/31/19.
//

import UIKit

public extension Sketch{

    func text(_ str: String, _ x: CGFloat, _ y: CGFloat ){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let attrs = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 36)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]

        str.draw(with: CGRect(x: x, y: y, width: 448, height: 448), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
    }
}
