/*
 * SwiftProcessing: Random
 *
 * */

import Foundation
import UIKit

// =======================================================================
// MARK: - RANDOM/NOISE FUNCTIONS
// =======================================================================

public extension Sketch {
    
    /*
     * MARK: - RANDOM
     */
    
    /// Generate a random number from low and high value (inclusive).
    ///  ```
    ///  // Below generates a random number between 10 and 100.
    ///  let number = random(10, 100)
    ///  ```
    /// - Parameters:
    ///   - low: lower bound of random value
    ///   - high: upper bound of the random value
    
    func random<L: Numeric, H: Numeric>(_ low: L = L(0), _ high: H = H(1)) -> Double {
        return Double.random(in: low.convert()...high.convert())
    }
    
    /// Generate a random number from 0 and high value (inclusive).
    ///  ```
    ///  // Below generates a random number up to and including 100.
    ///  let number = random(100)
    ///  // Below generates a random number up to 1.0.
    ///  let newNumber = random()
    ///  ```
    /// - Parameters:
    ///   - high: upper bound of the value's current range
    
    func random<T: Numeric>(_ high: T = T(1)) -> T {
        return T(CGFloat.random(in: 0.0...high.convert()))
    }
    
    /*
     * MARK: - NOISE
     */
    
    /*
     FOR FUTURE CONTRIBUTORS:
     
     From Wikipedia: https://en.wikipedia.org/wiki/Perlin_noise#Algorithm_detail
     
     An implementation typically involves three steps:
     1 — defining a grid of random gradient vectors.
     2 — computing the dot product between the gradient vectors and their offsets
     3 — and interpolation between these values.
     */
    
    /// Perlin Noise
    /// ```
    /// // Example
    /// ```
    /// - Parameters:
    ///   - tk: tk

}


