//: [Previous](@previous)
/*:
 # Images
 ### by Masood Kamandy for GSoC 2021
 
 ## Introduction
 
 Using your own images or found images is another great way of creating diverse, rich interactive experiences. SwiftProcessing allows you to use JPG 
 
 ## SwiftProcessing's Image Class
 
 SwiftProcessing has a powerful class called `Image` that allows you to do many things with images. We're going to focus on the basics in this tutorial like placing an image in your sketch.
 
 ### Declaring Your Variable
 
 Images are stored in variables like anything else. In order to use one, you'll need to declare a variable at the top level of your Sketch class.
 
 When declaring variables in this location, Swift wants them either to be initialized or optionals. That's not possible in our situation because we're using a function to load our images, which we can only do inside of `setup()` or `draw()`.
 
 That's where ***implicitly unwrapped optionals*** come in handy. When you see a variable declared at the top level with an exclamation point, you're basically telling Swift that you're fairly certain that this will be initialized and not to worry about it. After this, you can treat it like any other variable because Swift is expecting it to never be `nil`. It's important to remember, though, that if it ever is `nil` your program will crash.
 
 At your top level, your declaration looks like this:
 
 ```
 var pluto: Image!
 ```
 
 Try deleting the `!` and see the error that Xcode gives you. Remember this error, because it can be a confusing one and it's easily fixed by adding the `!`.
 
 ### Loading Your Image
 
 You'll need to load your image into your variable and SwiftProcessing comes with a function that does this for you. This function is the `loadImage()` function. **Note:** Because this operation is slow and accesses the disk, it's important not to do this inside the draw loop. You really only need to do this once inside of `setup()` except in special cases.
 
 ```
 pluto = loadImage("pluto.jpg")
 ```
 
 ### Displaying Your Image
 
 For images to show up, we need to display them and this takes place in the `draw()` function. There are a few different ways to display your image using the `load()` function. We'll be passing our image variable into this function.
 
 `load(image, x, y)`: If you're sure your size is fine, you can just place the image using x and y coordinates.
 `load(image, x, y, w, h)`: Allows you to specify the x, y, width, and height of your image.
 
 The code below will be and we're using SwiftProcessing's built in `center` variable which gives us the center of the screen:
 
 ```
 image(pluto, center.x, center.y, 500, 500)
 ```
 
 ### Bonus: Sampling Colors From Your Sketch
 
 SwiftProcessing also enables you to sample colors from your images or your sketch. This is done with the `get()` function.
 
 `get(x, y)`: returns the color at the specified x and y location.
 
 Below we put it in `touchStarted()`. Because `get()` returns a color, you can put it inside of the `background()` function:
 
 ```
 background(get(touchX, touchY))
 ```
 ## How about we use an image of Pluto? Make sure to tap around the image and see what happens to the background!
 
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit

class MySketch: Sketch, SketchDelegate {
    
    var pluto: Image!
    var imageSize = 500 // Our image will be 500 pts wide and high
    
    func setup() {
        pluto = loadImage("pluto.jpg")
        imageMode(.center) // Draws images from their center point.
        background(50, 0, 125)
    }
    
    func draw() {
        image(pluto, center.x, center.y,500,500)
    }
    
    func touchStarted() {
        background(get(touchX, touchY))
    }
}

//: ## Can you create a program that samples different areas randomly and sets of color palettes?
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
//:  ### Credit for image used in Tutorial
//: Source: [NASA/JHUAPL/SwRI](https://solarsystem.nasa.gov/resources/795/the-rich-color-variations-of-pluto/?category=planets/dwarf-planets_pluto)
//: [Next](@next)
