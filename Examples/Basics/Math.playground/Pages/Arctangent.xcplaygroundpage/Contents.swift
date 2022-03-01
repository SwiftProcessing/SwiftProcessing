/*:
 ## Arctangent
 
 Move the mouse to change the direction of the eyes. The atan2() function computes the angle from each eye to the cursor.
 
 [Source](https://processing.org/examples/arctangent.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var e1, e2, e3: Eye!
    
    func setup() {
        noStroke()
        
        e1 = Eye(self, 314,  348, 120)
        e2 = Eye(self, 228, 517,  80)
        e3 = Eye(self, 484, 562, 220)
    }
    
    func draw() {
        background(102)
        
        e1.update(touchX, touchY)
        e2.update(touchX, touchY)
        e3.update(touchX, touchY)
        
        e1.display()
        e2.display()
        e3.display()
    }
    
    class Eye {
        var x, y: Double
        var size: Double
        var angle = 0.0
        
        var sketch: Sketch
        
        init(_ sketch: Sketch,_ tx: Double,_ ty: Double,_ ts: Double) {
            self.sketch = sketch
            x = tx
            y = ty
            size = ts
        }
        
        func update(_ mx: Double,_ my: Double) {
            angle = sketch.atan2(my-y, mx-x)
        }
        
        func display() {
            (sketch.pushMatrix(),
             sketch.translate(x, y),
             sketch.fill(255),
             sketch.ellipse(0, 0, size, size),
             sketch.rotate(angle),
             sketch.fill(153, 204, 0),
             sketch.ellipse(size/4, 0, size/2, size/2),
             sketch.popMatrix())
        }
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
