/*:
 ## Saturation
 
 Saturation is the strength or purity of the color and represents the amount of gray in proportion to the hue. A "saturated" color is pure and an "unsaturated" color has a large percentage of gray. Move the cursor vertically over each bar to alter its saturation.
 
 [Source](https://processing.org/examples/saturation.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
   
    var barWidth = 20
    var lastBar = -1.0
    
    func setup() {
        colorMode(.hsb, width, height, 100)
        noStroke()
    }
    
    func draw() {
        let whichBar = touchX / barWidth
        if whichBar != lastBar {
            let barX = whichBar * barWidth
          fill(barX, touchY, 66)
          rect(barX, 0, barWidth, height)
          lastBar = whichBar
        }
    }
        
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
