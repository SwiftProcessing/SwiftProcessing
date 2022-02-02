/*:
 ## Logical Operators
 
 The logical operators for AND (&&) and OR (||) are used to combine simple relational statements into more complex expressions. The NOT (!) operator is used to negate a boolean statement.
 
 [Source](https://processing.org/examples/logicaloperators.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    func setup() {
        background(126);

        var test = false;

        for i in stride(from: 5, through: width, by: 5) {
          // Logical AND
          (stroke(0))
          if i > 35 && i < 100 {
            (line(width/4, i, width/2, i))
            test = false
          }
          
          // Logical OR
          (stroke(76))
          if i <= 35 || i >= 100 {
            (line(width/2, i, width, i))
            test = true
          }
          
          // Testing if a boolean value is "true"
          // The expression "if(test)" is equivalent to "if(test == true)"
          if test {
            (stroke(0))
            (point(width/3, i))
          }
            
          // Testing if a boolean value is "false"
          // The expression "if(!test)" is equivalent to "if(test == false)"
          if !test {
            (stroke(255))
            (point(width/4, i))
          }
        }


    }
    
    func draw() {
    }

}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
