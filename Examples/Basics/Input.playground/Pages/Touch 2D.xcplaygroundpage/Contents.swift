/*:
 ## Touch 2D
 
 Touching changes the position and size of each box.
 
 [Source](https://processing.org/examples/mouse2d.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    func setup() {
        noStroke()
        rectMode(.center)
    }
    
    func draw() {
        background(51)
        fill(255, 204)
        rect(touchX, height/2, touchY/2+10, touchY/2+10)
        fill(255, 204)
        let inverseX = width-touchX
        let inverseY = height-touchY
        rect(inverseX, height/2, (inverseY/2)+10, (inverseY/2)+10)
    }
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
