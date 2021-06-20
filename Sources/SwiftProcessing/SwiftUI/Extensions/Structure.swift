//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 6/19/21.
//

import Foundation

@available(iOS 15.0, *)
public extension SketchUI {
    func loop() {
        isPaused = false
    }
    func noLoop() {
        isPaused = true
    }
}
