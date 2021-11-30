/*:
 ## Touch 1D
 
 Touch the sketch left and right to shift the balance. The "mouseX" variable is used to control both the size and color of the rectangles.
 
 [Source](https://processing.org/examples/mouse1d.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    func setup() {
        noStroke()
        colorMode(.rgb, height, height, height)
        rectMode(.center)
    }
    
    func draw() {
        background(0.0)
        
        let r1 = map(touchX, 0, width, 0, height)
        let r2 = height-r1
        
        fill(r1)
        rect(width/2 + r1/2, height/2, r1, r1)
        
        fill(r2)
        rect(width/2 - r2/2, height/2, r2, r2)
    }
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
