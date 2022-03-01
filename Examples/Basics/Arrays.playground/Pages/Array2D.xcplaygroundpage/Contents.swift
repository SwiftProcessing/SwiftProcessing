/*:
 ## Array 2D
 
 Demonstrates the syntax for creating a two-dimensional (2D) array. Values in a 2D array are accessed through two index values. 2D arrays are useful for storing images. In this example, each dot is colored in relation to its distance from the center of the image.
 
 [Source](https://processing.org/examples/array2d.html)
 */
import SwiftProcessing
import PlaygroundSupport

// Statements are wrapped in () and (,) to speed up playground.

class MySketch: Sketch, SketchDelegate {
    
    var distances = [[Double]]()
    var maxDistance = 0.0
    var spacer = 20
    
    func setup() {
        maxDistance = dist(width/2, height/2, width, height)
        
        distances = [[Double]](repeating: [Double](repeating: 0, count: Int(height)), count: Int(width))
        
        for y in 0..<Int(height) {
            for x in 0..<Int(width) {
                let distance = dist(width/2, height/2, x, y)
                (distances[x][y] = distance/maxDistance * 255)
            }
        }
        
        spacer = 10
        strokeWeight(1)
        noLoop()  // Run once and stop
    }
    
    func draw() {
        background(0)
        // This embedded loop skips over values in the arrays based on
        // the spacer variable, so there are more values in the array
        // than are drawn here. Change the value of the spacer variable
        // to change the density of the points
        for y in stride(from: 0, to: Int(height), by: spacer) {
            for x in stride(from: 0, to: Int(width), by: spacer) {
                (stroke(distances[x][y]),
                 point(x + spacer/2, y + spacer/2))
            }
        }
    }
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
