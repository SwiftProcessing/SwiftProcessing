/*:
 ## Keyboard
 
 Click on the image to give it focus and press the letter keys to create forms in time and space. Each key has a unique identifying number. These numbers can be used to position shapes in space.
 
 [Source](https://processing.org/examples/keyboard.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var rectWidth: Double!
    
    func setup() {
        noStroke()
        background(0)
        rectWidth = width / 4
    }
    
    func draw() {
    }
    
    func keyPressed() {
        var keyIndex = -1
        if key >= "A" && key <= "Z" {
            keyIndex = key - "A"
        } else if key >= "a" && key <= "z" {
            keyIndex = key - "a"
        }
        if keyIndex == -1 {
            // If it's not a letter key, clear the screen
            background(0)
        } else {
            // It's a letter key, fill a rectangle
            fill(millis() % 255)
            let x = map(keyIndex, 0, 25, 0, width - rectWidth)
            rect(x, 0, rectWidth, height)
        }
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
