//: [Previous](@previous)
/*:
 # Map and Lerp
 ### by Masood Kamandy
 
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
 
 * `start` - The number you are starting with
 * `stop` - Your target number
 * `amount` - How fast you'd like to get there. Between 0.0 to 1.0. Lower is slower and smoother.
 
 ## LerpColor
 
 It's also sometimes useful to be able to interpolate between colors. SwiftProcessing has a convenient function called `lerpColor()` that works in this way. `lerpColor()` has the following syntax:
 
 `lerpColor(color1, color2, amount)`
 
 * `color1` - First color. Color can be either a UIColor, Color Literal, or a SwiftProcessing Color.
 * `color2` - Second color.
 * `amount` - A number from 0.0 to 1.0. The closer you are to 0.0, the closer you'll be to `color1`. The closer you are to 1.0, the closer you'll be to `color2`.
 
 ## Let's try out some mapping and lerping! Click and drag around the sketch.
 
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
    
    // Declare colors as optionals
    var topColor: Color!
    var bottomColor: Color!
    
    var backgroundTop: Color!
    var backgroundBottom: Color!
    
    func setup() {
        // We're going to map between two colors from the
        // top of the screen to the bottom to mimic sunset and sunrise.
        topColor = color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))
        bottomColor = color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))
        
        backgroundTop = color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        backgroundBottom = color(#colorLiteral(red: 0.009056979678, green: 0, blue: 0.5434187807, alpha: 1))
        
        // The default starting value for touchX and touchY is 0.0, so it will draw in the corner if we don't change it before draw is called.
        
        // Comment these out and see how the sketch changes.
        touchX = width/2
        touchY = height/2
    }
    
    func draw() {
        (background(lerpColor(backgroundTop, backgroundBottom, y/height)))
        
        // Lerp moves us toward our target of touchX and touchY, but slowly.
        
        (x = lerp(x, touchX, lerpAmount))
        (y = lerp(y, touchY, lerpAmount))
        
        (noStroke(),
        
        // Because map returns a number, you can use it inside of other functions. Since it can be hard to read, it's OK to separate things over a few lines to make it easier to read. Comments can also help make things more clear.
        
        fill(lerpColor(topColor, bottomColor, y/height)),
        
        // We feed in our lerped x and y to the circle position. Notice how smooth the motion is.
        
        // Try replacing the x and y with just touchX and touchY to feel the difference.
        
        circle(x, y, diameter))
        
    }
    
    
}
//: ## How will you make this sketch your own? Modify it to use different shapes or lines, or move `background()` to setup to see the lines you draw. Change the color gradient.
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
