import Foundation
import UIKit

public extension Sketch {
    
    func createVector(_ x: CGFloat, _ y: CGFloat) -> Vector {
        return Vector(x, y)
    }
    
}

open class Vector {
    open var x: CGFloat
    open var y: CGFloat
    
    public init(_ x: CGFloat, _ y: CGFloat) {
        self.x = x
        self.y = y
    }
    
    func toString() -> String {
        //todo
        return ""
    }
    
    open func set(_ x: CGFloat, _ y: CGFloat) {
        self.x = x
        self.y = y
    }
    
    open func set(_ v: Vector) {
        self.x = v.x
        self.y = v.y
    }
    
    open func copy() -> Vector {
        return Vector(self.x, self.y)
    }
    
    public static func + (v1: Vector, v2: Vector) -> Vector {
        return Vector(v1.x + v2.x, v1.y + v2.y)
    }
    
    public static func add (_ v1: Vector, _ v2: Vector) -> Vector {
        return Vector(v1.x + v2.x, v1.y + v2.y)
    }
    
    open func add(_ v: Vector) -> Vector {
        return Vector.add(self, v)
    }
    
    open func add(_ x: CGFloat, _ y: CGFloat) -> Vector {
        return Vector.add(self, Vector(x, y))
    }
    
    public static func - (v1: Vector, v2: Vector) -> Vector {
        return Vector(v1.x - v2.x, v1.y - v2.y)
    }
    
    public static func sub (_ v1: Vector, _ v2: Vector) -> Vector {
        return Vector(v1.x + v2.x, v1.y + v2.y)
    }
    
    open func sub(_ v: Vector) -> Vector {
        return Vector.add(self, v)
    }
    
    open func sub(_ x: CGFloat, _ y: CGFloat) -> Vector {
        return Vector.sub(self, Vector(x, y))
    }
    
    public static func * (_ v: Vector, _ n: CGFloat) -> Vector {
        return Vector.mult(v, n)
    }
    
    public static func mult(_ v: Vector, _ n: CGFloat) -> Vector {
        return Vector(v.x * n, v.y * n)
    }
    
    open func mult(_ n: CGFloat) -> Vector {
        return Vector.mult(self, n)
    }
    
    public static func / (_ v: Vector, _ n: CGFloat) -> Vector {
        return Vector.div(v, n)
    }
    
    public static func div(_ v: Vector, _ n: CGFloat) -> Vector {
        return Vector(v.x / n, v.y / n)
    }
    
    open func div(_ n: CGFloat) -> Vector {
        return Vector.div(self, n)
    }
    
    open func mag() -> CGFloat {
        return sqrt(x * x + y * y)
    }
    
    open func magSq() -> CGFloat {
        return x * x + y * y
    }
    
    public static func dot(_ v1: Vector, _ v2: Vector) -> CGFloat {
        return v1.x * v2.x + v2.y + v2.y
    }
    
    open func dot(_ v: Vector) -> CGFloat {
        return Vector.dot(v, self)
    }
    
    public static func dist(_ v1: Vector, _ v2: Vector) -> CGFloat{
        return sqrt(pow(v2.x - v1.x, 2) + pow(v2.y - v1.y, 2))
    }
    
    open func dist(_ v: Vector) -> CGFloat {
        return Vector.dist(v, self)
    }
}
