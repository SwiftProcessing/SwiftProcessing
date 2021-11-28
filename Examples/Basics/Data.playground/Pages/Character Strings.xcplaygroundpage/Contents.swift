/*:
 ## Characters Strings
 
 The `Character` datatype stores letters and symbols in the Unicode format, a coding system developed to support a variety of world languages.
 
 A `String` is a sequence of `Character`s. A `String` is noted by surrounding a group of letters with double quotes ("Processing"). `Character`s and `String`s are most often used with the keyboard methods, to display text to the screen, and to load images or files.
 
 Both `String` and `Character` are actually classes with their own methods, some of which are featured below.
 
 [Source](https://processing.org/examples/charactersstrings.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var letter: Character = "\0" // \0 is a null character, which is a good starting point.
    var words = "Begin..."
    
    func setup() {
        // Set the font
        textFont("Menlo-Regular")
    }
    
    func draw() {
        background(0) // Set background to black
        
        // Draw the letter to the center of the screen
        textSize(14)
        text("Click on the program, then type to add to the String", 50, 50)
        text("Current key: \(letter)", 50, 70)
        text("The String is \(words.count) characters long", 50, 90)
        
        textSize(36)
        text(words, 50, 120, 670, 850)
    }
    
    func keyTyped() {
        // The variable "key" always contains the value
        // of the most recent key pressed.
        if (key >= "A" && key <= "z") || key == " " {
            letter = key
            words.append(key)
            // Write the letter to the console
            print(key)
        }
    }
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
