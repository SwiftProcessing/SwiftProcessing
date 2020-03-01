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
    static var allTests = [
        ("testCreate2D", testCreate2D),
        ("testCreate3D", testCreate3D)
    ]
}
