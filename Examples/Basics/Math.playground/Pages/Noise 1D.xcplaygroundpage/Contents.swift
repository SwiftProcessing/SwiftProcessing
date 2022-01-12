/*:
 ## Noise 1D
 
 Using 1D Perlin Noise to assign location.
 
 [Source](https://processing.org/examples/noise1d.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var xoff = 0.0
    var xincrement = 0.01
    
    func setup() {
        background(0)
        noStroke()
    }
    
    func draw() {
        // Create an alpha blended background
        (fill(0, 10),
        rect(0,0,width,height))
        
        //var n = random(0,width)
        // Try this line instead of noise
        
        // Get a noise value based on xoff and scale it according to the window's width
        let n = noise(xoff)*width
        
        // With each cycle, increment xoff
        xoff += xincrement
        
        // Draw the ellipse at the value produced by perlin noise
        (fill(200),
        ellipse(n,height/2, 64, 64))
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
