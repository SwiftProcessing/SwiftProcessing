//
//  Primitives.swift
//  
//
//  Created by Jonathan Kaufman on 6/10/21.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
extension SketchUI {
    public func ellipse(x: Double, y: Double, width: Double, height: Double) {
        let color = fillColor
        operations.append( { context in
            var localContext = context
            
            // TODO support circle modes
            localContext.translateBy(x: -width * 0.5, y: -height * 0.5)
            
            let frame = CGRect(
                x: x,
                y: y,
                width: width,
                height: height
            )
            
            localContext.fill(Ellipse().path(in: frame), with: .color(color))
        }
        )
    }
    
    private func executeEllipse(context: GraphicsContext, x: Double, y: Double, width: Double, height: Double) {
        
    }
    
    public func circle(x: Double, y: Double, size: Double) {
        ellipse(x: x, y: y, width: size, height: size)
    }
}
