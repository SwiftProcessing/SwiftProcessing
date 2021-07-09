//: [Previous](@previous)
/*:
 # Arrays
 ### by Masood Kamandy for GSoC 2021
 
 ## Introduction
 
 We've learned about variables to store data, but what about collections? For example, what if we were creating a group of circles, each with a different size or color? How would we store that information in a clean organized way?
 
 That's where arrays come in handy!
 
 ## Arrays
 
 Arrays are containers. They store a multiple versions of the same type of variable. For example, you can have an integer array or an array of strings. This becomes useful as your programs become more complex.
 
 ### Creating an Array
 
 To declare an array, use the following syntax:
 
 ```
 // Empty array
 var someInts: [Int] = []
 
 // A non-empty array of strings using 'array literal' syntax
 var someNames = ["Noor", "Raz", "Julio", "Jennifer", "Max"]
 ```
 ## Accessing Data Within Arrays
 
 Accessing data within arrays uses a special syntax. Each unit of data inside an array is called an *element*.
 
 ```
 // If we wanted to print "Noor" to the console
 print(someNames[0])
 ```
 The `0` in the syntax above inside the `[]` is called an *index number*. Because we always start counting from `0` on computers, `0` is the first element of the array.
 
 ## Iterating Over Arrays
 
 After you've stored a collection of data, sometimes it's important to go through each of the elements of an array and do something to them. This is called *iterating* over an array and one way to do that is with a for loop:
 
 ```
 for i in someNames {
    print(someNames[i])
 }
 ```
 This code iterates through the array of names and prints each one to the console. The `i` variable can be used to access elements or do anything else within the for loop. You can perform any operation you'd like on the elements of an array within the for loop. For example, if you had an array numbers that you all wanted to increment or do some math on, this could be easily achieved with the same method.
 
 ### Using Ranges to Populate an Array
 
 In the previous section *For Loops*, we discussed the range operators `...` and `..<`. These can be used to populate an array. Here's an example that populates a new array of Doubles with random numbers.
 
 ```
 var randomNumbers: Double
 
 for i in 0..<100 {
    randomNumbers.append(random(1000))
 }
 
 ```
 The `.append()` method on arrays adds an element to the end of an array.
 
 The code example counts from 0 to 99, generates a random number up to 1000, and stores the value at the end of the array.
 
 ## Let's use an array to draw a .
 */

import SwiftProcessing
import PlaygroundSupport
import UIKit

class MySketch: Sketch, SketchDelegate {
    
    let howManyCircles = 30
    let spacer = 25.0
    let maxSize = 100.0
    
    // Initialize an empty array of Doubles.
    var circleSizes = [Double]()
    
    func setup() {
        for _ in 0..<howManyCircles {
            circleSizes.append(random(50.0))
        }
    }
    
    func draw() {
        background(127)
        noFill()
        stroke(255)
        
        // Display all circles using the array of sizes.
        for i in 0..<howManyCircles {
            let d_i = Double(i)
            circle(d_i * spacer, height/2, circleSizes[i])
        }
        
        // Increment the sizes in the array by 1 until it gets to the maxSize and then repeat.
        for i in 0..<circleSizes.count {
            circleSizes[i] = (circleSizes[i] + 1.0) % maxSize
        }
    }
}
//: ## How will you use conditional logic for your programs? Challenge: Try to create a button using a rectangle with conditional logic.

PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
