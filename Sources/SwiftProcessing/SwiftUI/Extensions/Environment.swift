//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 6/19/21.
//

import Foundation

@available(iOS 15.0, *)
public extension SketchUI {
    func frameRate() -> Double {
        // TODO should this return the target frameRate or the real one (1 / deltaTime)
        return targetFrameRate
    }

    func frameRate(fps: Double) {
        targetFrameRate = 1 / fps
    }
}
