/*:
 ## Constrain
 
 Move the mouse across the screen to move the circle. The program constrains the circle to its box.
 
 [Source](https://processing.org/examples/constrain.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var mx = 0.0
    var my = 0.0
    var easing = 0.05
    var radius = 24
    var edge = 100
    var inner: Int!
    
    func setup() {
        inner = edge + radius
        
        noStroke()
        ellipseMode(.radius)
        rectMode(.corners)
    }
    
    func draw() {
        (background(51))
        
        if (abs(touchX - mx) > 0.1) {
            mx = mx + (touchX - mx) * easing
        }
        if (abs(touchY - my) > 0.1) {
            my = my + (touchY - my) * easing
        }
        
        mx = (constrain(mx, inner, width - inner))
        my = (constrain(my, inner, height - inner))
        (fill(76),
         rect(edge, edge, width-edge, height-edge),
         fill(255),
         ellipse(mx, my, radius, radius))
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
