/*:
 ## Radial Gradient
 
 Draws a series of concentric circles to create a gradient from one color to another.
 
 [Source](https://processing.org/examples/radialgradient.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var dim: Int!
    
    func setup() {
        dim = (Int(width/2.0))
        (colorMode(.hsb, 360, 100, 100),
        noStroke(),
         ellipseMode(.radius),
        frameRate(1))
    }
    
    func draw() {
        (background(0))
        for x in stride(from: 0, through: width, by: Double(dim)) {
            (drawGradient(x, height/2.0))
        }
    }
    
    func drawGradient(_ x: Double, _ y: Double) {
        let radius = (Double(dim)/2.0)
        var h = (random(0, 360))
        for r in stride(from: radius, to: 0, by: -1) {
            (fill(h, 90, 90))
            (ellipse(x, y, r, r))
            h = ((h + 1) % 360)
        }
    }
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
