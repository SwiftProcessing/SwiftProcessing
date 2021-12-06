import XCTest
@testable import SwiftProcessing

final class PushPopTest: XCTestCase {
    
    func testTextSizeTo100() {
        let sketch = Sketch()
        sketch.textSize(100)
        sketch.push()
        sketch.textSize(50)
        XCTAssertEqual(sketch.settings.textSize, 50)
        sketch.pop()
        XCTAssertEqual(sketch.settings.textSize, 100)
    }
    
    func testColorFillToRed() {
        let sketch = Sketch()
        sketch.fill(0.0, 0.0, 0.0, 255.0) // Clear
        sketch.push()
        sketch.fill(255.0, 0.0, 0.0, 255.0) // Red
        XCTAssertEqual(sketch.settings.fill.v1, 255.0)
        sketch.pop()
        XCTAssertEqual(sketch.settings.fill.v1, 0.0)
    }
    
    // Try this.
    func testColorFillToRedAfter1Loop() {
        class TestSketch: Sketch, SketchDelegate {
            
            var numLoops = 0
            var loopLimit = 2
            
            func setup() {
                fill(255,0,0)
            }
            
            func draw() {
                numLoops += 1
                if numLoops > loopLimit {
                    noLoop()
                }
            }
        }
        // set color to red in setup()
        // go through 2 frames of draw()
        let sketch = TestSketch()
        let layer = CALayer()
        sketch.display(layer)
        sketch.display(layer)
        // check whether global fill state is red
        sketch.fill(255.0, 0.0, 0.0, 255.0) // Red
        XCTAssertEqual(sketch.settings.fill.v1, 255.0)
        sketch.pop()
        XCTAssertEqual(sketch.settings.fill.v1, 0.0)
    }
}
