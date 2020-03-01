import XCTest
@testable import SwiftProcessing

final class VectorTests: XCTestCase {
    
    func testCreate2D() {
        let sketch = Sketch()
        let v = sketch.createVector(1, 13)
        XCTAssertEqual(v.x, 1)
        XCTAssertEqual(v.y, 13)
    }
    
    func testCreate3D() {
        let sketch = Sketch()
        let v = sketch.createVector(1, 13, 2017)
        XCTAssertEqual(v.x, 1)
        XCTAssertEqual(v.y, 13)
        XCTAssertEqual(v.z, 2017)
    }
    
    func testCopy2D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13)
        let v2 = v1.copy()
        v2.x = 5
        XCTAssertNotEqual(v1.x, v2.x)
    }
    
    func testCopy3D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13, 2017)
        let v2 = v1.copy()
        v2.z = 5
        XCTAssertNotEqual(v1.z, v2.z)
    }
    
    func testPlus2D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13)
        let v2 = v1.copy()
        let result = v1 + v2
        XCTAssertEqual(v1.x, 1)
        XCTAssertEqual(v1.y, 13)
        XCTAssertEqual(result.x, 2)
        XCTAssertEqual(result.y, 26)
    }
    
    func testPlus3D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13, 2017)
        let v2 = v1.copy()
        let result = v1 + v2
        XCTAssertEqual(v1.z, 2017)
        XCTAssertEqual(result.z, 4034)
    }
    
    func testStaticAdd2D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13)
        let v2 = v1.copy()
        let result = Vector.add(v1, v2)
        XCTAssertEqual(v1.x, 1)
        XCTAssertEqual(v1.y, 13)
        XCTAssertEqual(result.x, 2)
        XCTAssertEqual(result.y, 26)
    }
    
    func testStaticAdd3D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13, 2017)
        let v2 = v1.copy()
        let result = Vector.add(v1, v2)
        XCTAssertEqual(v1.x, 1)
        XCTAssertEqual(v1.y, 13)
        XCTAssertEqual(v1.z, 2017)
        XCTAssertEqual(result.x, 2)
        XCTAssertEqual(result.y, 26)
        XCTAssertEqual(result.z, 4034)
    }
    
    func testAdd2D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13)
        let v2 = v1.copy()
        let result = v1.add(v2)
        XCTAssertEqual(v1.x, 2)
        XCTAssertEqual(v1.y, 26)
        XCTAssertEqual(result.x, 2)
        XCTAssertEqual(result.y, 26)
    }
    
    func testAdd3D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13, 2017)
        let v2 = v1.copy()
        let result = v1.add(v2)
        XCTAssertEqual(v1.x, 2)
        XCTAssertEqual(v1.y, 26)
        XCTAssertEqual(v1.z, 4034)
        XCTAssertEqual(result.x, 2)
        XCTAssertEqual(result.y, 26)
        XCTAssertEqual(result.z, 4034)
    }
    
    func testMinus2D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13)
        let v2 = v1.copy()
        let result = v1 - v2
        XCTAssertEqual(v1.x, 1)
        XCTAssertEqual(v1.y, 13)
        XCTAssertEqual(result.x, 0)
        XCTAssertEqual(result.y, 0)
    }
    
    func testMinus3D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13, 2017)
        let v2 = v1.copy()
        let result = v1 - v2
        XCTAssertEqual(v1.z, 2017)
        XCTAssertEqual(result.z, 0)
    }
    
    func testStaticSub2D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13)
        let v2 = v1.copy()
        let result = Vector.sub(v1, v2)
        XCTAssertEqual(v1.x, 1)
        XCTAssertEqual(v1.y, 13)
        XCTAssertEqual(result.x, 0)
        XCTAssertEqual(result.y, 0)
    }
    
    func testStaticSub3D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13, 2017)
        let v2 = v1.copy()
        let result = Vector.sub(v1, v2)
        XCTAssertEqual(v1.x, 1)
        XCTAssertEqual(v1.y, 13)
        XCTAssertEqual(v1.z, 2017)
        XCTAssertEqual(result.x, 0)
        XCTAssertEqual(result.y, 0)
        XCTAssertEqual(result.z, 0)
    }
    
    func testSub2D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13)
        let v2 = v1.copy()
        let result = v1.sub(v2)
        XCTAssertEqual(v1.x, 0)
        XCTAssertEqual(v1.y, 0)
        XCTAssertEqual(result.x, 0)
        XCTAssertEqual(result.y, 0)
    }
    
    func testSub3D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13, 2017)
        let v2 = v1.copy()
        let result = v1.sub(v2)
        XCTAssertEqual(v1.x, 0)
        XCTAssertEqual(v1.y, 0)
        XCTAssertEqual(v1.z, 0)
        XCTAssertEqual(result.x, 0)
        XCTAssertEqual(result.y, 0)
        XCTAssertEqual(result.z, 0)
    }
    
    func testAsterisk2D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13)
        let result = v1 * 2
        XCTAssertEqual(v1.x, 1)
        XCTAssertEqual(v1.y, 13)
        XCTAssertEqual(result.x, 2)
        XCTAssertEqual(result.y, 26)
    }
    
    func testAsterisk3D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13, 2017)
        let result = v1 * 2
        XCTAssertEqual(v1.z, 2017)
        XCTAssertEqual(result.z, 4034)
    }
    
    func testStaticMult2D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13)
        let result = Vector.mult(v1, 2)
        XCTAssertEqual(v1.x, 1)
        XCTAssertEqual(v1.y, 13)
        XCTAssertEqual(result.x, 2)
        XCTAssertEqual(result.y, 26)
    }
    
    func testStaticMult3D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13, 2017)
        let result = Vector.mult(v1, 2)
        XCTAssertEqual(v1.x, 1)
        XCTAssertEqual(v1.y, 13)
        XCTAssertEqual(v1.z, 2017)
        XCTAssertEqual(result.x, 2)
        XCTAssertEqual(result.y, 26)
        XCTAssertEqual(result.z, 4034)
    }
    
    func testMult2D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13)
        let result = v1.mult(2)
        XCTAssertEqual(v1.x, 2)
        XCTAssertEqual(v1.y, 26)
        XCTAssertEqual(result.x, 2)
        XCTAssertEqual(result.y, 26)
    }
    
    func testMult3D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13, 2017)
        let result = v1.mult(2)
        XCTAssertEqual(v1.x, 2)
        XCTAssertEqual(v1.y, 26)
        XCTAssertEqual(v1.z, 4034)
        XCTAssertEqual(result.x, 2)
        XCTAssertEqual(result.y, 26)
        XCTAssertEqual(result.z, 4034)
    }
    
    func testSlash2D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13)
        let result = v1 / 2
        XCTAssertEqual(v1.x, 1)
        XCTAssertEqual(v1.y, 13)
        XCTAssertEqual(result.x, 0.5)
        XCTAssertEqual(result.y, 6.5)
    }
    
    func testSlash3D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13, 2017)
        let result = v1 / 2
        XCTAssertEqual(v1.z, 2017)
        XCTAssertEqual(result.z, 1008.5)
    }
    
    func testStaticDiv2D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13)
        let result = Vector.div(v1, 2)
        XCTAssertEqual(v1.x, 1)
        XCTAssertEqual(v1.y, 13)
        XCTAssertEqual(result.x, 0.5)
        XCTAssertEqual(result.y, 6.5)
    }
    
    func testStaticDiv3D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13, 2017)
        let result = Vector.div(v1, 2)
        XCTAssertEqual(v1.x, 1)
        XCTAssertEqual(v1.y, 13)
        XCTAssertEqual(v1.z, 2017)
        XCTAssertEqual(result.x, 0.5)
        XCTAssertEqual(result.y, 6.5)
        XCTAssertEqual(result.z, 1008.5)
    }
    
    func testDiv2D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13)
        let result = v1.div(2)
        XCTAssertEqual(v1.x, 0.5)
        XCTAssertEqual(v1.y, 6.5)
        XCTAssertEqual(result.x, 0.5)
        XCTAssertEqual(result.y, 6.5)
    }
    
    func testDiv3D(){
        let sketch = Sketch()
        let v1 = sketch.createVector(1, 13, 2017)
        let result = v1.div(2)
        XCTAssertEqual(v1.x, 0.5)
        XCTAssertEqual(v1.y, 6.5)
        XCTAssertEqual(v1.z, 1008.5)
        XCTAssertEqual(result.x, 0.5)
        XCTAssertEqual(result.y, 6.5)
        XCTAssertEqual(result.z, 1008.5)
    }
    
    static var allTests = [
        ("testCreate2D", testCreate2D),
        ("testCreate3D", testCreate3D)
    ]
}
