/*:
 ## Clock
 
 The current time can be read with the second(), minute(), and hour() functions. In this example, sin() and cos() values are used to set the position of the hands.
 
 [Source](https://processing.org/examples/clock.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var cx, cy: Double!
    var secondsRadius: Double!
    var minutesRadius: Double!
    var hoursRadius: Double!
    var clockDiameter: Double!
    
    func setup() {
        stroke(255)
        
        let radius = min(width, height) / 2
        secondsRadius = radius * 0.72
        minutesRadius = radius * 0.60
        hoursRadius = radius * 0.50
        clockDiameter = radius * 1.8
        
        cx = width / 2
        cy = height / 2
    }
    
    func draw() {
        (background(0),
         
         // Draw the clock background
         fill(80),
         noStroke(),
         ellipse(cx, cy, clockDiameter, clockDiameter))
        
        // Angles for sin() and cos() start at 3 o'clock;
        // subtract HALF_PI to make them start at the top
        let s = (map(second(), 0, 60, 0, Math.two_pi) - Math.half_pi)
        let m = (map(minute() + norm(second(), 0, 60), 0, 60, 0, Math.two_pi) - Math.half_pi)
        let h = (map(hour() + norm(minute(), 0, 60), 0, 24, 0, Math.two_pi * 2) - Math.half_pi)
        
        // Draw the hands of the clock
        (stroke(255),
         strokeWeight(1),
         line(cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius),
         strokeWeight(2),
         line(cx, cy, cx + cos(m) * minutesRadius, cy + sin(m) * minutesRadius),
         strokeWeight(4),
         line(cx, cy, cx + cos(h) * hoursRadius, cy + sin(h) * hoursRadius))
        
        // Draw the minute ticks
        strokeWeight(2)
        for a in stride(from: 0, to: 360, by: 6) {
            let angle = (radians(a))
            let x = (cx + cos(angle) * secondsRadius)
            let y = (cy + sin(angle) * secondsRadius)
            (point(x, y))
        }
    }
    
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
