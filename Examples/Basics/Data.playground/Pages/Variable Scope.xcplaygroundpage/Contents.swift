/*:
 ## Variable Scope
 
 Variables have a global or local "scope". For example, variables declared within either the `setup()` or `draw()` functions may be only used in these functions. Global variables, variables declared outside of `setup()` and `draw()`, may be used anywhere within the program. If a local variable is declared with the same name as a global variable, the program will use the local variable to make its calculations within the current scope. Variables are localized within each block, the space between a `{` and `}`.
 
 [Source](https://processing.org/examples/variablescope.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    let a = 80  // Create a global variable "a"
    
    func setup() {
        background(0)
        stroke(255)
        noLoop()
    }
    
    func draw() {
        // Draw a line using the global variable "a"
        line(a, 0, a, height)
        
        // Create a new variable "a" local to the for() statement
        for a in stride(from: 120, to: 200, by: 2) {
            line(a, 0, a, height)
        }
        
        // Create a new variable "a" local to the draw() function
        let a = 300
        // Draw a line using the new local variable "a"
        line(a, 0, a, height)
        
        // Make a call to the custom function drawAnotherLine()
        drawAnotherLine()
        
        // Make a call to the custom function setYetAnotherLine()
        drawYetAnotherLine()
    }
    
    func drawAnotherLine() {
        // Create a new variable "a" local to this method
        let a = 320
        // Draw a line using the local variable "a"
        line(a, 0, a, height)
    }
    
    func drawYetAnotherLine() {
        // Because no new local variable "a" is set,
        // this line draws using the original global
        // variable "a", which is set to the value 80.
        line(a+2, 0, a+2, height)
    }
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
