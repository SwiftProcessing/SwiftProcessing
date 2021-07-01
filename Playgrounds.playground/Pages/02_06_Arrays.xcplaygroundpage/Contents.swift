//: [Previous](@previous)
/*:
 # Arrays
 ### by Masood Kamandy for GSoC 2021
 
 ## Introduction
 
 ## Arrays
 
 ## Iterating Over Arrays
 

 
 ## Let's use a for loop to draw a gradient of lines down the screen.
 */

import SwiftProcessing
import PlaygroundSupport
import UIKit

class MySketch: Sketch, SketchDelegate {
    
    var topColor = Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
    var bottomColor = Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
    
    var increment = 32
    
    func setup() {
        // Remember that the start and end of a for loop need to be both be integers.
        // Height is a double, so we'll convert it to an integer.
        
        for i in stride(from: increment/2, to: Int(height), by: increment) {
            // To use i in SwiftProcessing functions it should be converted to a Double.
            let double_i = Double(i)
            
            // Get mapped colors that fade from topColor to bottomColor
            // Creating gradients involves mapping from one
            // color's r,g,and b values to another.
            let red = map(double_i, 0, height, topColor.red, bottomColor.red)
            let green = map(double_i, 0, height, topColor.green, bottomColor.green)
            let blue = map(double_i, 0, height, topColor.blue, bottomColor.blue)
            
            // Draw lines from the top of the screen to the bottom.
            strokeWeight(Double(increment))
            stroke(red, green, blue)
            line(0, double_i, width, double_i)
        }
    }
    
    func draw() {
    }
}
//: ## How will you use conditional logic for your programs? Challenge: Try to create a button using a rectangle with conditional logic.
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
