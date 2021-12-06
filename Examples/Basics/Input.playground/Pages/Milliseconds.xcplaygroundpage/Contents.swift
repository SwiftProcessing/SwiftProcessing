/*:
 ## Milliseconds
 
 A millisecond is 1/1000 of a second. Processing keeps track of the number of milliseconds a program has run. By modifying this number with the modulo(%) operator, different patterns in time are created.
 
 [Source](https://processing.org/examples/milliseconds.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var scale: Int!
    
    func setup() {
        noStroke()
        scale = Int(width)/20
    }
    
    func draw() {
        for i in 0..<scale {
            (colorMode(.rgb, (i+1) * scale * 10),
            fill(millis()%((i+1) * scale * 10)),
            rect(i*scale, 0, scale, height))
        }
    }
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
