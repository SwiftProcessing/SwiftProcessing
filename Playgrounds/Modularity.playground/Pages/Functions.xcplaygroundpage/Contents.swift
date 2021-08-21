//: [Previous](@previous)
/*:
 # Functions
 ### by Masood Kamandy for GSoC 2021
 
 ## Introduction
 
 Don't let the word *function* scare you. You've been using functions this entire time! Let's think back. Do you remember writing any code that ended in parentheses? Maybe` rect()` or `background()`? Well those are functions! You're practically a pro at using them, but it's also useful do make them yourself!
 
 One way to think about functions is that they are like the verbs of programming. They perform actions.
 
 ## But What Is A Function?
 
 A function is a piece of code that's been *encapsulated* or isolated and you know that it *just works*. It gives programmers a way of isolating small bits of code and solving smaller problems before they get to the big problems.
 
 That's actually what *computational thinking* is and you've probably been doing a lot of that too as you've gone through these Playgrounds. It means taking a large problem and dividing it up into small manageable chunks that you can solve one at a time.
 
 ### How Do I Make My Own Function?
 
 Let's make a function that draws a smiley-face.
 
 Functions in Swift are created with a function *declaration.* The declaration is the first line of a function's body. Our function is going to be called `drawSmiley()`. Notice that the `d` is lower case. Functions use **camel-casing.**
 
 Even before we start writing the function, it's a good idea to think through what we want to be able to control about our smiley face. For example, we could add parameters that allow us to control the function. Here are some examples of possible function declarations for a smiley face:
 
 ```
 // Just draw a smiley. No control.
 func drawSmiley() {
    // Drawing code goes here.
 }
 
 // Draw a smiley with an x and y.
 func drawSmiley(x: Double, y: Double) {
    // Drawing code goes here.
 }
 
 // Draw a smiley with an x, y, width, and height.
 func drawSmiley(x: Double, y: Double, width: Double, height: Double) {
    // Drawing code goes here.
 }
 //
 ```
 Pay close attention to the syntax of the function declaration. It follows this pattern:
 
 ```
 func functionName(parameterName: Type) {
 }
 ```
 The `parameterName` becomes a variable inside of the function that we can use.
 
 In general, it's best to put anything you want to control in the function declaration. Functions can be in different files and other people may want to use them without modifying your code. They should be able to read that first like and understand everything they can do with your function.
 
 For this example, we're going to use an x and y.
 
 ```
 func drawSmiley(x: Double, y: Double) {
    fill(170, 140, 250)
    circle(x, y)
    // The full smiley code is in the example below.
 }
 ```
 
 Once the smiley function definition is written, you can call it with just a function call. Whenever your compiler gets to the function call, it hops over to the body of the function and executes that code.
 
 So in `setup()` we could write:
 
 ```
 func setup() {
    drawSmiley(x: random(width), y: random(height))
    drawSmiley(x: random(width), y: random(height))
    drawSmiley(x: random(width), y: random(height))
 }
 ```
**Note:** The x: and the y: part of the function above is called an **argument label** and it's required. If you don't want agument labels to be required, you can add a `_` before them in the definition like this:
`func drawSmiley(_ x: Double, _ y: Double) {`
 
 ### Functions That Return Values
 
 There will be times that you need to write a function that returns a value or do some calculation for you. A good example of this in SwiftProcessing is the `dist()` function, which returns the distance between two points.
 
 Let's look at the syntax for functions that return values by writing a simple function that adds two numbers together:
 
 ```
 func add(_ left: Double, _ right: Double) -> Double {
    return left + right
 }
 ```
 In this function we made the argument labels optional and you'll notice the arrow afterward (`-> Double`). The arrow tells the compiler the type of data it will return. In this case it will be a Double.
 
 ## Let's finish our `drawSmiley()` function and draw a bunch to the screen. Try clicking the screen to see what happens.
 
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit

class MySketch: Sketch, SketchDelegate {
    
    func setup() {
        background(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        
        for _ in 0...25 {
            drawSmiley(x: random(width), y: random(height))
        }
    }
    
    func draw() {
    }
    
    func touchStarted() {
        setup()
    }
    
    func drawSmiley(x: Double, y: Double) {
        let faceSize = 100
        let eyeSize = 40
        let pupilSize = 10
        let smileSize = 25
        
        pushMatrix()
        
        translate(x, y)
        rotate(random(Math.two_pi))
        
        stroke(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        fill(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        circle(0, 0, faceSize)
        noStroke()
        fill(255)
        circle(-faceSize/5, -faceSize/7, eyeSize)
        circle(faceSize/5, -faceSize/7, eyeSize)
        fill(0)
        circle(-faceSize/5, -faceSize/7, pupilSize)
        circle(faceSize/5, -faceSize/7, pupilSize)
        fill(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))
        arc(0, faceSize/6, faceSize/6*2, smileSize, 0.0, Math.pi)
        
        popMatrix()
    }
}

//: ## Do you see all of the variables inside of drawSmiley()? Can you use those to create a function that's even more customizable by adding new parameters to the declaration?
//: ## Move the function call to draw() and see what happens. Do you know how you can fix the function to work in draw() too?
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
