//: [Previous](@previous)
/*:
 # Optionals: What does the ?, !, and ?? mean?!
 ### by Masood Kamandy for GSoC 2021
 
 ## Introduction

 Swift is unique when compared to many other programming languages. In Swift you can declare variables as *optionals*. Remember this term, because it will come up over and over again.

 ## Optionals Are Like Wrapped Gifts 🎁
 
 Declaring an optional, basically means that you don't really know if it will be filled with data, and that's OK. Think of an optional as a container which may or may not contain data. You could look at it like it were a wrapped gift box. When you see a gift, you think there must be something inside, but you won't know until you unwrap it and look whats inside.

 If it's an integer optional, then it is a container which **may or may** not contain an integer. If it's a string optional, it **may or may not** contain a string.

 Up till now, when we've created variables we've always assigned them right away. In these situations, Swift looks on the right side of the = sign and determines the data type for you. You don't need to specify. This is called *type inference.*
 
 For example, here Swift will know that myLuckyNumber is an integer because 7 is there to guide it:

 ```
 var myLuckyNumber = 7
 ```
 
 ## First Let's Talk About ?
 
 There may be some situations where you want to *create a variable and specify it's data type without assigning a value to it.* This is where optionals come in!
 
 To explicitly declare an optional and specify the data type (for example an integer) without assigning a value to it, you would write the following:

 ```
 var myNumber: Int?
 ```

 `Int?` and `Int` are completely different data types, so you must always remember when something is an optional. Xcode helps us out by helping us remember whether to put a `?` in or not. It will often fix any potential problems for you, and go ahead and allow Xcode to do its magic as you become accustomed to using `?` throughout your code.

 When you are declaring any data (whether a variable or a class) globally, you may need to declare it as an optional if it requires any kind of function call to calculate. For example, say you'd like to create a variable accessible in both `setup()` and `draw()` that calculates the distance from (0,0) to (width,height) using SwiftProcessing's `distance()` function. You might want to write it like this:
 
 ```
 class MySketch: Sketch, SketchDelegate {
     
     var myDistance = distance(0, 0, width, height)
     
     func setup() {
     }
     
     func draw() {
     }
 }
 ```
 
 This will cause an error. Variables declared at the top level of a class (also called *property initializers*) happen before `width`, `height`, or even `distance()` is available to use. To fix this,we can use an optional and do our calculations inside of `setup()`.
 
 ```
 class MySketch: Sketch, SketchDelegate {
     
     var myDistance: Double?
     
     func setup() {
         myDistance = distance(0,0,width,height)
         print(myDistance!)
     }
     
     func draw() {
     }
 }
 ```

 At first, this is by far one of the most confusing aspects of Swift, and you will continue to work on this as you move forward.
 
 ## Checking for Nil Values

 The term we use in Swift to represent ***nothing*** is `nil`. If an optional is ***empty***, then it will be `nil`, and we can actually test for `nil` values in our code.

 There are times when you may want to check that an optional you created does not have a `nil` value. In other words, you want to check that it isn't empty.

 One easy way to do this is with an if statement:

 ```
 if myOptional != nil {
    // Do something using `myOptional`.
 }
 ```

 You may recall that `!=` means *does not equal*.

 In plain English, the code above says:

 If myOptional does not equal nil, then do something.
 
 ## Now about that !: Forced Unwrapping

 In order to use an optional in an expression, it needs to be unwrapped. Some of you will, no doubt, have noticed that Xcode will "nag" you about putting a ! on some variables before you use them. This is because they are optionals, and they need to be unwrapped before you can use them!

 Here's some example code:

 ```
 var firstNumber: Int? // Here I've declared an integer optional.
 firstNumber = 5 // I've assigned 5 to it.

 var secondNumber = 2
 var mySum = firstNumber! + secondNumber
 ```

 If you were to remove the `!` after firstNumber, Xcode would throw an error.
 
 ## And Now About ??: Nil-Coalescing Operator

 If you want to create an optional with a default value, then you'll want to use the ***nil-coalescing operator***, better known as `??`. It's got a fancy name, but it's actually pretty simple to use.

 For example, if you wanted to create an integer with a **default value of 0**, here's what your code would look like:

 ```
 var defaultNumber = 0
 var userDefinedNumber: Int? // defaults to nil

 var numberToUse = userDefinedNumber ?? defaultNumber
 ```

 By default, `numberToUse` will always return `0` until the `userDefinedNumber` has a value stored in it. This is good code that prevents crashes when you are relying on users to input data.
 
 ## Let's use an array to draw a .
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit

class MySketch: Sketch, SketchDelegate {
    
    // The SwiftProcessing Vector class can store x and y values for screen coordinates.
    // These Vectors are declared as optionals.
    var corner1: Vector?
    var corner2: Vector?
    var corner3: Vector?
    var corner4: Vector?
    
    var inset = 100.0
    
    func setup() {
        corner1 = Vector(inset, inset)
        corner2 = Vector(width - inset, inset)
        corner3 = Vector(inset, height - inset)
        corner4 = Vector(width - inset, height - inset)
        
        // In order to print them we need to force unwrap them.
        print(corner1!)
        print(corner2!)
        print(corner3!)
        print(corner4!)
    }
    
    func draw() {
        // In order to use them as arguments in the quad() funtion, we need to force unwrap them.
        quad(corner1!.x, corner1!.y, corner2!.x, corner2!.y, corner3!.x, corner3!.y, corner4!.x, corner4!.y)
    }
}
//: ## Can you alter this sketch to use an array instead of numbered variables?
//: ## Can you explain why it's an hourglass shape instead of a rectangle?
//: ## Can you incorporate touch to move each of the corners when they are touched? (Hint: use the distance() function.)
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
