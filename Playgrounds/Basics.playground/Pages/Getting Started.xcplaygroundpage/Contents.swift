/*:
 # Getting Started with SwiftProcessing
 ### by Masood Kamandy
 
 Welcome to SwiftProcessing and the world of creative coding. In the following tutorials you will learn the basics of learning to code creatively to produce artworks of your own.
 
 ## Code Comments
 
 One thing you might have noticed in the code above is that I wrote comments in the code above. The comments are invisible to the computer.
 
 In Swift, you can comment using a couple of methods: */
//: 1. `//` - this is a single line comment.
//: 1. `/* write comment here */` - this is a multi-line comment. Once you start your comment with `/*` the computer will ignore everything up until you close your comment with `*/`
/*:
## What is a function?
 
 Moving forward you'll definitely want to know what a ***function*** is, but luckily you've already used one!
 A function is a piece of code that does an action. You can think of them as the verbs of coding. We've used 3 functions in the code above.
 
 1. `background()` - sets the background color.
 1. `noStroke()` - makes shapes draw without an outline.
 1. `circle()` - draws a circle.
 
 ## Speeding up your Playgrounds
 
 In Xcode Playgrounds, you will see a counter to the right of your sketch code as it's running. This counter helps you to see the sequence of events in your code and is useful for learning. **It also slows your code down a lot.** But there's good news! ***You can disable the counter!***
 
 To disable the counter, you can wrap your function calls with parentheses. For example, if you place the following code in `draw()`, it would run slowly:
 
 ```
 translate(144, 144)
 for x in 0..<20 {
     for y in 0..<20 {
         fill(random(255))
         circle(x * 25, y * 25, 5)
     }
 }
 ```
 
 To bypass the counter and make this code run much more quickly, you can wrap each function call in `()` or use the `(,)` pattern for consecutive statements:
 
 ```
 // Each statement wrapped.
 (translate(144, 144))
 for x in 0..<20 {
     for y in 0..<20 {
         (fill(random(255)))
         (circle(x * 25, y * 25, 5))
     }
 }
 
 // Using the (,) pattern for consecutive statements in the for loop.
 (translate(144, 144))
 for x in 0..<20 {
     for y in 0..<20 {
         (fill(random(255)),
         (circle(x * 25, y * 25, 5))
     }
 }
 ```
 In this text we've used the `()` or `(,)` formatting to speed up code where it benefits from it. In code that runs once or doesn't benefit, we've left it alone.
 
 ## Quick Help
 
 In SwiftProcessing you can **use quick help on any keyword** if you forget how to use it or need more information. To use this, just hover your mouse over a SwiftProcessing keyword, hold down the command key, and click. You'll see the cursor change into a question mark.
 
 ## Code Example
 
 ### Import Modules
 
 Before we get started, we'll need to use an import statement to bring SwiftProcessing's code into our playground. You'll see this on every playground in this series.
 */
import SwiftProcessing
import PlaygroundSupport
//: ### Your first Processing Sketch
//: Code runs from top to bottom. Learning how to follow the steps of your code is one of the most important skills you'll learn!
//: Functions are chunks of code that do actions. Eventually you'll write your own functions, but for now Processing sketch's are made up of two fundamental functions.
//: 1. `func setup()` - This happens once at the very beginning of your sketch. Whatever commands you write in here will be called when your program launches. That's why it's called setup! It's for settin things up.
//:  2. `func draw()` - The draw function gets called in a loop. By default it runs at 60 frames per second. In this Sketch, we allow our background to persist by not clearing it with the `background()` function every frame. If you want to clear your background and get rid of the trails, just set your background color at the begining of your `draw()`.
// Note: This sketch is being sped up by the use of parentheses around each statement.

class MySketch: Sketch, SketchDelegate {
    
    func setup() {
        // Set your background color
        // Try changing the color by double clicking it.
        background(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
    }

    func draw() {
        // Try moving background() here to clear the background every frame.
        (noStroke(),
        // Draw a circle wherever the screen is touched.
        // Try changing 25 to some other number and see what happens!
        circle(touchX, touchY, 25))
    }
    
}
//: ## Hit the blue play button to the left and click around the live view to the right.
//: ## Check out the little paint program we created!
//: This last bit of code is to get things up and running in the Playground.
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
