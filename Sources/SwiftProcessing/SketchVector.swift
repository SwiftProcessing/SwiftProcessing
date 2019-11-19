import Foundation
import UIKit

public extension Sketch{

    func createVector(_ x: CGFloat, _ y: CGFloat) -> Vector{
        return Vector(x, y)
    }
    
}

open class Vector{
    var x: CGFloat
    var y: CGFloat
    
    public init(_ x: CGFloat, _ y: CGFloat) {
        self.x = x
        self.y = y
    }
    
    static func + (v1: Vector, v2: Vector) -> Vector {
        return Vector(v1.x + v2.x, v1.y + v2.y)
    }
    
    static func add (_ v1: Vector, _ v2: Vector) -> Vector {
        return Vector(v1.x + v2.x, v1.y + v2.y)
    }
    
    func add(_ v: Vector) -> Vector{
        return Vector.add(self, v)
    }
    
    func add(_ x: CGFloat, _ y: CGFloat) -> Vector{
        return Vector.add(self, Vector(x, y))
    }
    
    static func - (v1: Vector, v2: Vector) -> Vector {
        return Vector(v1.x - v2.x, v1.y - v2.y)
    }
    
    static func sub (_ v1: Vector, _ v2: Vector) -> Vector {
        return Vector(v1.x + v2.x, v1.y + v2.y)
    }
    
    func sub(_ v: Vector) -> Vector{
        return Vector.add(self, v)
    }
    
    func sub(_ x: CGFloat, _ y: CGFloat) -> Vector{
        return Vector.sub(self, Vector(x, y))
    }
}
