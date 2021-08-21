//: [Previous](@previous)
/*:
 # Synthesis—Loops and Rotate
 ### by Masood Kamandy for GSoC 2021
 
 ### Introduction
 
 If you are familiar with any kind of image editing software, you will be familiar with rotating, translating, and scaling. These are called *2D transformations*. If you're not familiar, the concepts are fairly easy. **Rotate** is self-explanatory and rotates what you are drawing. **Translating** moves things along whichever axis you'd like. Usually that means along the x and y axis. **Scaling** makes things smaller and larger.
 
 ### Push/Pop
 
 One important aspect of these functions is that they do not actually affect individual shapes, rather they operate on the entire coordinate system, so you'll need to also learn the `push()` and `pop()` functions to reset the coordinate system.
 
 ### Order Matters
 
 Another thing to remember is that these functions always make their changes **relative to the origin**. So if you are rotating, you are rotating around the origin. If you are scaling, you are scaling from the origin.
 
 This can be a little confusing at first, but with a little practice you'll be a pro in no time!
 
 What that means is that if you want something to rotate somewhere **other** than the origin, you'll need to translate the coordinate system **before** you do your rotation. The example below shows this.
 
 ### Rotate
 
 The `rotate()` function rotates the coordinate system and it takes in any floating point number that represents the *radians* you'd like to rotate in. If you're not familiar with radians, just remember that `2 * PI` is a full circle. You can refer to the diagram below:
 
 ![A unit circle illustrating the angles of rotation from 0 to 2*PI, and 0 to 360 degrees.](degrees.png)
 
 ([Source](https://processing.org/tutorials/transform2d/))
 
 If you're more comfortable with *degrees* you can also just convert from degrees using the `degrees()` function inside of `rotate()`
 
 ```
 // Rotate by 90°
 rotate(PI / 2)
 rotate(degrees(90))
 ```
 
 ### Translate
 
 The `translate()` function moves things in the x and y direction.
 
 ```
 // Translate to 100, 500
 translate(100, 500)
 ```
 
 ### Scale
 
 The `scale()` function scales from the origin. You
 
 ## Import Modules
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit
//: ## SwiftProcessing Sketch Code
class MySketch: Sketch, SketchDelegate {
    
    var rotation = 0.0
    var increment = 0.001
    
    var numLoops = 0
    
    func setup() {
        stroke(255)
        noFill()
    }
    
    func draw() {
        (background(0),
         rectMode(.center),
         translate(width/2, height/2),
         rotate(rotation))
        

        for i in stride(from: 0, to: 975, by: 25) {
            (rect(0, 0, 1000-i, 1000-i),
             rotate(rotation))
        }
        
        (rotation = rotation + increment)
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
