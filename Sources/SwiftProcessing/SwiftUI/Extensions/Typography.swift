//
//  Typography.swift
//  
//
//  Created by Jonathan Kaufman on 6/10/21.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
extension SketchUI {
    public func text(content: String, x: Double, y: Double) {
        let text = Text(content)
            .foregroundColor(fillColor)
            .font(.system(size: textSize))
        
        operations.append({ context in
            context.draw(
                text,
                at: CGPoint(x: x, y: y),
                anchor: .topLeading
            )
        })
    }
}
