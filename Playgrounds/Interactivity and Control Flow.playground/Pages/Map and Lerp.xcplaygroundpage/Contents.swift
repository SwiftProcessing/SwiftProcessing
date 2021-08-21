//: [Previous](@previous)
/*:
 # Map and Lerp
 ### by Masood Kamandy for GSoC 2021
 
 ## Introduction
 
 Sometimes numbers don't do exactly what we want them to do, so one important skill in creative coding is to learn to manipulate numbers to achieve the desired results. The first two functions that will really help you achieve this goal are `map()` and `lerp()`.
 
 ## Map
 
 The SwiftProcessing `map()` function allows us to take one range of numbers and stretch or shrink it to another range.
 
 For example, you are taking the x position of the touch and you want that to change the color of some element on the screen based on the x position. The problem we have is that there are only 255 possible shades of each color, but there are many more pixels (the `width` attribute would tell you exactly how many pixels there are).
 
 This is where `map()` comes in handy. We could map the width of the screen to the number of available colors.
 
 This function has a *return* value. That means that it creates a new number that has to be assigned to a variable.
 
 In this situation we'd need to do the following:
 
 1. Take in the variable we'd like to map.
 1. Tell it what range that variable normally has.
 1. Tell it what *new* range we'd like to map that onto.
 
 The `map()` function has the following syntax:
 
 `map(value, start1, stop1, start2, stop2)`
 
 * `value` - the variable you'd like to remap.\
 * `start1` and `stop1` - the low and high values of the current range.\
 * `start2` and `stop2` - the low and high values of the new range.
 
 ## Lerp
 
 There are going to be times when you want something to move on the screen, but you want it to move smoothly. This can be useful if you're taking a noisy input, like touch position or microphone input.

 Lerp stands for **linear interpolation**. It's widely used and will become important as you control and smooth whatever input data you are using.
 
 The `lerp()` function has the following syntax:
 
 `lerp(start, stop, amount)`
 
 * `start` - the number you are starting with
 * `stop` - your target number
 * `amount` - how fast you'd like to get there. Between 0.0 to 1.0. Lower is slower and smoother.
 
 ## Let's try out some mapping and lerping!
 
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit

class MySketch: Sketch, SketchDelegate {
    
    var diameter = 100.0
    
    var lerpAmount = 0.25
    var x = 0.0
    var y = 0.0
    var targetX = 0.0
    var targetY = 0.0
    
    // We're going to map between two colors from the
    // top of the screen to the bottom.
    var topColor = Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
    var bottomColor = Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
    
    func setup() {
        // The default starting value for touchX and touchY is 0.0,
        // so it will draw in the corner if we don't change it before
        // draw is called.
        
        // Comment these out and see how the sketch changes.
        touchX = -diameter * 2
        touchY = -diameter * 2
    }
    
    func draw() {
        background(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        // Lerp moves us toward our target of touchX and touchY, but slowly.
        x = lerp(x, touchX, lerpAmount)
        y = lerp(y, touchY, lerpAmount)
        
        noStroke()
        
        // Because map returns a number, you can use it inside of other functions.
        // Since it can be hard to read, it's OK to separate things over a few
        // lines to make it easier to read. Comments can also help make things
        // more clear.
        
        fill(
            map(touchY, 0, height, topColor.red, bottomColor.red), /* red */
            map(touchY, 0, height, topColor.green, bottomColor.green), /* green */
            map(touchY, 0, height, topColor.blue, bottomColor.blue)  /* blue */
        )
        
        // We feed in our lerped x and y to the circle position.
        // Notice how smooth the motion is.
        
        // Try replacing the x and y with just touchX and touchY
        // to feel the difference.
        circle(x, y, diameter)
        
    }
    
    
}
//: ## How will you make this sketch your own? Modify it to use different shapes or lines, or move `background()` to setup to see the lines you draw. Change the color gradient.
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
