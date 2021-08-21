//: [Previous](@previous)
/*:
 # Randomness
 ### by Masood Kamandy for GSoC 2021
 
 ## Introduction
 
 Random numbers are essential to create variation in visual art and design projects with code. In this section we will write our first function for randomness using some of the built in code for generating random numbers.

 **Note:** Random numbers in computing are not truly random. They are created using an equation and produce enough variation to seem random. Because of this, they are called *pseudorandom* numbers.
 
 ## SwiftProcessing's Random Function
 
 SwiftProcessing comes with a random function that can work in a couple of different ways. Here is the syntax:
 
 `random()` - Returns a random Double between 0.0 and 1.0 (inclusive).\
 `random(high)` - Returns a random Double between 0.0 and the high parameter.\
 `random(low, high)` - Returns a random Double betwen the low and high parameters.
 
 ## Swift's Random Functions
 
 Swift itself makes generating random numbers easy. Although SwiftProcessing has its convenient function, if you are working in a specific data type, you can always call the type's random function itself. Because these functions are in the type themselves, they are called *type methods*.
 
 ### Ranges
 
 To use Swift's random methods, you'll need to know what a *range* is. There are a couple of range operators that will be super useful and we'll go more into this in the *For Loops* section. Wherever Swift expects a range, you can use the `...` or `..<` operators. `...` is an inclusive range. So `0...100` would be 0 through 100 *including* 100. `0..<100` would mean 0 through 100 *excluding* 100, or 0 through 99.
 
 Here are some examples of Swift's random type methods to generate a number from 0 to 100 inclusive:
 
 ```
 // Integer
 var myRandom = Integer.random(in: 0...100)
 // Doubles
 var myRandom = Double.random(in: 0.0...100.0)
 // Float
 var myRandom = Float.random(in: 0.0...100.0)
 // CGFloat
 var myRandom = CGFloat.random(in: 0.0...100.0)
 // You get the idea! Pretty simple!
 ```
 
## Let's roll the dice and play with some random numbers!
 
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit

class MySketch: Sketch, SketchDelegate {
    
    // It's possible to declare multiple variables with the same value in a single line!
    var xPos0 = 0.0, xPos1 = 0.0, xPos2 = 0.0, xPos3 = 0.0, xPos4 = 0.0
    var yPos0 = 0.0, yPos1 = 0.0, yPos2 = 0.0, yPos3 = 0.0, yPos4 = 0.0
    
    var ySpeed0 = 0.0, ySpeed1 = 0.0, ySpeed2 = 0.0, ySpeed3 = 0.0, ySpeed4 = 0.0
    var maxSpeed = 10.0

    // This is a partially transparent gray color.
    // This is what gives our raindrops trails.
    var skyColor = Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.1))
    var raindropColor = Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
    
    var diameter0 = 0.0, diameter1 = 0.0, diameter2 = 0.0, diameter3 = 0.0, diameter4 = 0.0
    var maxDiameter = 50.0

    // We're going to generate our random numbers once at the beginning.
    func setup() {
        xPos0 = random(width)
        xPos1 = random(width)
        xPos2 = random(width)
        xPos3 = random(width)
        xPos4 = random(width)
        
        yPos0 = random(height)
        yPos1 = random(height)
        yPos2 = random(height)
        yPos3 = random(height)
        yPos4 = random(height)
        
        ySpeed0 = random(maxSpeed)
        ySpeed1 = random(maxSpeed)
        ySpeed2 = random(maxSpeed)
        ySpeed3 = random(maxSpeed)
        ySpeed4 = random(maxSpeed)
        
        diameter0 = random(maxDiameter)
        diameter1 = random(maxDiameter)
        diameter2 = random(maxDiameter)
        diameter3 = random(maxDiameter)
        diameter4 = random(maxDiameter)
    }
    
    // The draw loop is going to make our randomized raindrops fall down the screen.
    func draw() {
        background(skyColor)
        noStroke()
        
        fill(raindropColor)

        circle(xPos0, yPos0, diameter0)
        circle(xPos1, yPos1, diameter1)
        circle(xPos2, yPos2, diameter2)
        circle(xPos3, yPos3, diameter3)
        circle(xPos4, yPos4, diameter4)
        
        yPos0 = (yPos0 + ySpeed0) % height
        yPos1 = (yPos1 + ySpeed1) % height
        yPos2 = (yPos2 + ySpeed2) % height
        yPos3 = (yPos3 + ySpeed3) % height
        yPos4 = (yPos4 + ySpeed4) % height
    }
}
//: ## Can you change this code to add your own flair to our rainstorm?
//: ## Bonus: Did you notice how repetitive this code was?
//: This is usually not a good idea because it doesn't adhere to an important rule of thumb in programming: don't repeat yourself. This is also known as DRY. Don't worry! Soon we'll be able to reduce all of this code to a few lines using some new coding skills for repetition and our raindrop code will be nice and DRY! Stay tuned!
PlaygroundPage.current.setLiveView(MySketch())
//: ## Congratulations! You've completed the Basics section. Move on to the next section for more!
