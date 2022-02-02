/*:
 ## Distance 2D
 
 Touch across the image to obscure and reveal the matrix. Measures the distance from the touch point to each square and sets the size proportionally.
 
 [Source](https://processing.org/examples/distance2d.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var max_distance:Double!
    
    func setup() {
        noStroke()
        max_distance = dist(0, 0, width, height)
    }
    
    func draw() {
        background(0);
        
        for i in stride(from: 0, through: width, by: 20) {
           for j in stride(from: 0, through: height, by: 20) {
                var size = (dist(touchX, touchY, i, j))
                (size = size/max_distance * 66)
                (ellipse(i, j, size, size))
            }
        }
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
