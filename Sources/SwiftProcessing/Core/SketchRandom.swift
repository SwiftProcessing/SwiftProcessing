/*
 * SwiftProcessing: Random
 *
 * */

import Foundation
import UIKit
import GameplayKit

// =======================================================================
// MARK: - RANDOM/NOISE FUNCTIONS
// =======================================================================

public extension Sketch {
    
    /*
     * MARK: - RANDOM
     */
    
    /// Generate a random floating point number from low and high value (inclusive).
    ///  ```
    ///  // Below generates a random number between 10.0 and 100.0.
    ///  let number = random(10, 100)
    ///  ```
    /// - Parameters:
    ///   - low: lower bound of random value
    ///   - high: upper bound of the random value
    
    func random<L: Numeric, H: Numeric>(_ low: L = L(0), _ high: H = H(1)) -> Double {
        
        let d_low: Double = low.convert()
        let d_high: Double = high.convert()
        
        // This behavior mimics p5.js by *always* returning a random number, even if the lower bound is higher than the upper bound. Processing exits out if low >= high and returns low.
        return Double.random(in: Swift.min(d_low, d_high) ... Swift.max(d_low, d_high))
    }
    
    /// Generate a random floating point number from 0 and high value (inclusive).
    ///  ```
    ///  // Below generates a random number up to and including 100.0.
    ///  let number = random(100)
    ///  // Below generates a random number up to 1.0.
    ///  let newNumber = random()
    ///  ```
    /// - Parameters:
    ///   - high: upper bound of the value's current range
    
    func random<T: Numeric>(_ high: T = T(1)) -> Double {
        let d_high: Double = high.convert()
        
        // Ensures that random() always returns a value, even if a negative value is entered.
        return Double.random(in: Swift.min(0.0, d_high) ... Swift.max(0.0, d_high))
    }
    
    /*
     * MARK: - NOISE
     */
    
    /*
     From Wikipedia: https://en.wikipedia.org/wiki/Perlin_noise#Algorithm_detail
     
     An implementation typically involves three steps:
     1 — defining a grid of random gradient vectors.
     2 — computing the dot product between the gradient vectors and their offsets
     3 — and interpolation between these values.
     
     To create Processing-style Perlin noise, we're going to leverage Apple's GameplayKit as a stopgap measure before implementing our own noise method.
     
     This currently has two major drawbacks looking for a solution:
     1 - Once you set the noise parameters, it does not seem easy to change them in the same frame. That means that noiseDetail() is fixed and cannot be changed.
     2 - It isn't clear to me how to gain access to the 3rd dimension of Perlin noise with GKPerlinNoiseSource().
     
     Sources:
     https://academy.realm.io/posts/tryswift-natalia-berdy-random-talk-consistent-world-noise-swift-gamekit-ios/
     https://developer.apple.com/documentation/gameplaykit/gknoisemap
     https://www.hackingwithswift.com/example-code/games/how-to-create-a-random-terrain-tile-map-using-sktilemapnode-and-gkperlinnoisesource
     https://rtouti.github.io/graphics/perlin-noise-algorithm
     https://mrl.cs.nyu.edu/~perlin/doc/oscar.html
     
     GameplayKit's GKPerlinNoiseSource() has several properties we can manipulate. Here's how they map to Processing's ecosystem:
     
     noiseSource.frequency = 1 // ?
     noiseSource.octaveCount = 6 // The lod parameter in noiseDetail() in Processing. Default in Processing is 4, but we're sticking with Apple's default of 6.
     noiseSource.lacunarity = 2 // ?
     noiseSource.persistence = 0.5 // The falloff paremeter in noiseDetail in Processing.
     
     */
    
    /// Adjusts the character and level of detail produced by the Perlin noise function. Similar to harmonics in physics, noise is computed over several octaves. Lower octaves contribute more to the output signal and as such define the overall intensity of the noise, whereas higher octaves create finer-grained details in the noise sequence.
    /// By default, noise is computed over 6 octaves with each octave contributing exactly half than its predecessor, starting at 50% strength for the first octave. This falloff amount can be changed by adding an additional function parameter. For example, a falloff factor of 0.75 means each octave will now have 75% impact (25% less) of the previous lower octave. While any number between 0.0 and 1.0 is valid, note that values greater than 0.5 may result in `noise()` returning values greater than 1.0.
    /// By changing these parameters, the signal created by the `noise()` function can be adapted to fit very specific needs and characteristics.
    /// ```
    /// var xoff = 0.0
    ///
    /// func setup() {
    /// }
    ///
    /// func draw() {
    ///   background(204)
    ///   xoff = xoff + 0.01
    ///   let n = noise(xoff) * width
    ///   line(n, 0, n, height)
    /// }
    /// ```
    /// - Parameters:
    ///    - detail: number of octaves to be used by the noise
    
    // To be implemented later.
    
    /*
    func noiseDetail<D: Numeric>(_ detail: D) {
        let i_detail: Int = detail.convert()
        noiseSource = GKPerlinNoiseSource()
        
        if i_detail > 0 {
            settings.perlinOctaves = i_detail
        }
    }
    */
    
    /// Adjusts the character and level of detail produced by the Perlin noise function. Similar to harmonics in physics, noise is computed over several octaves. Lower octaves contribute more to the output signal and as such define the overall intensity of the noise, whereas higher octaves create finer-grained details in the noise sequence.
    /// By default, noise is computed over 6 octaves with each octave contributing exactly half than its predecessor, starting at 50% strength for the first octave. This falloff amount can be changed by adding an additional function parameter. For example, a falloff factor of 0.75 means each octave will now have 75% impact (25% less) of the previous lower octave. While any number between 0.0 and 1.0 is valid, note that values greater than 0.5 may result in `noise()` returning values greater than 1.0.
    /// By changing these parameters, the signal created by the `noise()` function can be adapted to fit very specific needs and characteristics.
    /// ```
    /// // Example
    /// ```
    /// - Parameters:
    ///   - detail: number of octaves to be used by the noise
    ///   - falloff: falloff factor for each octave
    
    // To be implemented later.
    /*
    func noiseDetail<D: Numeric, F: Numeric>(_ detail: D, _ falloff: F) {
        let i_detail: Int = detail.convert()
        let d_falloff: Double = falloff.convert()
        noiseSource = GKPerlinNoiseSource()
        
        if i_detail > 0 && d_falloff > 0.0 {
            settings.perlinOctaves = i_detail
            settings.perlinFalloff = d_falloff
        }
    }
    */
    
    /// Returns the Perlin noise value at specified coordinates. Perlin noise is a random sequence generator producing a more natural, harmonic succession of numbers than that of the standard `random()` function. It was developed by Ken Perlin in the 1980s and has been used in graphical applications to generate procedural textures, shapes, terrains, and other seemingly organic forms.
    /// In contrast to the `random()` function, Perlin noise is defined in an infinite n-dimensional space, in which each pair of coordinates corresponds to a fixed semi-random value (fixed only for the lifespan of the program). The resulting value will always be between 0.0 and 1.0. SwiftProcessing can compute 1D, 2D and 3D noise, depending on the number of coordinates given. The noise value can be animated by moving through the noise space, as demonstrated in the first example above. The 2nd and 3rd dimensions can also be interpreted as time.
    /// The actual noise structure is similar to that of an audio signal, in respect to the function's use of frequencies. Similar to the concept of harmonics in physics, Perlin noise is computed over several octaves which are added together for the final result.
    /// Another way to adjust the character of the resulting sequence is the scale of the input coordinates. As the function works within an infinite space, the value of the coordinates doesn't matter as such; only the distance between successive coordinates is important (such as when using `noise()` within a loop). As a general rule, the smaller the difference between coordinates, the smoother the resulting noise sequence. Steps of 0.005-0.03 work best for most applications, but this will differ depending on use.
    /// ```
    /// var xoff = 0.0
    ///
    /// func setup() {
    /// }
    ///
    /// func draw() {
    ///     background(204)
    ///     xoff = xoff + 0.01
    ///     let n = noise(xoff) * width
    ///     line(n, 0, n, height)
    /// }
    /// ```
    /// - Parameters:
    ///   - x: x-coordinate in noise space
    
    func noise<X: Numeric>(_ x: X) -> Double {
        let f_x: Float = x.convert()
        
        return noise(f_x, 0.0)
    }
    
    /// Returns the Perlin noise value at specified coordinates. Perlin noise is a random sequence generator producing a more natural, harmonic succession of numbers than that of the standard `random()` function. It was developed by Ken Perlin in the 1980s and has been used in graphical applications to generate procedural textures, shapes, terrains, and other seemingly organic forms.
    /// In contrast to the `random()` function, Perlin noise is defined in an infinite n-dimensional space, in which each pair of coordinates corresponds to a fixed semi-random value (fixed only for the lifespan of the program). The resulting value will always be between 0.0 and 1.0. SwiftProcessing can compute 1D, 2D and 3D noise, depending on the number of coordinates given. The noise value can be animated by moving through the noise space, as demonstrated in the first example above. The 2nd and 3rd dimensions can also be interpreted as time.
    /// The actual noise structure is similar to that of an audio signal, in respect to the function's use of frequencies. Similar to the concept of harmonics in physics, Perlin noise is computed over several octaves which are added together for the final result.
    /// Another way to adjust the character of the resulting sequence is the scale of the input coordinates. As the function works within an infinite space, the value of the coordinates doesn't matter as such; only the distance between successive coordinates is important (such as when using `noise()` within a loop). As a general rule, the smaller the difference between coordinates, the smoother the resulting noise sequence. Steps of 0.005-0.03 work best for most applications, but this will differ depending on use.
    /// ```
    /// var noiseScale = 0.02
    ///
    /// func setup() {
    /// }
    ///
    /// func draw() {
    ///     background(0)
    ///     for x in 0..<Int(width) {
    ///         let noiseVal = noise((touchX + x)*noiseScale, touchY*noiseScale)
    ///         stroke(noiseVal*255)
    ///         line(x, touchY+noiseVal*80, x, height)
    ///     }
    /// }
    /// ```
    /// - Parameters:
    ///   - x: x-coordinate in noise space
    ///   - y: y-coordinate in noise space
    
    func noise<X: Numeric, Y: Numeric>(_ x: X, _ y: Y) -> Double {
        let f_x: Float = x.convert()
        let f_y: Float = y.convert()
        
        let result = noise.value(atPosition: vector_float2(f_x, f_y))
        
        return Double(map(result, -1, 1, 0, 1))
    }
    
    /// Returns the Perlin noise value at specified coordinates. Perlin noise is a random sequence generator producing a more natural, harmonic succession of numbers than that of the standard `random()` function. It was developed by Ken Perlin in the 1980s and has been used in graphical applications to generate procedural textures, shapes, terrains, and other seemingly organic forms.
    /// In contrast to the `random()` function, Perlin noise is defined in an infinite n-dimensional space, in which each pair of coordinates corresponds to a fixed semi-random value (fixed only for the lifespan of the program). The resulting value will always be between 0.0 and 1.0. SwiftProcessing can compute 1D, 2D and 3D noise, depending on the number of coordinates given. The noise value can be animated by moving through the noise space, as demonstrated in the first example above. The 2nd and 3rd dimensions can also be interpreted as time.
    /// The actual noise structure is similar to that of an audio signal, in respect to the function's use of frequencies. Similar to the concept of harmonics in physics, Perlin noise is computed over several octaves which are added together for the final result.
    /// Another way to adjust the character of the resulting sequence is the scale of the input coordinates. As the function works within an infinite space, the value of the coordinates doesn't matter as such; only the distance between successive coordinates is important (such as when using `noise()` within a loop). As a general rule, the smaller the difference between coordinates, the smoother the resulting noise sequence. Steps of 0.005-0.03 work best for most applications, but this will differ depending on use.
    /// ```
    /// var noiseScale = 0.02
    ///
    /// func setup() {
    /// }
    ///
    /// func draw() {
    ///     background(0)
    ///     for x in 0..<Int(width) {
    ///         let noiseVal = noise((touchX + x)*noiseScale, touchY*noiseScale)
    ///         stroke(noiseVal*255)
    ///         line(x, touchY+noiseVal*80, x, height)
    ///     }
    /// }
    /// ```
    /// - Parameters:
    ///   - x: x-coordinate in noise space
    ///   - y: y-coordinate in noise space
    ///   - z: z-coordinate in noise space
    
    // To be implemented later.
    /*
    func noise<X: Numeric, Y: Numeric, Z: Numeric>(_ x: X, _ y: Y, _ z: Z) -> Double {
        let f_x: Float = x.convert()
        let f_y: Float = y.convert()
        let d_z: Double = z.convert()
        
        let perlin = GKPerlinNoiseSource(frequency: 1.0, octaveCount: settings.perlinOctaves, persistence: settings.perlinFalloff, lacunarity: 2, seed: 0)
        let perlinNoise = GKNoise(perlin)
        
        // Because there's no push or pop, I'm going to move it and then move it back to get the third dimension. Not sure what this does to performance since we'll be doing this every frame.
        //noise.move(by: vector_double3(0.0, 0.0, d_z))
        //let result = noiseMap.value(at: vector_int2(Int32(Int(f_x)), Int32(Int(f_y))))
        let result = perlinNoise.value(atPosition: vector_float2(f_x, f_y))
        //noise.move(by: vector_double3(0.0, 0.0, -d_z))
        
        return Double(map(result, -1, 1, 0, 1))
    }
    */
}
