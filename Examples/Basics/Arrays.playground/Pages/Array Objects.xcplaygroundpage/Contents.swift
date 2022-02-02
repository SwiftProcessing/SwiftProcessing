/*:
 ## Array Objects
 
 Demonstrates the syntax for creating an array of custom objects.
 
 [Source](https://processing.org/examples/arrayobjects.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var unit = 40
    var count: Int!
    var mods = [Module]()

    func setup() {
        noStroke();
        let wideCount = Int(width) / unit
        let highCount = Int(height) / unit
        count = wideCount * highCount

        for y in 0..<highCount {
            for x in 0..<wideCount {
                (mods.append(Module(sketch: self, xOffset: x * unit, yOffset: y * unit, x: unit/2, y: unit/2, speed: random(0.05, 0.8), unit: unit)))
          }
        }

    }
    
    func draw() {
        background(0)
        for mod in mods {
          (mod.update())
          (mod.display())
        }
    }
}

class Module {
    
    var sketch: Sketch
    
    var xOffset: Int
    var yOffset: Int
    var x:Double, y: Double
    var unit: Int
    var xDirection = 1
    var yDirection = 1
    var speed: Double

    init(sketch: Sketch, xOffset: Int, yOffset: Int, x: Double, y: Double, speed: Double, unit: Int) {
        self.sketch = sketch
        
        self.xOffset = xOffset
        self.yOffset = yOffset
        self.x = x
        self.y = y
        self.speed = speed
        self.unit = unit
    }
    
    // Custom method for updating the variables
    func update() {
      (x = x + (speed * xDirection))
      if x >= unit || x <= 0 {
        (xDirection *= -1)
        (x = x + (1 * xDirection))
        (y = y + (1 * yDirection))
      }
      if (y >= unit || y <= 0) {
        (yDirection *= -1)
        (y = y + (1 * yDirection))
      }
    }
    
    // Custom method for drawing the object
    func display() {
        (sketch.fill(255))
        (sketch.ellipse(xOffset + x, yOffset + y, 6, 6))
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
