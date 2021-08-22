//: [Previous](@previous)
/*:
 # Synthesis—Loops and Rotate
 ### by Masood Kamandy
 
 ## Introduction
 
 In this Synthesis section we're going to take advantage of loops to rewrite our previous example from the *Rotate, Translate, and Scale* section in *Basics* with a few visual modifications.
 
 The thing to notice here is how short the code is. This is enabled by the use of loops and is one of the major benefits of looping code.
 
 ## Let's get rotating!
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit

class MySketch: Sketch, SketchDelegate {
    
    var rotation = 0.0
    var increment = 0.001
    
    var numLoops = 0
    
    func setup() {
        noStroke()
        colorMode(.hsb)
        fill(0, 0, 100, 5)
    }
    
    func draw() {
        (background(0),
         rectMode(.center),
         translate(width/2, height/2),
         rotate(rotation))
        
        for i in stride(from: 0, to: 975, by: 50) {
            (rect(0, 0, 1000-i, 1000-i),
             rotate(rotation))
        }
        
        (rotation = rotation + increment)
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
