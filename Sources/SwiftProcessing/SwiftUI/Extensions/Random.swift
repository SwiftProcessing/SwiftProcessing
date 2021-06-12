//
//  Random.swift
//  
//
//  Created by Jonathan Kaufman on 6/10/21.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
extension SketchUI {
    public func random(_ start: Double, _ end: Double) -> Double {
        Double.random(in: start...end)
    }
}
