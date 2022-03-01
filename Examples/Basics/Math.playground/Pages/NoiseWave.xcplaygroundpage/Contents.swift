/*:
 ## NoiseWave
 
 by Daniel Shiffman
 
 Using Perlin Noise to generate a wave-like pattern.
 
 [Source](https://processing.org/examples/noisewave.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var yoff = 0.0        // 2nd dimension of perlin noise
    
    func setup() {
    }
    
    func draw() {
        (background(51))
        
        (fill(255))
        // We are going to draw a polygon out of the wave points
        (beginShape())
        
        var xoff = 0.0       // Option #1: 2D Noise
        // float xoff = yoff; // Option #2: 1D Noise
        
        // Iterate over horizontal pixels
        for x in stride(from: 0, through: width, by: 10) {
            // Calculate a y value according to noise, map to
            let y = (map(noise(xoff, yoff), 0, 1, 400, 500)) // Option #1: 2D Noise
            // let y = map(noise(xoff), 0, 1, 400, 500)    // Option #2: 1D Noise
            
            // Set the vertex
            (vertex(x, y))
            // Increment x dimension for noise
            (xoff += 0.05)
        }
        // increment y dimension for noise
        (yoff += 0.01)
        (vertex(width, height))
        (vertex(0, height))
        (endShape(.close))
    }
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
