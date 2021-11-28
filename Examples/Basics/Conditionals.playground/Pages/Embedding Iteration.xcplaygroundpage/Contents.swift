/*:
 ## Embedding Iteration
 
 Embedding "for" structures allows repetition in two dimensions.
 
 [Source](https://processing.org/examples/embeddediteration.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    func setup() {
        background(0)

        let gridSize = 40

        for x in stride(from: gridSize, through: Int(width) - gridSize, by: gridSize) {
          for y in stride(from: gridSize, through: Int(height) - gridSize, by: gridSize) {
            (noStroke(),
            fill(255),
            rect(x-1, y-1, 3, 3),
            stroke(255, 100),
            line(x, y, width/2, height/2))
          }
        }
    }
    
    func draw() {
    }

}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
