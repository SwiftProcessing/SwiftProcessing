/*
 * SwiftProcessing: Trigonometry
 *
 * A simple bridge between Foundation's trig functions
 * so that beginners don't need to learn about imports
 * right away. It also applies the generic pattern to
 * trig functions, which benefits new learners.
 *
 * */


import Foundation

public protocol Trigonometry {
    
    /// Calculates the sine of an angle.
    /// - Parameters:
    ///   - angle: input angle
    /// ```
    /// func setup() {
    ///   print(sin(Math.twoPi))
    /// }
    /// ```
    func sin<A: Numeric>(_ angle: A) -> Double
    
    /// Calculates the cosine of an angle.
    /// - Parameters:
    ///   - angle: input angle
    /// ```
    /// func setup() {
    ///   print(cos(Math.twoPi))
    /// }
    /// ```
    func cos<A: Numeric>(_ angle: A) -> Double
    
    /// Calculates the ratio of the sine and cosine of an angle.
    /// - Parameters:
    ///   - angle: input angle
    /// ```
    /// func setup() {
    ///   print(cos(Math.twoPi))
    /// }
    /// ```
    func tan<A: Numeric>(_ angle: A) -> Double
    
    /// The inverse of sin(), returns the arc sine of a value.
    /// - Parameters:
    ///   - angle: input angle
    /// ```
    /// func setup() {
    ///   print(asin(Math.twoPi))
    /// }
    /// ```
    func asin<A: Numeric>(_ angle: A) -> Double
    
    /// The inverse of cos(), returns the arc cosine of a value.
    /// - Parameters:
    ///   - angle: input angle
    /// ```
    /// func setup() {
    ///   print(acos(Math.twoPi))
    /// }
    /// ```
    func acos<A: Numeric>(_ angle: A) -> Double
    
    /// The inverse of tan(), returns the arc tangent of a value.
    /// - Parameters:
    ///   - angle: input angle
    /// ```
    /// func setup() {
    ///   print(atan(Math.twoPi))
    /// }
    /// ```
    func atan<A: Numeric>(_ angle: A) -> Double
    
    /// Calculates the angle (in radians) from a specified point to the coordinate origin as measured from the positive x-axis.
    /// - Parameters:
    ///   - y: y-coordinate of the point
    ///   - x: x-coordinate of the point
    /// ```
    /// func setup() {
    ///   print(atan(Math.twoPi))
    /// }
    /// ```
    func atan2<Y: Numeric, X: Numeric>(_ y: Y, _ x: X) -> Double
    
    /// Converts a radian measurement to its corresponding value in degrees.
    /// - Parameters:
    ///   - radians: radian value to convert to degrees
    /// ```
    /// func setup() {
    ///   print(degrees(Math.pi))
    /// }
    /// ```
    func degrees<R: Numeric>(_ radians: R) -> Double
    
    /// Converts a degree measurement to its corresponding value in radians.
    /// - Parameters:
    ///   - degrees: degree value to convert to radians
    /// ```
    /// func setup() {
    ///   print(radians(180))
    /// }
    /// ```
    func radians<D: Numeric>(_ degrees: D) -> Double
    
}

extension Sketch: Trigonometry {
    
    public func sin<A: Numeric>(_ angle: A) -> Double {
        let d_angle: Double
        d_angle = angle.convert()
        return Foundation.sin(d_angle)
    }
    
    public func cos<A: Numeric>(_ angle: A) -> Double {
        let d_angle: Double
        d_angle = angle.convert()
        return Foundation.cos(d_angle)
    }
    
    public func tan<A: Numeric>(_ angle: A) -> Double {
        let d_angle: Double
        d_angle = angle.convert()
        return Foundation.tan(d_angle)
    }
    
    public func asin<A: Numeric>(_ angle: A) -> Double {
        let d_angle: Double
        d_angle = angle.convert()
        return Foundation.asin(d_angle)
    }
    
    public func acos<A: Numeric>(_ angle: A) -> Double {
        let d_angle: Double
        d_angle = angle.convert()
        return Foundation.acos(d_angle)
    }
    
    public func atan<A: Numeric>(_ angle: A) -> Double {
        let d_angle: Double
        d_angle = angle.convert()
        return Foundation.atan(d_angle)
    }
    
    public func atan2<Y: Numeric, X: Numeric>(_ y: Y, _ x: X) -> Double {
        let d_y, d_x: Double
        d_y = y.convert()
        d_x = x.convert()
        return Foundation.atan2(d_y, d_x)
    }
    
    public func degrees<R: Numeric>(_ radians: R) -> Double {
        let d_radians: Double
        d_radians = radians.convert()
        return d_radians * Math.radToDegree
    }
    
    public func radians<D: Numeric>(_ degrees: D) -> Double {
        let d_degrees: Double
        d_degrees = degrees.convert()
        return d_degrees * Math.degToRadian
    }
    
}
