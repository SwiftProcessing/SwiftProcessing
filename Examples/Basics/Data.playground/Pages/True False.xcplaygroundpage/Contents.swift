/*:
 ## True False
 
 A Boolean variable has only two possible values: true or false. It is common to use Booleans with control statements to determine the flow of a program. In this example, when the boolean value "x" is true, vertical black lines are drawn and when the boolean value "x" is false, horizontal gray lines are drawn.
 
 [Source](https://processing.org/examples/truefalse.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    func setup() {
        var b = false
        
        background(0)
        stroke(255)
        
        let d = 20
        let middle = 320
        
        // Center sketch
        translate((width-640)/2, (height-360)/2)
        
        for i in stride(from: d, through: 640, by: d) {
            
            if i < middle {
                b = true
            } else {
                b = false
            }
            
            if b == true {
                // Vertical line
                line(i, d, i, 360-d)
            }
            
            if b == false {
                // Horizontal line
                line(middle, i - middle + d, 640-d, i - middle + d)
            }
        }
    }
    
    func draw() {
    }
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
