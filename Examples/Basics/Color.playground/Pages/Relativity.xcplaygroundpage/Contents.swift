/*:
 ## Relativity
 
 Each color is perceived in relation to other colors. The top and bottom bars each contain the same component colors, but a different display order causes individual colors to appear differently.
 
 [Source](https://processing.org/examples/relativity.html)
 */

import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var a: Color!, b: Color!, c: Color!, d: Color!, e: Color!
    
    func setup() {
        noStroke();
        a = color(165, 167, 20)
        b = color(77, 86, 59)
        c = color(42, 106, 105)
        d = color(165, 89, 20)
        e = color(146, 150, 127)
        noLoop();  // Draw only one time
    }
    
    func draw() {
        (drawBand(a, b, c, d, e, 0, Int(width/128)),
        drawBand(c, a, d, b, e, Int(height/2), Int(width/128)))
    }
    
    func drawBand(_ v: Color, _ w: Color, _ x: Color, _ y: Color, _ z: Color, _ ypos: Int, _ barWidth: Int) {
        let num = 5
        let colorOrder: [Color] = [ v, w, x, y, z ]
        for i in stride(from: 0, to: width, by: barWidth*num){
            for j in 0..<num {
                (fill(colorOrder[j]),
                rect(i+j*barWidth, ypos, barWidth, height/2))
            }
        }
    }
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
