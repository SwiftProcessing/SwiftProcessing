/*:
 ## Double Random
 
 by Ira Greenberg
 
 Using two random() calls and the point() function to create an irregular sawtooth line.
 
 [Source](https://processing.org/examples/doublerandom.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var totalPts = 300
    var steps: Int!
    
    func setup() {
        steps = totalPts + 1
        stroke(255)
        frameRate(1)
    }
    
    func draw() {
        background(0)
        var rand = 0.0
        for i in 1..<steps {
            // You want the result of the division below to be a double.
            let x: Double = width / steps
            (point( x * i, (height/2) + random(-rand, rand) ))
            (rand += random(-5, 5))
        }
    }
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
