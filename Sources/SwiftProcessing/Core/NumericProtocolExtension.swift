/*
 * Swift Processing: Numeric Protocol Extension
 *
 * In order to facilitate conversions between various data
 * types and avoid early conversations about casting and coersion
 * we use this protocol and extension.
 *
 */

import Foundation
import CoreGraphics

// =======================================================================
// MARK: - NUMERIC MODIFICATION
// =======================================================================

// Source: https://stackoverflow.com/questions/39486362/how-to-cast-generic-number-type-t-to-cgfloat

public protocol Numeric {
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
    init(_ v:CGFloat)
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
