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
    public func fill(red: Double, green: Double, blue: Double, alpha: Double = 255) {
        fillColor = Color(.sRGB, red: red / 255, green: green / 255, blue: blue / 255, opacity: alpha / 255)
    }
    
    public func clear() {
        operations = []
    }
}