//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 6/10/21.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
extension SketchUI {
    public func text(content: String, x: Double, y: Double) {
        context?.draw(Text(content), at: CGPoint(x: x, y: y))
    }
}
