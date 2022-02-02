/*:
 ## Touch Functions
 
 Touch the box and drag it across the screen.
 
 [Source](https://processing.org/examples/mousefunctions.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var bx = 0.0
    var by = 0.0
    var boxSize = 75
    var locked = false
    var xOffset = 0.0
    var yOffset = 0.0
    
    func setup() {
        bx = width/2.0
        by = height/2.0
        rectMode(.radius)
        noStroke()
    }
    
    func draw() {
        background(0)
        if !locked {
            fill(153)
        }
        // Draw the box
        rect(bx, by, boxSize, boxSize)
    }
    
    func touchStarted() {
        // Test if the cursor is over the box
        if touchX > bx-boxSize && touchX < bx+boxSize &&
            touchY > by-boxSize && touchY < by+boxSize {
            fill(153)
            locked = true
        }
        
        fill(255, 255, 255)
        
        xOffset = touchX-bx
        yOffset = touchY-by
    }
    
    func touchMoved() {
        if locked == true {
            bx = touchX-xOffset
            by = touchY-yOffset
        }
    }
    
    func touchEnded() {
        locked = false
        fill(153)
    }
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
