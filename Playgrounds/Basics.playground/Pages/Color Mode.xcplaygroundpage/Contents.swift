//: [Previous](@previous)
/*:
 # Color Mode
 ### by Masood Kamandy for GSoC 2021
 
 ## Introduction
 
 Even though computers represent color information in RGB, it can be difficult for humans to use RGB mode because it can feel lik ea foreign way of thinking. Hue, saturation, and brightness can be an easier way to think about colors for people.
 
 ## RGB vs HSB
 
 The default color mode of SwiftProcessing is RGB. So when you first start out, you don't really have to pay attention to anything and you can just work in colors that way. As you get more used to programming with color, you'll likely want to be more targetted about the kinds of colors you choose. This is difficult to do with RGB mode. For example, say you'd like to choose random shades of purple that are slightly desaturated. That's where HSB mode comes in.
 
 In HSB mode, colors are represented by degree values from 0 to 360.
 
 ![A simple color circle using RGB primary colors](color_wheel.png)
 
 [Source](https://commons.wikimedia.org/wiki/File:RGB_color_circle.png)
 
 We'll use the `fill()` function below to show the standard form for setting a color in HSB's parameters is:
 
 `fill(hue, saturation, brightness)` or `fill(hue, saturation, brightness, alpha)`
 
 `hue` – is a value from 0 – 360.\
 `saturation` — is a value from 0 – 100.\
 `brightness` – is a value from 0 – 100.\
 `alpha` – is a value from 0 – 100.
 
 You might have noticed that the **maximum value of alpha changes to 100 in HSB mode**. This is for consistency and might remind you of working with colors in Adobe Photoshop or programs like it.
 
 ## How do you change color modes?
 
 Swift Processing has a color mode helper function that allows you to change color modes. You can place the helper mode in `setup()` or `draw()` and you can set and reset them as much as you'd like.
 
 To change to HSB mode:
 
 ```
 colorMode(.hsb)
 ```
 To change back to RGB mode:
 ```
 colorMode(.rgb)
 ```
 
 ## In this example we create a series of circles that shrink and incrementally shift the colors as we draw over the previous circles.
 
 ## Import Modules
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit
//: ## SwiftProcessing Sketch Code
class MySketch: Sketch, SketchDelegate {
    
    // Create a couple of Double variables that we can manipulate later.
    var size: Double!
    var hue: Double!
    
    func setup() {
        (background(0))
        
        // Set the color mode to HSB.
        (colorMode(.hsb))
        
        // Initialize variables.
        (size = width-50)
        (hue = random(360))
    }
    
    func draw() {
        (noStroke())
        (fill(hue, 100, 100))
        (circle(width/2, height/2, size))
        
        (hue = (hue + 0.25) % 360)
        
        (size -= 1.0)
        if size < 0 {
            (size = width-50)
            (hue = random(360))
        }
    }
}
//: ## Can you change this sketch to create specific ranges of colors? Maybe you only want shades of blue or another color. Can you manipulate the brightness and saturation values also?
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
