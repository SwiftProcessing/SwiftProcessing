import Foundation
import UIKit

public extension Sketch {
    
    func createVector(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat? = nil) -> Vector {
        return Vector(x, y, z)
    }
    
}

open class Vector {
    open var x: CGFloat
    open var y: CGFloat
    open var z: CGFloat?

    public init(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat? = nil) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    func toString() -> String {
        //todo
        return ""
    }
    
    open func set(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat? = nil) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    open func set(_ v: Vector) {
        self.x = v.x
        self.y = v.y
        self.z = v.z
    }
    
    open func copy() -> Vector {
        return Vector(self.x, self.y, self.z)
    }
    
    public static func + (v1: Vector, v2: Vector) -> Vector {
        return Vector(v1.x + v2.x, v1.y + v2.y, v1.z != nil ? (v1.z! + v2.z!) : nil)
    }
    
    public static func add (_ v1: Vector, _ v2: Vector) -> Vector {
        return Vector(v1.x + v2.x, v1.y + v2.y,  v1.z != nil ? (v1.z! + v2.z!) : nil)
    }
    
    open func add(_ v: Vector) -> Vector {
        let result = Vector.add(self, v)
        self.set(result)
        return self
    }
    
    open func add(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat? = nil) -> Vector {
        return Vector.add(self, Vector(x, y, z))
    }
    
    public static func - (v1: Vector, v2: Vector) -> Vector {
        return Vector(v1.x - v2.x, v1.y - v2.y, v1.z != nil ? (v1.z! - v2.z!) : nil)
    }
    
    public static func sub (_ v1: Vector, _ v2: Vector) -> Vector {
        return Vector(v1.x - v2.x, v1.y - v2.y, v1.z != nil ? (v1.z! - v2.z!) : nil)
    }
    
    open func sub(_ v: Vector) -> Vector {
        let result = Vector.sub(self, v)
        self.set(result)
        return self
    }
    
    open func sub(_ x: CGFloat, _ y: CGFloat) -> Vector {
        return Vector.sub(self, Vector(x, y))
    }
    
    public static func * (_ v: Vector, _ n: CGFloat) -> Vector {
        return Vector.mult(v, n)
    }
    
    public static func mult(_ v: Vector, _ n: CGFloat) -> Vector {
        return Vector(v.x * n, v.y * n, v.z != nil ? (v.z! * n) : nil)
    }
    
    open func mult(_ n: CGFloat) -> Vector {
        let result = Vector.mult(self, n)
        self.set(result)
        return self
    }
    
    public static func / (_ v: Vector, _ n: CGFloat) -> Vector {
        return Vector.div(v, n)
    }
    
    public static func div(_ v: Vector, _ n: CGFloat) -> Vector {
        return Vector(v.x / n, v.y / n, v.z != nil ? (v.z! / n) : nil)
    }
    
    open func div(_ n: CGFloat) -> Vector {
        let result = Vector.div(self, n)
        self.set(result)
        return self
    }
    
    open func mag() -> CGFloat {
        return sqrt(self.magSq())
    }
    
    open func magSq() -> CGFloat {
        return x * x + y * y + (z != nil ? z! * z! : 0)
    }
    
    public static func dot(_ v1: Vector, _ v2: Vector) -> CGFloat {
        return v1.x * v2.x + v2.y * v2.y + (v1.z != nil ? (v1.z! * v2.z!) : 0)
    }
    
    open func dot(_ v: Vector) -> CGFloat {
        return Vector.dot(v, self)
    }
    
    public static func dist(_ v1: Vector, _ v2: Vector) -> CGFloat{
        return sqrt(pow(v2.x - v1.x, 2) + pow(v2.y - v1.y, 2) + (v1.z != nil ? pow(v2.z! - v1.z!, 2) : 0))
    }
    
    open func dist(_ v: Vector) -> CGFloat {
        return Vector.dist(v, self)
    }
    
    open func normalize() -> Vector{
        let len = self.mag()
        if (len != 0){
            self.mult(1 / len)
        }
        return self
    }
}
