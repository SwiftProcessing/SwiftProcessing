/*
 * Swift Processing 2D Primitives w/ Generics
 *
 * An experimental set of shapes that use generics
 * to ease new users into Swift Processing without
 * deep knowledge of types.
 *
 * In a SwiftProcessing redesign it might be useful
 * to avoid the Swift CGFloat/Double difficulties
 * by using generics for user-facing code, and
 * converting everything to CGFloats internally to
 * interface with Core Graphics.
 *
 */

import UIKit
import CoreGraphics

// Source: https://stackoverflow.com/questions/39486362/how-to-cast-generic-number-type-t-to-cgfloat

public protocol Numeric {
    //
    init(_ v:Float)
    init(_ v:Double)
    init(_ v:Int)
    init(_ v:UInt)
    init(_ v:Int8)
    init(_ v:UInt8)
    init(_ v:Int16)
    init(_ v:UInt16)
    init(_ v:Int32)
    init(_ v:UInt32)
    init(_ v:Int64)
    init(_ v:UInt64)
    init(_ v: CGFloat)
}

extension Float   : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension Double  : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension CGFloat : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension Int     : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension Int8    : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension Int16   : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension Int32   : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension Int64   : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension UInt    : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension UInt8   : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension UInt16  : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension UInt32  : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}
extension UInt64  : Numeric {func _asOther<T:Numeric>() -> T { return T(self) }}


extension Numeric {

    func convert<T: Numeric>() -> T {
        switch self {
        case let x as CGFloat:
            return T(x) //T.init(x)
        case let x as Float:
            return T(x)
        case let x as Double:
            return T(x)
        case let x as Int:
            return T(x)
        case let x as UInt:
            return T(x)
        case let x as Int8:
            return T(x)
        case let x as UInt8:
            return T(x)
        case let x as Int16:
            return T(x)
        case let x as UInt16:
            return T(x)
        case let x as Int32:
            return T(x)
        case let x as UInt32:
            return T(x)
        case let x as Int64:
            return T(x)
        case let x as UInt64:
            return T(x)
        default:
            assert(false, "Numeric convert cast failed!")
            return T(0)
        }
    }
}

/// Draw 2D Primitives to the screen
public protocol ShapesGeneric {
    /// Draw a line to the screen.
    /// - Parameters:
    ///   - x1: the x-coordinate of the first point
    ///   - y1: the y-coordinate of the first point
    ///   - x2: the x-coordinate of the second point
    ///   - y2: the y-coordinate of the second point
    
    func line<T: Numeric>(_ x1: T, _ y1: T, _ x2: T, _ y2: T)
}

extension Sketch: ShapesGeneric {
    
    public func line<T: Numeric>(_ x1: T, _ y1: T, _ x2: T, _ y2: T) {
        let out_x1, out_y1, out_x2, out_y2: CGFloat
        out_x1 = x1.convert()
        out_y1 = y2.convert()
        out_x2 = x2.convert()
        out_y2 = y2.convert()
        line(out_x1, out_y1, out_x2, out_y2)
    }
}
