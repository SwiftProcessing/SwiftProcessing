/*:
 ## Brightness
 by Rusty Robison
 
 Brightness is the relative lightness or darkness of a color. Touch vertically over each bar to alter its brightness.
 
 [Source](https://processing.org/examples/brightness.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var barWidth = 20
    var lastBar = -1.0
    
    func setup() {
        colorMode(.hsb, width, 100, height)
        noStroke()
        background(0)
    }
    
    func draw() {
        
        let whichBar = touchX / barWidth
        if (whichBar != lastBar) {
            let barX = whichBar * barWidth
            fill(barX, 100, touchY)
            rect(barX, 0, barWidth, height)
            lastBar = whichBar
        }
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
