//: [Previous](@previous)
/*:
 # Coordinates and Basic Shapes
 ### by Masood Kamandy for GSoC 2021
 
 Getting started drawing on a computer means we have to learn how to place things with a ***coordinate system*** and a few basic shapes. In this lesson we'll learn about 6 basic shapes. We call these shapes ***primitives***.
 
 ## Coordinate System
 
 In computer graphics we always need to be able to tell a computer **where** to place things on the screen. For this, we use a ***coordinate system***. If you remember geometry class, you'll remember using graph paper or drawing out your own graphs. We use a similar system but it's slightly different.
 
 ![An image showing two different cartesian coordinate systems. The first is a grid with the origin (0,0) in the center. The second has the origin (0,0) in the upper left hand corner. Processing uses the second system.](CoordinateSystem.jpg)
 ([Source](https://processing.org/tutorials/drawing/))
 
 In SwiftProcessing we use (x,y) coordinates just like in math. X is the horizontal position and Y is the vertical position. The coordinate (0,0) is at the top left corner of the screen. (25,50) would be 25 pixels to the right and 50 pixels down.
 
 ## Basic Shapes
 
 The 6 basic shapes we'll learn here along with their syntax:
 
 1. Line - `line(x1, y1, x2, y2)`
 1. Triangle - `triangle(x1, y1, x2, y2, x3, y3)`
 1. Quad - `quad(x1, y1, x2, y2, x3, y3, x4, y4)`
 1. Rect - `rect(x, y, width, height)`
 1. Ellipse - `ellipse(x, y, width, height)`
 1. Arc - `arc(x, y, width, height, start, stop)`
 
 ## Let's draw some shapes!
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit
//: ## SwiftProcessing Sketch Code
class MySketch: Sketch, SketchDelegate {
    
    // We'll put everything in setup() so it only runs once.
    
    func setup() {

        background(0)
        noStroke()
        
        // Try changing the numbers in the shapes to see how that affects the sketch.
        
        // The 'width' and 'height' variables you see below are special SwiftProcessing variables that return the width and height of your device's screen. These can be replaced by numbers if you'd like.
        
        fill(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        triangle(18, 18, 18, height, 81, height)
        
        fill(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
        rect(81, 81, 83, 83)
        
        fill(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
        quad(189, 18, 216, 18, 216, height, 144, height)
        
        fill(#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1))
        ellipse(252, 144, 72, 72)
        
        fill(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        triangle(288, 18, 351, height, 288, height)
        
        fill(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
        arc(479, 300, 280, 280, Math.pi, Math.two_pi)
    }
    
    // We only use draw() when we need things to animate.
    
    func draw() {
    }
}
//: This code is adapted from a [sketch on Processing.org](https://processing.org/examples/shapeprimitives.html).\
//: This last bit of code is to get things up and running in the playground.
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
