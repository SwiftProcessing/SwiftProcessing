/*
 * SwiftProcessing: Transform
 *
 * */

import UIKit

public extension Sketch {
    
    var translation: Vector{
        get{
            let translationX = context == nil ? 0 : (context?.ctm.tx)! / UIScreen.main.scale
            let translationY = context == nil ? 0 :  -(context?.ctm.ty)! / UIScreen.main.scale + frame.height
            return createVector(translationX, translationY)
        }
    }
    
    var scale: Vector{
        get{
            let scaleX = context == nil ? 1 : (context?.ctm.a)! / UIScreen.main.scale
            let scaleY = context == nil ? 1 :  -(context?.ctm.d)! / UIScreen.main.scale
            return createVector(scaleX, scaleY)
        }
    }
    
    /// Rotates the coordinate system using radians.
    ///
    /// - Parameters:
    ///     - angle: Usually a number from 0 to 2*PI. Numbers beyond that will just repeat the rotation.
    
    func rotate<T: Numeric>(_ angle: T) {
        context?.rotate(by: angle.convert())
    }
    
    /// Moves the coordinate system in the x and y direction.
    ///
    /// - Parameters:
    ///     - x: The number of points to move the coordinate system in the x direction.
    ///     - y: The number of points to move the coordinate system in the y direction.

    func translate<T: Numeric>(_ x: T, _ y: T) {
        context?.translateBy(x: x.convert(), y: y.convert())
    }
    
    /// Scales the coordinate system (i.e. makes it smaller or larger).
    ///
    /// - Parameters:
    ///     - factor: A uniform scaling factor that simultaneously affects the scale of both x and y.
    
    func scale<T: Numeric>(_ factor: T) {
        context?.scaleBy(x: factor.convert(), y: factor.convert())
    }
    
    /// Scales the coordinate system (i.e. makes it smaller or larger).
    ///
    /// - Parameters:
    ///     - x: The scaling magnitude in the x direction.
    ///     - y: The scaling magnitude in the y direction.
    
    func scale<T: Numeric>(_ x: T, _ y: T) {
        context?.scaleBy(x: x.convert(), y: y.convert())
    }
}
