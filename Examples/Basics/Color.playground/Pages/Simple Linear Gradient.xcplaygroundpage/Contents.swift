/*:
 ## Simple Linear Gradient
 
 The `lerpColor()` function is useful for interpolating between two colors.
 
 [Source](https://processing.org/examples/lineargradient.html)
 */

import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    // Constants
    let yAxis = 1
    let xAxis = 2
    var b1:Color!, b2: Color!, c1: Color!, c2: Color!
    
    func setup() {
        b1 = color(255)
        b2 = color(0)
        c1 = color(204, 102, 0)
        c2 = color(0, 102, 153)
        
        noLoop()
    }
    
    func draw() {

        // Background
        setGradient(0, 0, width/2, height, b1, b2, xAxis)
        setGradient(Int(width/2), 0, width/2, height, b2, b1, xAxis);

        // Foreground
        setGradient(114, 422, 540, 80, c1, c2, yAxis);
        setGradient(114, 522, 540, 80, c2, c1, xAxis);
    }
    
    func setGradient(_ x: Int,_ y: Int,_ w: Double,_ h: Double,_ c1: Color,_ c2: Color,_ axis: Int) {
        
        noFill()
        
        if axis == yAxis {  // Top to bottom gradient
            
            for i in y...Int(y+h) {
                let inter = (map(i, y, y+h, 0, 1))
                let c = (lerpColor(c1, c2, inter))
                (stroke(c))
                (line(x, i, x+w, i))
            }
        }
        else if axis == xAxis {  // Left to right gradient
            for i in x...Int(x+w) {
                let inter = (map(i, x, x+w, 0, 1))
                let c = (lerpColor(c1, c2, inter))
                (stroke(c))
                (line(i, y, i, y+h))
            }
        }
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
