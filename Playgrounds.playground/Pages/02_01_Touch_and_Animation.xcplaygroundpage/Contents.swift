//: [Previous](@previous)
/*:
 # Touch and Map
 ### by Masood Kamandy for GSoC 2021
 
 ## Introduction
 
 The essence of the experience on touchscreen devices is touch in combination with animation. In the fields of interaction design and human computer interaction (HCI) this is called [*Direct Manipulation*](https://www.nngroup.com/articles/direct-manipulation/).
 
 One of the earliest examples of direct manipulation was Ivan Sutherland's Sketchpad, which allowed a computer operator to use a pen to create and interact with vector drawings in 1963.
 
 The mouse is another example of direct manipulation. You use a physical gesture to click and drag files wherever you'd like them to go. It's become so deeply ingrained that we don't really think about it anymore.
 
 With the development of smartphones with capacitive touch (Links to an external site.) displays, we can actually touch and move objects on a screen, giving us immediate feedback as we perform actions through a graphical user interface.
 
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
    
    func setup() {
    }
    
    func draw() {
        
    }
    
    func touchStarted() {
    }
    
    func touchMoved() {
    }
    
    func touchEnded() {
    }
}
//: ## TK
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
