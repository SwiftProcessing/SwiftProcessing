//: [Previous](@previous)
/*:
 # Synthesis—Loops, Curves, and Map
 ### by Masood Kamandy
 
 ## Introduction
 
 In this Synthesis section, we'll combine loops, curves, and the `map()` function to create a more dynamic sketch than we've been able to create so far.
 
 In the previous chapter we used curves to create a fixed shape, but now we want to create a curve that is more dynamic.
 
 ## Let's create a closed curve with control points that bounce around the screen.
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit

// Note: This sketch is being sped up by the use of parentheses around each statement.

class MySketch: Sketch, SketchDelegate {
    
    let numPoints = 25
    var randomPoints = [CGPoint]()
    
    var xSpeed = [CGFloat]()
    var ySpeed = [CGFloat]()
    
    var xDir = [CGFloat]()
    var yDir = [CGFloat]()
    
    // Curve function for quality
    // or an enum.
    
    func setup() {
        
        // Call the function that generates random points (see bottom).
        (randomPoints = randomPoints(numPoints))
        
        // Generate random speeds and directions
        for _ in 0..<numPoints {
            (xSpeed.append(random(1.0)))
            (ySpeed.append(random(1.0)))
            
            (xDir.append(random(-1.0, 1.0) > 0 ? 1.0 : -1.0))
            (yDir.append(random(-1.0, 1.0) > 0 ? 1.0 : -1.0))
        }
        
        (colorMode(.hsb))
    }
    
    func draw() {
        (background(0))

        (noFill())
        (stroke(255))

        // Draw curves using random points.
        (beginShape())
        for p in randomPoints {
            (curveVertex(p.x, p.y))
        }
        (endShape(.close))
        
        // Draw control points as red circles.
        (fill(255, 0, 0))
        (noStroke())
        for p in randomPoints {
            (fill((map(p.y, 0, height, 0, 360)), 100, 100, 100))
//            (fill(360, 100, 100))
            (circle(p.x, p.y, 15))
        }

        // Move the points according to speed and direction until they hit an edge and then reverse.
        for i in 0..<randomPoints.count {
            (randomPoints[i].x += (xSpeed[i] * xDir[i]))
            (randomPoints[i].y += (ySpeed[i] * yDir[i]))
            if randomPoints[i].x < 0 || randomPoints[i].x > CGFloat(width) {
                (xDir[i] *= -1)
            }
            
            if randomPoints[i].y < 0 || randomPoints[i].y > CGFloat(height) {
                (yDir[i] *= -1)
            }
        }
    }
    
    // A custom function that returns an array of random points. We'll learn to write our own functions in a future playground!
    func randomPoints(_ number: Int) -> [CGPoint] {
        var points = [CGPoint]()
        
        for _ in 0..<number {
            (points.append(CGPoint(x: random(width), y: random(height))))
        }
        return points
    }
}
//: ## What skills that you've learned so far would you synthesize?
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
