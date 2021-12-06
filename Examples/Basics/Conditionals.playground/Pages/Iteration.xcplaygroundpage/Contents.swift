/*:
 ## Iteration
 
 Iteration with a "for" structure to construct repetitive forms.
 
 [Source](https://processing.org/examples/iteration.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var y: Int!
    var num = 14
    
    func setup() {
        background(102)
        noStroke()
         
        // White bars
        fill(255)
        y = 60
        for _ in 0..<num/3 {
          rect(50, y, 475, 10)
          y+=20
        }

        // Gray bars
        fill(51)
        y = 40
        for _ in 0..<num {
          rect(405, y, 30, 10)
          y += 20
        }
        y = 50
        for _ in 0..<num {
          rect(425, y, 30, 10)
          y += 20
        }
          
        // Thin lines
        y = 45
        fill(0)
        for _ in 0..<num-1 {
          rect(120, y, 40, 1)
          y += 20
        }
    }
    
    func draw() {
    }

}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
