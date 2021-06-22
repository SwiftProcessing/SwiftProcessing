/*:
 # Getting Started with SwiftProcessing
 ### by Masood Kamandy for GSoC 2021
 
 Welcome to SwiftProcessing and the world of creative coding. In the following tutorials you will learn the basics of learning to code creatively to produce artworks of your own.
 
 Before we get started, we'll need to use an import statement to bring SwiftProcessing's code into our playground. You'll see this on every playground in this series.
 ## Import Modules
 */
import SwiftProcessing
import PlaygroundSupport
//: ## Your first Processing Sketch
//: Code runs from top to bottom. Learning how to follow the steps of your code is one of the most important skills you'll learn!
//: Functions are chunks of code that do actions. Eventually you'll write your own functions, but for now Processing sketch's are made up of two fundamental functions.
//: 1. `func setup()` - This happens once at the very beginning of your sketch. Whatever commands you write in here will be called when your program launches. That's why it's called setup! It's for settin things up.
//:  2. `func draw()` - The draw function gets called in a loop. By default it runs at 60 frames per second.
class MySketch: Sketch, SketchDelegate {
    
    func setup() {
        // Set your background color
        // Try changing the color by double clicking it.
        background(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
    }

    func draw() {
        noStroke()
        // Draw a circle wherever the screen is touched.
        // Try changing 25 to some other number and see what happens!
        circle(touchX, touchY, 25)
    }
    
    
}
//: ## Hit the blue play button to the left and click around the live view to the right.
//: ## Check out the little paint program we created!
//: This last bit of code is to get things up and running in the playground.
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
