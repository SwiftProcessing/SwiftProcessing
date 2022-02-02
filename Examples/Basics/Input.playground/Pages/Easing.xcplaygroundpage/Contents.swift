/*:
 ## Easing
 
 Move the mouse across the screen and the symbol will follow. Between drawing each frame of the animation, the program calculates the difference between the position of the symbol and the cursor. If the distance is larger than 1 pixel, the symbol moves part of the distance (0.05) from its current position toward the cursor.
 
 [Source](https://processing.org/examples/easing.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var x = 0.0
    var y = 0.0
    var easing = 0.05
    
    func setup() {
        noStroke()
    }
    
    func draw() {
        background(51)
        
        let targetX = touchX
        let dx = targetX - x
        x += dx * easing
        
        let targetY = touchY
        let dy = targetY - y
        y += dy * easing
        
        ellipse(x, y, 66, 66)
    }
    
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
