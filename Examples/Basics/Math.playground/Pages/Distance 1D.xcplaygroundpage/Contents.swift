/*:
 ## Distance 1D
 
 Touch the sketch left and right to control the speed and direction of the moving shapes.
 
 [Source](https://processing.org/examples/distance1d.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var xpos1: Double!
    var xpos2: Double!
    var xpos3: Double!
    var xpos4: Double!
    var thin = 8
    var thick = 36
    
    func setup() {
        noStroke()
        xpos1 = width / 2
        xpos2 = width / 2
        xpos3 = width / 2
        xpos4 = width / 2
    }
    
    func draw() {
        (background(0))
        
        let mx = touchX * 0.4 - width / 5.0
        
        (fill(102),
        rect(xpos2, 0, thick, height / 2),
        fill(204),
        rect(xpos1, 0, thin, height / 2),
        fill(102),
        rect(xpos4, height / 2, thick, height / 2),
        fill(204),
        rect(xpos3, height / 2, thin, height / 2))
        
        (xpos1 += mx / 16)
        (xpos2 += mx / 64)
        (xpos3 -= mx / 16)
        (xpos4 -= mx / 64)
        
        if xpos1 < -thin  { xpos1 =  Double(width) }
        if xpos1 >  width { xpos1 =  Double(-thin) }
        if xpos2 < -thick { xpos2 =  Double(width) }
        if xpos2 >  width { xpos2 =  Double(-thick) }
        if xpos3 < -thin  { xpos3 =  Double(width) }
        if xpos3 >  width { xpos3 =  Double(-thin) }
        if xpos4 < -thick { xpos4 =  Double(width) }
        if xpos4 >  width { xpos4 =  Double(-thick) }
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
