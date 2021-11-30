/*:
 ## Keyboard Functions
 
 by Martin Gomez
 
 Click on the window to give it focus and press the letter keys to type colors. The keyboard function keyPressed() is called whenever a key is pressed. keyReleased() is another keyboard function that is called when a key is released. Original 'Color Typewriter' concept by John Maeda.
 
 [Source](https://processing.org/examples/keyboardfunctions.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var maxHeight = 40
    var minHeight = 20
    var letterHeight: Int! // Height of the letters
    var letterWidth = 20          // Width of the letter
    
    var x: Int!         // X position of the letters
    var y = 0                      // Y position of the letters
    
    var newletter = false
    
    var numChars = 26      // There are 26 characters in the alphabet
    var colors = [Color]()
    
    func setup() {
        letterHeight = maxHeight
        x = -letterWidth
        
        noStroke()
        colorMode(.hsb, numChars)
        background(12)

        // Set a hue value for each key
        for i in 0..<numChars {
            colors.append(color(i, numChars, numChars))
        }
    }
    
    func draw() {
        if newletter == true {
            // Draw the "letter"
            var y_pos: Int!
            if letterHeight == maxHeight {
                y_pos = y
                rect(x, y_pos, letterWidth, letterHeight)
            } else {
                y_pos = y + minHeight
                rect(x, y_pos, letterWidth, letterHeight)
                fill(numChars / 2)
                rect(x, y_pos-minHeight, letterWidth, letterHeight)
            }
            newletter = false;
        }
        
    }
    
    func keyPressed()
    {
        // If the key is between 'A'(65) to 'Z' and 'a' to 'z'(122)
        if(key >= "A" && key <= "Z") || (key >= "a" && key <= "z") {
            var keyIndex: Int!
            if key <= "Z" {
                keyIndex = key - "A"
                letterHeight = maxHeight
                fill(colors[keyIndex])
            } else {
                keyIndex = key - "a"
                letterHeight = minHeight
                fill(colors[keyIndex])
            }
        } else {
            fill(0)
            letterHeight = 10
        }
        
        newletter = true
        
        // Update the "letter" position
        x = (x + letterWidth)
        
        // Wrap horizontally
        if (x > width - letterWidth) {
            x = 0
            y += maxHeight
        }
        
        // Wrap vertically
        if( y > height - letterHeight) {
            y = 0      // reset y to 0
        }
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
