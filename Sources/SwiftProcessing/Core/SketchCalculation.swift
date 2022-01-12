/*
 * SwiftProcessing: Calculation
 *
 * */


import Foundation
import UIKit

/// Useful functions for common math calculations
public protocol Calculation {
    
    /// Constrains a value between a minimum and maximum value.
    /// - Parameters:
    ///   - n: number to constrain
    ///   - low: minimum limit
    ///   - high: maximum limit
    
    func constrain<N: Numeric, L: Numeric, H: Numeric>(_ n: N,_ low: L, _ high: H) -> Double
    
    /// Calculates the distance between two points
    /// - Parameters:
    ///   - x1: x-coordinate of the first point
    ///   - y1: y-coordinate of the first point
    ///   - x2: x-coordinate of the second point
    ///   - y2: y-coordinate of the second point
    
    func dist<X1: Numeric, Y1: Numeric, X2: Numeric, Y2: Numeric>(_ x1: X1, _ y1: Y1, _ x2: X2, _ y2: Y2) -> Double
    
    /// Calculates a number between two numbers at a specific increment
    /// - Parameters:
    ///   - start: first value
    ///   - stop: second value
    ///   - amount: amount to interpolate between the two values
    
    func lerp<START: Numeric, STOP: Numeric, A: Numeric>(_ start: START, _ stop: STOP, _ amount: A) -> Double
    
    /// Calculates the magnitude (or length) of a vector
    /// - Parameters:
    ///   - a: first value
    ///   - b: second value
    
    func mag<A: Numeric, B: Numeric>(_ a: A, _ b: B) -> Double
    
    /// Re-maps a number from one range to another.
    /// - Parameters:
    ///   - value: the incoming value to be converted
    ///   - start1: lower bound of the value's current range
    ///   - stop1: upper bound of the value's current range
    ///   - start2: lower bound of the value's target range
    ///   - stop2: upper bound of the value's target range
    ///   - withinBounds: constrain the value to the newly mapped range (Optional)
    
    func map<V: Numeric, START1: Numeric, STOP1: Numeric, START2: Numeric, STOP2: Numeric>(_ value: V, _ start1: START1, _ stop1: STOP1, _ start2: START2, _ stop2: STOP2, _ withinBounds: Bool) -> Double
    
    /// Determines the largest value in a sequence of numbers, and then returns that value
    /// - Parameter array: Numbers to compare
    
    func max<A: FloatingPoint>(_ array: [A]) -> A
    
    
    /// Determines the smallest value in a sequence of numbers, and then returns that value
    /// - Parameter array: Numbers to compare
    
    func min<A: FloatingPoint>(_ array: [A]) -> A
    
    /// Normalizes a number from another range into a value between 0 and 1.
    /// - Parameters:
    ///   - num: incoming value to be normalized
    ///   - start: lower bound of the value's current range
    ///   - stop: upper bound of the value's current range
    
    func norm<N: Numeric, START: Numeric, STOP: Numeric>(_ num: N, _ start: START, _ stop: STOP) -> Double
    
    /// Squares a number (multiplies a number by itself).
    /// - Parameter num: number to square
    /// - Returns: squared number
    
    func sq<N: Numeric>(_ num: N) -> N
    
    /// Returns the square root of a number
    /// - Parameter num: number to find the square root of.
    /// - Returns: square root
    
    func sqrt<N: Numeric>(_ num: N) -> Double
    
    /// Returns a decimal number raised to a given power.
    /// - Parameters:
    ///   - base: base value
    ///   - exponent: power to raise the base to
    /// - Returns: a number raised to a power
    
    func pow<B: Numeric, P: Numeric>(_ base: B, _ power: P) -> Double
    
    /// Returns the lesser of two comparable values.
    /// - Parameters:
    ///   - x: A value to compare.
    ///   - y: Another value to compare.
    /// - Returns: The lesser of x and y. If x is equal to y, returns x.
    
    func min<T>(_ x: T, _ y: T) -> T where T : Comparable
    
    
}

extension Sketch: Calculation {
    
    public func constrain<N: Numeric, L: Numeric, H: Numeric>(_ n: N,_ low: L, _ high: H) -> Double {
        let d_n, d_low, d_high: Double
        d_n = n.convert()
        d_low = low.convert()
        d_high = high.convert()
        
        return Swift.min(Swift.max(d_n, d_low), d_high)
    }
    
    public func dist<X1: Numeric, Y1: Numeric, X2: Numeric, Y2: Numeric>(_ x1: X1, _ y1: Y1, _ x2: X2, _ y2: Y2) -> Double {
        let d_x1, d_y1, d_x2, d_y2: Double
        d_x1 = x1.convert()
        d_y1 = y1.convert()
        d_x2 = x2.convert()
        d_y2 = y2.convert()
        
        let diffX = d_x2 - d_x1
        let diffY = d_y2 - d_y1
        let distanceSquared = diffX * diffX + diffY * diffY
        return sqrt(distanceSquared)
    }
    
    public func lerp<START: Numeric, STOP: Numeric, A: Numeric>(_ start: START, _ stop: STOP, _ amount: A) -> Double {
        let d_start, d_stop, d_amount: Double
        d_start = start.convert()
        d_stop = stop.convert()
        d_amount = amount.convert()
        
        return d_start + ((d_stop - d_start) * d_amount)
    }
    
    
    public func mag<A: Numeric, B: Numeric>(_ a: A, _ b: B) -> Double {
        let d_a, d_b: Double
        d_a = a.convert()
        d_b = b.convert()
        
        return dist(0, 0, d_a, d_b)
    }
    
    public func map<V: Numeric, START1: Numeric, STOP1: Numeric, START2: Numeric, STOP2: Numeric>(_ value: V, _ start1: START1, _ stop1: STOP1, _ start2: START2, _ stop2: STOP2, _ withinBounds: Bool = true) -> Double {
        let d_value, d_start1, d_stop1, d_start2, d_stop2: Double
        d_value = value.convert()
        d_start1 = start1.convert()
        d_stop1 = stop1.convert()
        d_start2 = start2.convert()
        d_stop2 = stop2.convert()
        
        let newval = (d_value - d_start1) / (d_stop1 - d_start1) * (d_stop2 - d_start2) + d_start2
        if !withinBounds {
            return newval
        }
        if d_start2 < d_stop2 {
            return self.constrain(newval, d_start2, d_stop2)
        } else {
            return self.constrain(newval, d_stop2, d_start2)
        }
    }
    
    public func max<A: FloatingPoint>(_ array: [A]) -> A {
        return array.max() ?? 0
    }
    
    public func min<A: FloatingPoint>(_ array: [A]) -> A {
        return array.min() ?? 0
    }
    
    public func norm<N: Numeric, START: Numeric, STOP: Numeric>(_ num: N, _ start: START, _ stop: STOP) -> Double {
        let d_num, d_start, d_stop: Double
        d_num = num.convert()
        d_start = start.convert()
        d_stop = stop.convert()
        
        return self.map(d_num, d_start, d_stop, 0, 1)
    }
    
    // Relies upon conversion found in Sketch2DPrimitivesGenerics.Swift
    // Returning a Double here because that is what will be required in most
    // use cases for SwiftProcessing and using T creates ambiguity that
    // can't be resolved. Maybe there's a better solution out there?
    
    public func sq<N: Numeric>(_ num: N) -> N {
        return Foundation.pow(num as! Decimal, 2) as! N
    }
    
    public func sqrt<N: Numeric>(_ num: N) -> Double {
        let d_num: Double = num.convert()
        
        return Foundation.sqrt(d_num)
    }
    
    public func pow<B: Numeric, P: Numeric>(_ base: B, _ power: P) -> Double {
        let d_base, d_power: Double
        d_base = base.convert()
        d_power = power.convert()
        return Foundation.pow(d_base, d_power)
    }
    
    public func min<T>(_ x: T, _ y: T) -> T where T : Comparable {
        return Swift.min(x, y)
    }
}
