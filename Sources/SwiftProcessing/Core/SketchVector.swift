/*
 * SwiftProcessing: Vector
 *
 * */

import Foundation
import UIKit

public extension Sketch {
    
    /// Returns a 3-dimensional vector object with x, y, and z values.
    /// ```
    /// // Creates a vector at (30, 20, 10) and assigns it to vector
    /// let vector = createVector(30, 20, 10)
    /// ```
    /// - Parameters:
    ///     - x: x-position
    ///     - y: y-position
    ///     - z: z-position
    
    func createVector<X: Numeric, Y: Numeric, Z: Numeric>(_ x: X, _ y: Y, _ z: Z) -> Vector {
        return Vector(x, y, z)
    }
    
    /// Returns a 2-dimensional vector object with x and y values.
    /// ```
    /// // Creates a vector at (30, 20) and assigns it to vector
    /// let vector = createVector(30, 20)
    /// ```
    /// - Parameters:
    ///     - x: x-position
    ///     - y: y-position
    
    func createVector<X: Numeric, Y: Numeric>(_ x: X, _ y: Y) -> Vector {
        return Vector(x, y)
    }
    
    class Vector: CustomStringConvertible {
        public var description: String {
            return "(\(x), \(y), \(z)))"
        }
        
        open var x: Double
        open var y: Double
        open var z: Double
        
        public init<X: Numeric, Y: Numeric>(_ x: X, _ y: Y) {
            self.x = x.convert()
            self.y = y.convert()
            self.z = 0.0
        }
        
        public init<X: Numeric, Y: Numeric, Z: Numeric>(_ x: X, _ y: Y, _ z: Z) {
            self.x = x.convert()
            self.y = y.convert()
            self.z = z.convert()
        }
        
        /// Sets the vector object to a 2-dimensional vector with x and y values.
        /// ```
        /// // Sets myVector to (30, 20)
        /// myVector.set(30, 20)
        /// ```
        /// - Parameters:
        ///     - x: x-position
        ///     - y: y-position
        
        open func set<X:Numeric, Y: Numeric>(_ x: X, _ y: Y) {
            self.x = x.convert()
            self.y = y.convert()
            self.z = 0.0
        }
        
        /// Sets the vector object to a 3-dimensional vector with x, y, and z values.
        /// ```
        /// // Sets myVector to (30, 20, 10)
        /// myVector.set(30, 20, 10)
        /// ```
        /// - Parameters:
        ///     - x: x-position
        ///     - y: y-position
        ///     - z: z-position
        
        open func set<X:Numeric, Y: Numeric, Z: Numeric>(_ x: X, _ y: Y, _ z: Z) {
            self.x = x.convert()
            self.y = y.convert()
            self.z = z.convert()
        }
        
        /// Sets the vector object to be a copy of another vector object.
        /// ```
        /// // Sets myVector to anotherVector
        /// myVector.set(anotherVector)
        /// ```
        /// - Parameters:
        ///     - v: vector
        
        open func set(_ v: Vector) {
            self.x = v.x
            self.y = v.y
            self.z = v.z
        }
        
        /// Returns a copy of a vector object. This is useful if you want to create a copy as opposed to creating a reference, which is the default behavior of Swift when using the = sign with objects. For example, `myVector = anotherVector` would copy a reference, rather than a copy. If you changed values in `myVector`, they would be changed in `anotherVector` too. This is a common source of bugs.
        /// ```
        /// // Sets myVector to anotherVector
        /// myVector = anotherVector.copy()
        /// ```
        
        open func copy() -> Vector {
            return Vector(self.x, self.y, self.z)
        }
        
        /// + operator adds two vectors together.
        /// ```
        /// // Adds myVector to anotherVector and assigns it to newVector
        /// let newVector = myVector + anotherVector
        /// ```
        /// - Parameters:
        ///      - left: left operand
        ///      - right: right operand
        
        public static func + (left: Vector, right: Vector) -> Vector {
            return Vector(left.x + right.x, left.y + right.y, left.z  + right.z)
        }
        
        /// Adds two vectors together.
        /// ```
        /// // Adds myVector to anotherVector and assigns it to newVector
        /// let newVector = Vector.add(myVector, anotherVector)
        /// ```
        /// - Parameters:
        ///      - v1: vector 1
        ///      - v2: vector 2
        
        public static func add (_ v1: Vector, _ v2: Vector) -> Vector {
            return Vector(v1.x + v2.x, v1.y + v2.y,  v1.z + v2.z)
        }
        
        // Anything that modifies the self **and** returns it should be appended with the @discardableResult to minimize compile warnings. We are modifying the self **and** we can assign the result to another variable. That is the source of the error.
        
        // Sometime to consider is whether we want these functions to return anything at all. That would also silence the error.
        
        /// Adds two vectors together.
        /// ```
        /// // Adds anotherVector to myVector
        /// myVector.add(anotherVector)
        /// ```
        /// - Parameters:
        ///      - v: vector  to add
        
        @discardableResult open func add(_ v: Vector) -> Vector {
            let result = Vector.add(self, v)
            self.set(result)
            return self
        }
        
        /// Adds an x, y, and z value to an existing vector.
        /// ```
        /// // Adds (30, 20, 10) to myVector
        /// myVector.add(30, 20, 10)
        /// ```
        /// - Parameters:
        ///      - x: x  to add
        ///      - y: y  to add
        ///      - z: z  to add
        
        open func add<X: Numeric, Y: Numeric, Z: Numeric>(_ x: X, _ y: Y, _ z: Z) -> Vector {
            return Vector.add(self, Vector(x, y, z))
        }
        
        /// Adds an x and y values to an existing vector.
        /// ```
        /// // Adds (30, 20, 10) to myVector
        /// myVector.add(30, 20, 10)
        /// ```
        /// - Parameters:
        ///      - x: x  to add
        ///      - y: y  to add
        
        open func add<X: Numeric, Y: Numeric>(_ x: X, _ y: Y) -> Vector {
            return Vector.add(self, Vector(x, y))
        }
        
        /// - operator subtracts two vectors from each other.
        /// ```
        /// // Subtracts myVector from anotherVector and assigns it to newVector
        /// let newVector = myVector - anotherVector
        /// ```
        /// - Parameters:
        ///      - left: left operand
        ///      - right: right operand
        
        public static func - (left: Vector, right: Vector) -> Vector {
            return Vector(left.x - right.x, left.y - right.y, left.z - right.z)
        }
        
        /// Subtracts two vectors from each other.
        /// ```
        /// // Adds myVector to anotherVector and assigns it to newVector
        /// let newVector = Vector.sub(myVector, anotherVector)
        /// ```
        /// - Parameters:
        ///      - v1: vector 1
        ///      - v2: vector 2
        
        public static func sub (_ v1: Vector, _ v2: Vector) -> Vector {
            return Vector(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z)
        }
        
        /// Subtracts one vector from another.
        /// ```
        /// // Subtracts anotherVector from myVector
        /// myVector.sub(anotherVector)
        /// ```
        /// - Parameters:
        ///      - v: vector  to add
        
        @discardableResult open func sub(_ v: Vector) -> Vector {
            let result = Vector.sub(self, v)
            self.set(result)
            return self
        }
        
        /// Subtracts an x and y values from an existing vector.
        /// ```
        /// // Adds (30, 20, 10) to myVector
        /// myVector.add(30, 20, 10)
        /// ```
        /// - Parameters:
        ///      - x: x  to add
        ///      - y: y  to add
        
        open func sub<T: Numeric>(_ x: T, _ y: T) -> Vector {
            return Vector.sub(self, Vector(x, y))
        }
        
        /// * operator multiplies a vector by a factor.
        /// ```
        /// // Multiplies myVector by 5 and assigns it to newVector
        /// let newVector = myVector * 5
        /// ```
        /// - Parameters:
        ///      - vector: vector to be multiplied
        ///      - factor: factor to multiply the vector by
        
        public static func * <F: Numeric>(_ vector: Vector, _ factor: F) -> Vector {
            return Vector.mult(vector, factor)
        }
        
        /// Multiplies a vector by a factor.
        /// ```
        /// // Multiplies myVector by 5 and assigns it to newVector
        /// let newVector = Vector.mult(myVector, 5)
        /// ```
        /// - Parameters:
        ///      - vector: vector to be multiplied
        ///      - factor: factor to multiply the vector by
        
        public static func mult<F: Numeric>(_ vector: Vector, _ factor: F) -> Vector {
            return Vector(vector.x * factor.convert(), vector.y * factor.convert(), vector.z * factor.convert())
        }
        
        /// Multiplies a vector by a factor.
        /// ```
        /// // Multiplies myVector by 5
        /// myVector.mult(5)
        /// ```
        /// - Parameters:
        ///      - vector: vector to be multiplied
        ///      - factor: factor to multiply the vector by
        
        @discardableResult open func mult<F: Numeric>(_ factor: F) -> Vector {
            let result = Vector.mult(self, factor)
            self.set(result)
            return self
        }
        
        /// / operator divides a vector by a divisor.
        /// ```
        /// // Divides myVector by 5 and assigns it to newVector
        /// let newVector = myVector / 5
        /// ```
        /// - Parameters:
        ///      - vector: vector to be divided
        ///      - factor: divisor to divide the vector by
        
        public static func / <D: Numeric>(_ vector: Vector, _ divisor: D) -> Vector {
            return Vector.div(vector, divisor)
        }
        
        /// Divides a vector by a divisor.
        /// ```
        /// // Divides myVector by 5 and assigns it to newVector
        /// let newVector = Vector.div(myVector, 5)
        /// ```
        /// - Parameters:
        ///      - vector: vector to be multiplied
        ///      - divisor: divisor to divide the vector by
        
        public static func div<D: Numeric>(_ vector: Vector, _ divisor: D) -> Vector {
            return Vector(vector.x / divisor.convert(), vector.y / divisor.convert(), vector.z / divisor.convert())
        }
        
        /// Divides a vector by a divisor.
        /// ```
        /// // Divides myVector by 5
        /// myVector.div(5)
        /// ```
        /// - Parameters:
        ///      - divisor: factor to multiply the vector by
        
        @discardableResult open func div<D: Numeric>(_ divisor: D) -> Vector {
            let result = Vector.div(self, divisor)
            self.set(result)
            return self
        }
        
        /// Returns the magnitude of the vector. Uses the distance formula. **Note:** If you are just trying to assess if something is more or less distant than something else and don't need exact values, then use `magSq()` instead. It will do the same thing and does not rely upon a square root, which slows things down in computing.
        /// ```
        /// // Assigns the magnitude of myVector to magnitude
        /// let magnitude = myVector.mag()
        /// ```
        
        open func mag() -> Double {
            return Foundation.sqrt(self.magSq())
        }
        
        /// Returns the magnitude squared of the vector. Uses the distance formula minus the square root. **Note:** This is faster than `mag()` if you are just trying to compare whether one object is farther than another and don't need exact distances.
        /// ```
        /// // Assigns the magnitude squared of myVector to magnitude
        /// let magnitudeSquared = myVector.magSq()
        /// ```
        
        open func magSq() -> Double  {
            return x * x + y * y + z * z
        }
        
        /// Returns the dot product of two vectors.
        /// ```
        /// // Assigns the dot product of myVector and anotherVector to dotProduct
        /// let dotProduct = Vector.dot(myVector, anotherVector)
        /// ```
        /// - Parameters:
        ///      - v1: vector 1
        ///      - v2: vector 2
        
        public static func dot(_ v1: Vector, _ v2: Vector) -> Double {
            return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
        }
        
        /// Returns the dot product of a vector with itself, which is the square of its magnitude.
        /// ```
        /// // Assigns the dot product of myVector with itself to dotProduct
        /// let dotProduct = Vector.dot(myVector)
        /// ```
        /// - Parameters:
        ///      - v1: vector 1
        ///      - v2: vector 2
        
        open func dot(_ v: Vector) -> Double {
            return Vector.dot(v, self)
        }
        
        /// Returns the distance betwen two vectors.
        /// ```
        /// // Assigns the distance between myVector and anotherVector to distance
        /// let distance = dist(myVector, anotherVector)
        /// ```
        /// - Parameters:
        ///      - v1: vector 1
        ///      - v2: vector 2
        
        public static func dist(_ v1: Vector, _ v2: Vector) -> Double {
            return Foundation.sqrt(Foundation.pow(v2.x - v1.x, 2) + Foundation.pow(v2.y - v1.y, 2) + Foundation.pow(v2.z - v1.z, 2))
        }
        
        /// Returns the distance betwen two vectors.
        /// ```
        /// // Assigns the distance between myVector and anotherVector to distance
        /// let distance = myVector.dist(anotherVector)
        /// ```
        /// - Parameters:
        ///      - v: vector
        
        open func dist(_ v: Vector) -> Double {
            return Vector.dist(v, self)
        }
        
        /// Returns a normalized vector which describes the direction of a vector without taking its length into account.
        /// ```
        /// // Normalizes a vector.
        /// let normalized = myVector.normalize()
        /// ```
        /// - Parameters:
        ///      - v1: vector 1
        ///      - v2: vector 2
        
        @discardableResult open func normalize() -> Vector {
            let len = self.mag()
            if (len != 0){
                return self.mult(1 / len)
            }
            return self
        }
        
        /// Returns the heading of a vector as an angle. This is useful when thinking about objects that need to aim or point. Uses `atan2()`.
        /// ```
        /// // Assigns the heading angle to angle
        /// let angle = myVector.heading()
        /// ```
        /// - Parameters:
        ///      - v1: vector 1
        ///      - v2: vector 2
        
        open func heading() -> Double {
            let h = Foundation.atan2(self.y, self.x)
            return h
        }
        
        /// Returns a vector rotated by the angle theta.
        /// ```
        /// // Assigns the vector created by rotating myVector by Math.pi
        /// let rotated = myVector.rotate(Math.pi)
        /// ```
        /// - Parameters:
        ///      - v1: vector 1
        ///      - v2: vector 2
        
        @discardableResult open func rotate<T: Numeric>(_ theta: T) -> Vector {
            var newHeading = self.heading()
            newHeading += theta.convert();
            let mag = self.mag();
            self.x = Foundation.cos(newHeading) * mag;
            self.y = Foundation.sin(newHeading) * mag;
            return self;
        }
        
        /// Limits the magnitude of a vector.
        /// ```
        /// // Assigns the vector created by rotating myVector by Math.pi
        /// let rotated = myVector.rotate(Math.pi)
        /// ```
        /// - Parameters:
        ///      - v1: vector 1
        ///      - v2: vector 2
        
        @discardableResult open func limit<T: Numeric>(_ max: T) -> Vector {
            if (magSq() > max*max) {
                normalize()
                mult(max)
            }
            return self
        }
    }
}
