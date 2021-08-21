//: [Previous](@previous)
/*:
 # For and While Loops
 ### by Masood Kamandy for GSoC 2021
 
 ## Introduction
 
 Earlier in the series we talked about DRY code, which stands for DON'T REPEAT YOURSELF. The goal of programming is to do as much as we can in the smallest amount of code. Up until now you've probably found that very difficult.
 
 After you read through this playground, if you notice you are repeating yourself in code, you'll have the tools to shorten your code! Those tools come in the form of `for` and `while` loops.
 
 Sometimes there are repetitive tasks where we're only changing one small thing. For example, what if I wanted to create hundreds or thousands of raindrops. It wouldn't make sense to inidividually code each raindrop, so that's where these new concepts help us out!
 
 ## For Loops
 
 The `for` loop is the first structure you'll learn that allows you complete an action repeatedly. A for loop repeats going over a section of code as many times as you want to. It acts like a counter and you can set it up to count up to whatever number you would like.
 
 Here is the structure of a for loop:
 
 ```
 for index in start...end {
    statements
 }
 ```
 `start` and `end` are numbers. We're creating a range to count through. They must be `Int`'s
 `...` is an inclusive range operator. It counts from `start` to `end` inclusively.
 `index` is where you are currently in the count. It will start at `start` and repeat until it gets to `end`.
 `statements` is whatever code you want to repeat.
 
 Here is some real code:
 
 ```
 for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
 }
 ```
 ***Note:*** If you did not want the range to be inclusive, you could use the `..<` operator, which excludes the upper bound.
 
 The previous `for` loop increments by 1. There will be times you need to incrememnt by other intervals. For this we use the following syntax:
 
 ```
 let interval = 5
 for index in stride(from: 0, to: 50, by: interval) {
    print(index) // prints 0, 5, 10, 15 ... 45, 50
 }
 
 ```
 
 ## Nested For Loops
 
 There will be times when you will need to *nest* for loops. This means place one loop inside another. In general with any kind of conditional or looping structure, you can nest infinitely. The challenge is that sometimes nesting loops and conditionals can make code difficult to read.
 
 Nesting loops is particularly useful when drawing things in two dimensions, like grids. For example, say I have 25 circles that I want to distribute evenly across the screen in a grid fashion?
 
 ```
 translate(144, 144)
 for x in 0..<20 {
    for y in 0..<20 {
        fill(random(255))
        circle(x * 25, y * 25, 5)
    }
 }
 ```
 ***Challenge:*** In the example above we use the number 25 as a spacer. Now what if you wanted to distribute the shapes evenly across the canvas? How would you do that?
 
 ## While Loops
 
 Another way to loop is just to loop indefinitely until some condition is true. That's where the `while` loop comes in handy.
 
 This is the syntax of a while loop:
 
 ```
 while condition {
 statements
 }
 ```
 
 ***Note:*** While loops can cause problems if you don't have a proper exit condition. Without an exit condition, the computer can get stuck in what's called an ***infinite loop.*** Print statements inside of while loops can help clarify what is happening to your variables inside of your while loop. Use them liberally.
 
 ## Let's use a for loop to draw a gradient of lines down the screen.
 */

import SwiftProcessing
import PlaygroundSupport
import UIKit

class MySketch: Sketch, SketchDelegate {
    
    var topColor = Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
    var bottomColor = Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
    
    var increment = 32
    
    func setup() {
        // Remember that the start and end of a for loop need to be both be integers.
        // Height is a double, so we'll convert it to an integer.
        
        for i in stride(from: increment/2, to: Int(height), by: increment) {
            // To use i in SwiftProcessing functions it should be converted to a Double.
            let double_i = Double(i)
            
            // Get mapped colors that fade from topColor to bottomColor
            // Creating gradients involves mapping from one
            // color's r,g,and b values to another.
            let red = map(double_i, 0, height, topColor.red, bottomColor.red)
            let green = map(double_i, 0, height, topColor.green, bottomColor.green)
            let blue = map(double_i, 0, height, topColor.blue, bottomColor.blue)
            
            // Draw lines from the top of the screen to the bottom.
            strokeWeight(increment)
            stroke(red, green, blue)
            line(0, double_i, width, double_i)
        }
        
    }
    
    func draw() {
    }
}
//: ## How will you use conditional logic for your programs? Challenge: Try to create a button using a rectangle with conditional logic.

PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
