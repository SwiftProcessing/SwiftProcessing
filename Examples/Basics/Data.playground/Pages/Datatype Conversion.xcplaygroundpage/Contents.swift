/*:
 ## Datatype Conversion
 
 It is sometimes beneficial to convert a value from one type of data to another. Each of the conversion functions converts its parameter to an equivalent representation within its datatype. The conversion functions include int(), float(), char(), byte(), and others.
 
 [Source](https://processing.org/examples/datatypeconversion.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    func setup() {
        
        background(0)
        
        textFont("Menlo-Regular")
        textSize(24)
        
        let c: Character    // Chars are used for storing alphanumeric symbols
        let d: Double   // Doubles are decimal numbers
        let i: Int    // Integers are values between 9,223,372,036,854,775,807 and -9,223,372,036,854,775,808
        let b: UInt8   // UInt8's are values between 0 and 255
        
        c = "A"
        d = Double(c.asciiValue!)      // Sets d = 65.0
        i = Int(d * 1.4)  // Sets i to 91
        b = UInt8(c.asciiValue! / 2)   // Sets b to 32
        
        //print(d)
        //print(i)
        //print(b)
        
        text("The value of variable c is \(c)", 50, 100);
        text("The value of variable f is \(d)", 50, 150);
        text("The value of variable i is \(i)", 50, 200);
        text("The value of variable b is \(b)", 50, 250);
    }
    
    func draw() {
        
    }
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
