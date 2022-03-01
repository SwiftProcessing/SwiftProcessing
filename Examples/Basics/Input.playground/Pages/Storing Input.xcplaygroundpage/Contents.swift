/*:
 ## Storing Input
 
 Touch the sketch to change the position of the circles. The positions of the touch points are recorded into an array and played back every frame. Between each frame, the newest value are added to the end of each array and the oldest value is deleted.
 
 [Source](https://processing.org/examples/mousefunctions.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var num = 60
    var mx: [Double]!
    var my: [Double]!
    
    func setup() {
        noStroke()
        fill(255, 153)
        
        mx = [Double](repeating: 0.0, count: num)
        my = [Double](repeating: 0.0, count: num)
    }
    
    func draw() {
        (background(51))
        
        // Cycle through the array, using a different entry on each frame.
        // Using modulo (%) like this is faster than moving all the values over.
        let which = (frameCount % num)
        (mx[which] = touchX)
        (my[which] = touchY)
        
        for i in 0..<num {
            // which+1 is the smallest (the oldest in the array)
            let index = ((which + 1 + i) % num)
            (ellipse(mx[index], my[index], i, i))
        }
    }
    
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
