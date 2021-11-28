/*:
 ## Integers Doubles
 
 Integers (`Int` in Swift) and `Doubles` are two different kinds of numerical data. An integer is a number without a decimal point. A `Double` is a floating-point number, which means it is a number that has a decimal place. `Double`s are used when more precision is needed.
 
 [Source](https://processing.org/examples/integersfloats.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var a: Int = 0;       // Create a variable "a" of the datatype "Int"
    var b: Double = 0.0;  // Create a variable "b" of the datatype "Double"

    func setup() {
      stroke(255)
    }

    func draw() {
      (background(0))
      
      a = a + 1
      b = b + 0.2
      (line(a, 0, a, height/2))
      (line(b, height/2, b, height))
      
      if a > width {
        a = 0
      }
      if b > width {
        b = 0
      }
    }
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
