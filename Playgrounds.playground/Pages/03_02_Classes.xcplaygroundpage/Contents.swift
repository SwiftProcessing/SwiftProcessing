//: [Previous](@previous)

import SwiftProcessing
import PlaygroundSupport
import UIKit

class MySketch: Sketch, SketchDelegate {
    
    func setup() {
        translate(144, 144)
        for x in 0..<20 {
            for y in 0..<20 {
                (fill(random(255)),
                circle(x * 25, y * 25, 5))
            }
        }
    }
    
    func draw() {
    }
}
//: ## How will you use conditional logic for your programs? Challenge: Try to create a button using a rectangle with conditional logic.
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)


//: [Next](@next)
