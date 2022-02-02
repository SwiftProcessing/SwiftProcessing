/*:
 ## Increment Decrement
 
 Writing "a += 1" is equivalent to "a = a + 1". Writing "a -= 1" is equivalent to "a = a - 1".
 
 [Source](https://processing.org/examples/incrementdecrement.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var a: Int!
    var b: Int!
    var direction: Bool!
    
    func setup() {
        colorMode(.rgb, width);
        a = 0
        b = width
        direction = true
        frameRate(30)
    }
    
    func draw() {
        a += 1
        if a > width {
            a = 0
            direction = !direction
        }
        if direction == true {
            (stroke(a))
        } else {
            (stroke(width-a))
        }
        (line(a, 0, a, height/2))
        
        b -= 1
        if b < 0 {
            b = width
        }
        if direction == true {
            (stroke(width-b))
        } else {
            (stroke(b))
        }
        (line(b, height/2+1, b, height))
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
