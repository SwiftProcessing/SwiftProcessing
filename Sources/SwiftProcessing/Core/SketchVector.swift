import Foundation
import UIKit

public extension Sketch {
    
    func createVector<X: Numeric, Y: Numeric, Z: Numeric>(_ x: X, _ y: Y, _ z: Z? = nil) -> Vector {
        return Vector(x, y, z)
    }
    
    func createVector<X: Numeric, Y: Numeric>(_ x: X, _ y: Y) -> Vector {
        return Vector(x, y)
    }
    
}

open class Vector: CustomStringConvertible {
    public var description: String {
        if z != nil{
            return "(\(x), \(y), \(String(describing: z)))"
        }else{
            return "(\(x), \(y))"
        }
    }
    
    open var x: Double
    open var y: Double
    open var z: Double?
    
    public init<X: Numeric, Y: Numeric>(_ x: X, _ y: Y) {
        self.x = x.convert()
        self.y = y.convert()
        self.z = nil as Double?
    }
    
    public init<X: Numeric, Y: Numeric, Z: Numeric>(_ x: X, _ y: Y, _ z: Z? = nil) {
        self.x = x.convert()
        self.y = y.convert()
        self.z = z?.convert()
    }
    
    open func set<X:Numeric, Y: Numeric, Z: Numeric>(_ x: X, _ y: Y, _ z: Z? = nil) {
        self.x = x.convert()
        self.y = y.convert()
        self.z = z?.convert()
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
    
    open func add<T: Numeric>(_ x: T, _ y: T, _ z: T? = nil) -> Vector {
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
    
    open func sub<T: Numeric>(_ x: T, _ y: T) -> Vector {
        return Vector.sub(self, Vector(x, y))
    }
    
    public static func * <T: Numeric>(_ v: Vector, _ n: T) -> Vector {
        return Vector.mult(v, n)
    }
    
    public static func mult<T: Numeric>(_ v: Vector, _ n: T) -> Vector {
        return Vector(v.x * n.convert(), v.y * n.convert(), v.z != nil ? (v.z! * n.convert()) : nil)
    }
    
    open func mult<T: Numeric>(_ n: T) -> Vector {
        let result = Vector.mult(self, n)
        self.set(result)
        return self
    }
    
    public static func / <T: Numeric>(_ v: Vector, _ n: T) -> Vector {
        return Vector.div(v, n)
    }
    
    public static func div<T: Numeric>(_ v: Vector, _ n: T) -> Vector {
        return Vector(v.x / n.convert(), v.y / n.convert(), v.z != nil ? (v.z! / n.convert()) : nil)
    }
    
    open func div<T: Numeric>(_ n: T) -> Vector {
        let result = Vector.div(self, n)
        self.set(result)
        return self
    }
    
    open func mag() -> Double {
        return sqrt(self.magSq())
    }
    
    open func magSq() -> Double  {
        return x * x + y * y + (z != nil ? z! * z! : 0)
    }
    
    public static func dot(_ v1: Vector, _ v2: Vector) -> Double {
        return v1.x * v2.x + v2.y * v2.y + (v1.z != nil ? (v1.z! * v2.z!) : 0)
    }
    
    open func dot(_ v: Vector) -> Double {
        return Vector.dot(v, self)
    }
    
    public static func dist(_ v1: Vector, _ v2: Vector) -> Double {
        return sqrt(pow(v2.x - v1.x, 2) + pow(v2.y - v1.y, 2) + (v1.z != nil ? pow(v2.z! - v1.z!, 2) : 0))
    }
    
    open func dist(_ v: Vector) -> Double {
        return Vector.dist(v, self)
    }
    
    open func normalize() -> Vector {
        let len = self.mag()
        if (len != 0){
            self.mult(1 / len)
        }
        return self
    }
    
    open func heading() -> Double {
        var h = atan2(self.y, self.x)
        return h
    }
    
    open func rotate<T: Numeric>(_ a: T) -> Vector {
        var newHeading = self.heading()
        newHeading += a.convert();
        let mag = self.mag();
        self.x = cos(newHeading) * mag;
        self.y = sin(newHeading) * mag;
        return self;
    }
}
