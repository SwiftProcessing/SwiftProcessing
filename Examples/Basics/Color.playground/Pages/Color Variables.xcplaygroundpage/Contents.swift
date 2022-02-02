/*:
 ## Color Variables (Homage to Albers)
 
 This example creates variables for colors that may be referred to in the program by a name, rather than a number.

 [Source](https://processing.org/examples/colorvariables.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    func setup() {
        noStroke()
        background(51, 0, 0)

        let inside = color(204, 102, 0)
        let middle = color(204, 153, 0)
        let outside = color(153, 51, 0)

        // These statements are equivalent to the statements above.
        // Programmers may use the format they prefer. The # is optional.
        //let inside = color("#CC6600")
        //let middle = color("#CC990")
        //let outside = color("#993300")
        
        pushMatrix()
        translate(144, 412)
        fill(outside)
        rect(0, 0, 200, 200)
        fill(middle)
        rect(40, 60, 120, 120)
        fill(inside)
        rect(60, 90, 80, 80)
        popMatrix()

        pushMatrix()
        translate(424, 412)
        fill(inside)
        rect(0, 0, 200, 200)
        fill(outside)
        rect(40, 60, 120, 120)
        fill(middle)
        rect(60, 90, 80, 80)
        popMatrix()
    }
    
    func draw() {
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
