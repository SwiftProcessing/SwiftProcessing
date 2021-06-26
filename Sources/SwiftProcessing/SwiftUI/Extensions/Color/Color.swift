//
//  Color.swift
//  
//
//  Created by Jonathan Kaufman on 6/10/21.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
extension SketchUI {
    public func fill(white: Double, alpha: Double = 255) {
        fill(red: white, green: white, blue: white, alpha: alpha)
    }
    public func fill(red: Double, green: Double, blue: Double, alpha: Double = 255) {
        settings.color.fillColor = Color(.sRGB, red: red / 255, green: green / 255, blue: blue / 255, opacity: alpha / 255)
    }
    
    public func noFill() {
        fill(white: 0, alpha: 0)
    }
    
    public func clear() {
        operations = []
    }
    
    public func background(white: Double, alpha: Double = 255) {
        background(red: white, green: white, blue: white, alpha: white)
    }
    
    public func background(red: Double, green: Double, blue: Double, alpha: Double = 255) {
        operations = []
        let width = width
        let height = height
        operations.append( { context in
            let localContext = context
            localContext.fill(
                Rectangle().path(
                    in: CGRect(
                        x: 0,
                        y: 0,
                        width: width,
                        height: height
                    )
                ),
                with: .color(
                    Color(
                        .sRGB,
                        red: red / 255,
                        green: green / 255,
                        blue: blue / 255,
                        opacity: alpha / 255
                    )
                )
            )
        }
        )
    }
}
