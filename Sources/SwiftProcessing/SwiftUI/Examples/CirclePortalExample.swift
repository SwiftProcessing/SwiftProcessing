//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 6/10/21.
//

import Foundation

@available(iOS 15.0, *)
class CirclePortalExample: SketchUI, SketchDelegateUI {
    
    var redModifier: Double = 1
    var redSpeed: Double = 0.1
    
    func draw() {
        var i = height
        while i > 0 {
            fill(red: i * redModifier / (height / 100), green: i / (height / 50), blue: i)
            circle(x: width / 2, y: height / 2, size: i)
            i -= 20
        }
        
        redModifier += redSpeed
        if redModifier < 0 || redModifier > 15 {
            redSpeed *= -1
        }
    }
}
