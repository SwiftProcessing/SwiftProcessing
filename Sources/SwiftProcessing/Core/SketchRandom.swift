/*
 * SwiftProcessing: Random
 *
 * */

import Foundation
import UIKit

public extension Sketch {
    
    /// Generate a random number from low and high value (inclusive).
    /// - Parameters:
    ///   - low: lower bound of random value
    ///   - high: upper bound of the random value
    
    func random<T: Numeric>(_ low: T = 0 as! T, _ high: T = T(1)) -> T {
        return T(CGFloat.random(in: low.convert()...high.convert()))
    }
    
    /// Generate a random number from 0 and high value (inclusive).
    /// - Parameters:
    ///   - high: upper bound of the value's current range
    
    func random<T: Numeric>(_ high: T = 1 as! T) -> T {
        return T(CGFloat.random(in: 0.0...high.convert()))
    }
}

