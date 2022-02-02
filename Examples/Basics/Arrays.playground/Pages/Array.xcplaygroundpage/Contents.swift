/*:
 ## Array
 
 An array is a list of data. Each piece of data in an array is identified by an index number representing its position in the array. Arrays are zero based, which means that the first element in the array is [0], the second element is [1], and so on. In this example, an array named "coswave" is created and filled with the cosine values. This data is displayed three separate ways on the screen.
 
 [Source](https://processing.org/examples/array.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var coswave = [Double]()
    
    func setup() {
        for i in 0...Int(width) {
            let amount = map(i, 0, width, 0, Math.pi)
            (coswave.append(abs(cos(amount))))
        }
        background(255)
        noLoop()
    }

    func draw() {
        var y1 = 0.0
        var y2 = height/3
        for i in 0...Int(width) {
          (stroke(coswave[i]*255),
          line(i, y1, i, y2))
        }

        y1 = y2
        y2 = y1 + y1
        for i in 0...Int(width) {
          (stroke(coswave[i]*255 / 4),
          line(i, y1, i, y2))
        }
        
        y1 = y2
        y2 = height
        for i in 0...Int(width) {
          (stroke(255 - coswave[i]*255),
          line(i, y1, i, y2))
        }
    }
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
