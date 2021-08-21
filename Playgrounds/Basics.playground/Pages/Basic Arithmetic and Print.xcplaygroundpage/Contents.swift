//: [Previous](@previous)
/*:
 # Basic Arithmetic and Print
 ### by Masood Kamandy for GSoC 2021
 
 ## Introduction
 
 To write code, you don’t need to be a mathematician. __A basic knowledge of arithmetic will do for most projects__. If you need to go deeper, you can do so on a project by project basis or collaborate.
 
 You'll also need to be able to display the values of variables to make sure things are working the way you intended. We call this "printing" a variable, though it is usually just "printed" to the screen.
 
 ## How Computers Count
 
 Look at your hands and count with your fingers to ten. __Notice how you, a human, count__. In many parts of the world, people start with their index finger and start counting with the number 1.
 
 Unlike humans, computers always start with 0 when they count. That means zero is the first number. That might seem counter-intuitive.

 This is why the upper left-hand corner of the screen is (0,0).

 You will inevitably encounter an error because you started counting with 1. It's OK! This is a common mistake.
 This is called an __Off-by-one error__.
 
 ## Basic Arithmetic
 
 ### Arithmetic Operators
 
 The arithmetic and basic operators we will be using are:
 
![A table showing the arithmetic operators with the following rows: 1. + is Addition 2. - is Subtraction 3. * is Multiplication 4. / is Division 5. = is Assignment. % is Remainder](arithmetic_operators.jpg)
 
### More Operators
 
 In addition to arithmetic operators, in computing you can use __unary operators__ or __assignment operators__.
 Unary operators work on a __single number__. Assignment operators __combine assignment (=) with other operators__. Some of the operators are here (left), with names (middle) and examples (right):
 
 ![A table showing the unary and assignment operators with the following rows: 1. - is Unary Minus (Switches Sign) 2. += is Additive Assignment 3. -= is Subtractive Assignment 4. *= is Multiplication Assignment 5. /= is Division Assignment. 6. %= is Remainder Assignment](operators.jpg)
 
 ### The % (Modulo) is Special
 
 There will be many times when you will need to increment a variable until it reaches a certain point and then have it start over again. An easy way to do this is to use the modulo operator. Modulo gives you the remainder when one number is divided by another. A side effect of this is that it also creates a cap on how much a number can be incremented. This use of a modulo is implemented in the code below.
 
 ### Printing Variable Values to the Console
 
 There will be times when you need to see the value of variables as they change. This is __very useful__ for debugging and understanding how your program is working. Just remember that even though you're writing your code, every programmer sometimes has trouble understanding what they've written.
 
 That's where `print()` comes along and helps us!
 
 If you want to know what value a variable is, just print it. For example, if you have a variable called `playerXPos` for the x-position of a player and you want to know what number that is, type this:
 
 `print(playerXpos)`
 
 This will display the number in your __console__ which is an area below your code editor.
 
 If you want to combine a string and a variable you can use __string interpoloation__ which is a way of combining strings and non-string variable values. It basically converts your variables to strings. We use the format `\(variable)`. For example, if I wanted to create a sentence, you'd type:
 
 `print("The x position of the player is \(playerXpos).")`
 
## Let's play with some basic arithmetic!
 
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit

class MySketch: Sketch, SketchDelegate {
    
    // Change any of these variables to see how it changes the sketch!
    var xPos = 25.0
    var yPos = 25.0
    
    var xSpeed = 5.0
    var ySpeed = 0.16
    
    var gray = 0.0
    var colorIncrement = 20.0
    
    let diameter = 25.0

    func setup() {
        background(0)
    }
    
    // This time we're going to use the draw loop, which repeats itself at 60 frames per second by default. This allows us to do some animation!
    func draw() {
        
        // Shape drawing functions
        noStroke()
        fill(gray)
        circle(xPos, yPos, diameter)
        
        // Incrementing variables with a limit using % (Modulo).
        // It will increment up to the width/height and then go
        // back to zero.
        
        xPos = (xPos + xSpeed) % width
        yPos = (yPos + ySpeed) % height
        
        // Uncomment the print statements below to see variable values printed to the console
        //print(xPos)
        
        gray = (gray + colorIncrement) % 255.0
        //print(gray)
    }
}
//: ## Can you modify this code to use colors or create a different animated behavior?
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
