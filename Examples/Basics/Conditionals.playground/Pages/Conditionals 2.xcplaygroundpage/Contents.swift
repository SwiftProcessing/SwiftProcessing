/*:
 ## Conditionals 2
 
 We extend the language of conditionals from the previous example by adding the keyword "else". This allows conditionals to ask two or more sequential questions, each with a different action.
 
 [Source](https://processing.org/examples/conditionals2.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    func setup() {
        background(0)
        
        for i in stride(from: 2, to: width - 2, by: 2) {
          // If 'i' divides by 20 with no remainder
          if ((i % 20) == 0) {
            (stroke(255),
            line(i, 80, i, height/2))
            // If 'i' divides by 10 with no remainder
          } else if ((i % 10) == 0) {
            (stroke(153),
            line(i, 20, i, 180))
            // If neither of the above two conditions are met then draw this line
          } else {
            (stroke(102),
            line(i, height/2, i, height-20))
          }
        }
    }
    
    func draw() {
    }

}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
