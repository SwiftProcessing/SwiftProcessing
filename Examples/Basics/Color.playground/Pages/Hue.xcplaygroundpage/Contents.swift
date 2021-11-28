/*:
 ## Hue
 
 Hue is the color reflected from or transmitted through an object and is typically referred to as the name of the color such as red, blue, or yellow. In this example, move the cursor vertically over each bar to alter its hue.
 
 [Source](https://processing.org/examples/hue.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var barWidth = 20
    var lastBar = -1.0
    
    func setup() {
        colorMode(.hsb, height, height, height)
        noStroke()
        background(0)
        
    }
    
    func draw() {
        let whichBar = touchX / barWidth
        if whichBar != lastBar {
            let barX = whichBar * barWidth
            fill(touchY, height, height)
            rect(barX, 0, barWidth, height)
            lastBar = whichBar
        }
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
