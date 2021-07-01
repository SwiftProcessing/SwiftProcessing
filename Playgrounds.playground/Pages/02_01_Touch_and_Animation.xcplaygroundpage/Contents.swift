//: [Previous](@previous)
/*:
 # Touch
 ### by Masood Kamandy for GSoC 2021
 
 ## Introduction
 
 The essence of the experience on touchscreen devices is touch in combination with animation. In the fields of interaction design and human computer interaction (HCI) this is called [*Direct Manipulation*](https://www.nngroup.com/articles/direct-manipulation/).
 
 One of the earliest examples of direct manipulation was [Ivan Sutherland's Sketchpad](https://en.wikipedia.org/wiki/Sketchpad), which allowed a computer operator to use a pen to create and interact with vector drawings in 1963.
 
 The mouse is another example of direct manipulation. You use a physical gesture to click and drag files wherever you'd like them to go. It's become so deeply ingrained that we don't really think about it anymore.
 
 With the development of smartphones with [capacitive touch](https://electronics.howstuffworks.com/iphone1.htm) displays, we can actually touch and move objects on a screen, giving us immediate feedback as we perform actions through a graphical user interface.
 
 ## SwiftProcessing's Touch Attributes
 
 SwiftProcessing comes with built in attributes that give us access to touch.
 
 `touchX` - Returns the x coordinate of the point being touched. \
 `touchY` - Returns the y coordinate of the point being touched.\
 
 ## SwiftProcessing's Touch Functions
 
 The SwiftProcessing touch functions can help you handle touches. These are optional functions that you can add in addition to `setup()` and `draw()`.
 
 `func touchStarted()` - Executes when a finger hits the screen.\
 `func touchMoved()` - Executes when a finger has moved.\
 `func touchEnded()` - Executes when a finger has left the screen.
 
 ## Let's get interative with touch!
 
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit

class MySketch: Sketch, SketchDelegate {
    
    var rotation = 0.0
    var rotationIncrement = 0.05
    
    var squareSize = 50.0
    
    func setup() {
    }
    
    func draw() {
    }
    
    func touchStarted() {
        background(random(255.0), random(255.0), random(255.0))
        print("touch started")
    }
    
    func touchMoved() {
        noStroke()
        
        rotation = (rotation + rotationIncrement) % 360.0
        fill(random(255.0), random(255.0), random(255.0))
        
        // The translate() function moves the origin.
        // Step 1: Move the origin to wherever I'm touching
        translate(touchX, touchY)
        
        // Step 2: Rotate the coordinate system around the origin.
        rotate(rotation)
        
        // Step 3: Draw a rectangle with its center on the origin.
        rect(-squareSize/2, -squareSize/2, squareSize, squareSize)
    }
    
    func touchEnded() {
        // Draw bullseye shape.
        fill(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        circle(touchX, touchY, squareSize)
        fill(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        circle(touchX, touchY, squareSize * 0.66) // Reduce size of circle to 2/3
        fill(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        circle(touchX, touchY, squareSize * 0.33) // Reduce size of circle to 1/3
        print("touch ended")
    }
}
//: ## Can you change the code so that your color palette is not just random? Try making the worm all shades of pink! Or try making the background simply gray! Maybe instead of a square you can use different shapes!
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
