/*:
 ## Variables
 
 Variables are used for storing values. In this example, change the values of variables to affect the composition.
 
 [Source](https://processing.org/examples/variables.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    func setup() {
        background(0)
        stroke(153)
        strokeWeight(4)
        strokeCap(.square)
        
        var a = 50
        var b = 120
        let c = 223

        line(a, b, a+c, b)
        line(a, b+10, a+c, b+10)
        line(a, b+20, a+c, b+20)
        line(a, b+30, a+c, b+30)

        a = a + c
        b = Int(height-b)

        line(a, b, a+c, b)
        line(a, b+10, a+c, b+10)
        line(a, b+20, a+c, b+20)
        line(a, b+30, a+c, b+30)

        a = a + c
        b = Int(height-b)

        line(a, b, a+c, b)
        line(a, b+10, a+c, b+10)
        line(a, b+20, a+c, b+20)
        line(a, b+30, a+c, b+30)
    }
    
    func draw() {
        
    }
    
    
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
