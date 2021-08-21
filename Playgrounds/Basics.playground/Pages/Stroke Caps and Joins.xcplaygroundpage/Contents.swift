//: [Previous](@previous)
/*:
 # Stroke Caps and Joins
 ### by Masood Kamandy for GSoC 2021
 
 ## Stroke Joins and Caps
 
 ### Introduction
 
 It's important to be able to control the look of your lines and behavior of your corners. There are 3 types of caps and 3 types of joins that you can use in SwiftProcessing.
 
 ### Stroke Join
 
 To set the stroke join you can use the `strokeJoin()` function. This function takes a `StrokeJoin` enum as its parameter. There are 3 types of stroke joins: `.miter`, `.bevel`, and `.round`. Below is what it looks like to use the `strokeJoin()` function:
 
 ```
 strokeJoin(.bevel)
 ```
 Below are definitions and illustrations ([source](https://processing.org/reference/strokeJoin_.html)) of each option:
 
`.miter` creates an angular joint.
 
 ![An image showing the 90-degree corner of a line with a sharp joint.](strokeJoin_miter.png)
 
`.bevel` bevels off the point using a straight edge.
 
 ![An image showing the 90-degree corner of a line with a beveled joint.](strokeJoin_bevel.png)
 
`.round` rounds each corner.
 
 ![An image showing the 90-degree corner of a line with a rounded joint.](strokeJoin_round.png)
 
 ### Stroke Cap
 
 To set the stroke cap you can use the `strokeCap()` function. This function takes a `StrokeCap` enum as its parameter. There are 3 types of stroke joins: `.round`, `.square`, and `.project`. Below is what it looks like to use the `strokeCap()` function:
 
 ```
 strokeCap(.round)
 ```
 Below are definitions and an illustration ([source](https://processing.org/reference/strokeCap_.html)) of the options in order:
 
 `.round` rounds the end as if you were to draw a circle with a diameter the size of the `strokeWeight`.
 
 `.square` cuts the the line off squarely directly at the endpoint.
 
 `.project` is similar to `.round` except it's as if you draw a square with a centerpoint of your endpoint outward the size of the `strokeWeight`.
 
 ![An image showing the 90-degree corner of a line with a rounded joint.](strokeCap.png)
 
 ## Let's create a closed curve with control points that bounce around the screen.
 
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit
//: ## SwiftProcessing Sketch Code
class MySketch: Sketch, SketchDelegate {
    
    func setup() {
        background(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        noFill()
        strokeWeight(48.0)
        
        stroke(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
        
        push()
        // Default is .miter
        translate(50, 100)
        beginShape()
        vertex(0, 0)
        vertex(200, 200)
        vertex(0, 400)
        endShape(.open)

        strokeJoin(.bevel)
        translate(225, 0)
        beginShape()
        vertex(0, 0)
        vertex(200, 200)
        vertex(0, 400)
        endShape(.open)

        strokeJoin(.round)
        translate(225, 0)
        beginShape()
        vertex(0, 0)
        vertex(200, 200)
        vertex(0, 400)
        endShape(.open)
        pop()
        
        stroke(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
        
        push()
        translate(200, 650)
        // .round is default.
        line(0, 0, width/2, 0)
        
        translate(0, 100)
        strokeCap(.square)
        line(0,0, width/2, 0)
        
        translate(0, 100)
        strokeCap(.project)
        line(0,0, width/2, 0)
        pop()
    }
    
    func draw() {
    }
}

PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
