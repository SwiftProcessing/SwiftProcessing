/*:
 ## Map
 
 Use the map() function to take any number and scale it to a new number that is more useful for the project that you are working on. For example, use the numbers from the mouse position to control the size or color of a shape. In this example, the mouse’s x-coordinate (numbers between 0 and 360) are scaled to new numbers to define the color and size of a circle.
 
 [Source](https://processing.org/examples/map.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    func setup() {
        noStroke()
    }
    
    func draw() {
        background(0)
        // Scale the touchX value from 0 to width to a range between 0 and 175
        let c = map(touchX, 0, width, 0, 175)
        // Scale the touchX value from 0 to width to a range between 40 and 300
        let d = map(touchX, 0, width, 40, 500)
        (fill(255, c, 0),
        ellipse(width/2, height/2, d, d))
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
