//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 6/19/21.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
extension SketchUI {
    public func image(image: SwiftUI.Image, x: Double, y: Double, width: Double, height: Double) {
        operations.append(
            Operation(
                name: .circle,
                execute: { context in
                    context.draw(image, in: CGRect(x: x, y: y, width: width, height: height))
                }
            )
        )
    }
}
