/*
 * Swift Processing 2D Primitives w/ Generics
 *
 * A new and complete set of shapes that use generics
 * to ease new users into Swift Processing without
 * deep knowledge of types.
 *
 * To avoid having students and new programmers encounter
 * the difficulties switching between Swift CGFloat/Double
 * we are using generics for user-facing code, and
 * converting everything to CGFloats internally to
 * interface with Core Graphics.
 *
 */

import UIKit
import CoreGraphics

// =======================================================================
// MARK: - NUMERIC MODIFICATION
// =======================================================================

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

// =======================================================================
// MARK: - GENERIC SHAPES PROTOCOL
// =======================================================================


/// Draw 2D Primitives to the screen
public protocol ShapesGeneric {
    /// Draw an arc to the screen.
    /// - Parameters:
    ///   - x: x-coordinate of the arc's ellipse
    ///   - y:  y-coordinate of the arc's ellipse
    ///   - w: width of the arc's ellipse by default
    ///   - h: height of the arc's ellipse by default
    ///   - start: angle to start the arc, specified in radians
    ///   - stop: angle to stop the arc, specified in radians
    ///   - mode:  optional parameter to determine the way of drawing the arc. either CHORD, PIE or OPEN
    func arc<T: Numeric>(_ x: T, _ y: T, _ w: T, _ h: T, _ start: T, _ stop: T, _ mode: String)
    
    /// Draw an ellipse to the screen.
    /// - Parameters:
    ///   - x: x-coordinate of the center of ellipse.
    ///   - y: y-coordinate of the center of ellipse.
    ///   - w: width of the ellipse.
    ///   - h: height of the ellipse. (optional)
    func ellipse<T: Numeric>(_ x: T, _ y: T, _ w: T, _ h: T)

    /// Draw a circle to the screen
    /// - Parameters:
    ///   - x: x-coordinate of the centre of the circle.
    ///   - y: y-coordinate of the centre of the circle.
    ///   - d: diameter of the circle.
    func circle<T: Numeric>(_ x: T, _ y: T, _ d: T)
    
    /// Draw a line to the screen.
    /// - Parameters:
    ///   - x1: the x-coordinate of the first point
    ///   - y1: the y-coordinate of the first point
    ///   - x2: the x-coordinate of the second point
    ///   - y2: the y-coordinate of the second point
    
    func line<T: Numeric>(_ x1: T, _ y1: T, _ x2: T, _ y2: T)
    
    /// Draws a single point on the screen using the current stroke weight.
    /// - Parameters:
    ///   - x: the x-coordinate
    ///   - y: the y-coordinate
    func point<T: Numeric>(_ x: T, _ y: T)
    
    /// Draws a rectangle on the screen
    /// - Parameters:
    ///   - x: x-coordinate of the rectangle.
    ///   - y: y-coordinate of the rectangle.
    ///   - w: width of the rectangle.
    ///   - h: height of the rectangle. (Optional)
    func rect<T: Numeric>(_ x: T, _ y: T, _ w: T, _ h: T)

    /// Draws a square to the screen.
    /// - Parameters:
    ///   - x: x-coordinate of the square.
    ///   - y: y-coordinate of the square.
    ///   - s: size of the square.
    func square<T: Numeric>(_ x: T, _ y: T, _ s: T)
    
    /// Draws a trangle to the screen.
    /// - Parameters:
    ///   - x1: x-coordinate of the first point
    ///   - y1: y-coordinate of the first point
    ///   - x2: x-coordinate of the second point
    ///   - y2: y-coordinate of the second point
    ///   - x3: x-coordinate of the third point
    ///   - y3: y-coordinate of the third point
    func triangle<T: Numeric>(_ x1: T, _ y1: T, _ x2: T, _ y2: T, _ x3: T, _ y3: T)
    
    /// Draws a quad to the screen.
    /// - Parameters:
    ///   - x1: x-coordinate of the first point
    ///   - y1: y-coordinate of the first point
    ///   - x2: x-coordinate of the second point
    ///   - y2: y-coordinate of the second point
    ///   - x3: x-coordinate of the third point
    ///   - y3: y-coordinate of the third point
    ///   - x4: x-coordinate of the fourth point
    func quad<T: Numeric>(_ x1: T, _ y1: T, _ x2: T, _ y2: T, _ x3: T, _ y3: T, _ x4: T, _ y4: T)
}

// =======================================================================
// MARK: - GENERIC SHAPES EXTENSION
// =======================================================================

extension Sketch: ShapesGeneric {
    
    public func arc<T: Numeric>(_ x: T, _ y: T, _ w: T, _ h: T, _ start: T, _ stop: T, _ mode: String = "PIE") {
        var cg_x, cg_y, cg_w, cg_h, cg_start, cg_stop: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        cg_w = w.convert()
        cg_h = h.convert()
        cg_start = start.convert()
        cg_stop = stop.convert()
        
        let r = cg_w * 0.5
        let t = CGAffineTransform(scaleX: 1.0, y: cg_h / cg_w)
        
        context?.beginPath()
        let path: CGMutablePath = CGMutablePath()
        path.addArc(center: CGPoint(x: cg_x, y: cg_y / t.d), radius: r, startAngle: cg_start, endAngle: cg_stop, clockwise: false, transform: t)
        switch mode{
            case PIE:
                path.addLine(to: CGPoint(x: cg_x, y: cg_y))
                path.closeSubpath()
            case CHORD:
                path.closeSubpath()
            case OPEN:
                break
            default:
                break
        }
        context?.addPath(path)
        context?.drawPath(using: .eoFillStroke)
    }
    
    public func ellipse<T: Numeric>(_ x: T, _ y: T, _ w: T, _ h: T = -1 as! T ) {
        var cg_x, cg_y, cg_w, cg_h: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        cg_w = w.convert()
        cg_h = h.convert()
        
        var height = cg_h
        if cg_h == -1 {
            height = cg_w
        }
        push()
        ellipseModeHelper(cg_x, cg_y, cg_w, height)

        var newW = cg_w
        var newH = height
        if settings.ellipseMode == CORNERS {
            newW = cg_w - cg_x
            newH = cg_h - cg_y
        }

        context?.strokeEllipse(in: CGRect(x: cg_x, y: cg_y, width: newW, height: newH))
        context?.fillEllipse(in: CGRect(x: cg_x, y: cg_y, width: newW, height: newH))

        pop()
    }
    
    public func circle<T: Numeric>(_ x: T, _ y: T, _ d: T) {
        ellipse(x, y, d, d)
    }
    
    // Private methods remain CGFloat.
    private func ellipseModeHelper(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) {
        switch settings.ellipseMode {
        case CENTER:
            translate(-w * 0.5, -h * 0.5)
        case RADIUS:
            scale(0.5, 0.5)
        case CORNER:
            return
        case CORNERS:
            return
        default:
            print("invalid ellipseModeValue")
        }
    }
    
    public func line<T: Numeric>(_ x1: T, _ y1: T, _ x2: T, _ y2: T) {
        var cg_x1, cg_y1, cg_x2, cg_y2: CGFloat
        cg_x1 = x1.convert()
        cg_y1 = y1.convert()
        cg_x2 = x2.convert()
        cg_y2 = y2.convert()
        
        context?.move(to: CGPoint(x: cg_x1, y: cg_y1))
        context?.addLine(to: CGPoint(x: cg_x2, y: cg_y2))
        context?.strokePath()
    }
    
    public func point<T: Numeric>(_ x: T, _ y: T) {
        var cg_x, cg_y: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        
        context?.setLineCap(.round)
        line(cg_x, cg_y, cg_x + CGFloat(strokeWeight), cg_y)
        context?.setLineCap(.square)
    }
    
    public func rect<T: Numeric>(_ x: T, _ y: T, _ w: T, _ h: T) {
        var cg_x, cg_y, cg_w, cg_h: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        cg_w = w.convert()
        cg_h = h.convert()
        
        // Double check this. Stroke and fill are in the opposite order that Apple recommends.
        context?.stroke(CGRect(x: cg_x, y: cg_y, width: cg_w, height: cg_h))
        context?.fill(CGRect(x: cg_x, y: cg_y, width: cg_w, height: cg_h))
    }
    
    public func square<T: Numeric>(_ x: T, _ y: T, _ s: T) {
        rect(x, y, s, s)
    }
    
    public func triangle<T: Numeric>(_ x1: T, _ y1: T, _ x2: T, _ y2: T, _ x3: T, _ y3: T) {
        var cg_x1, cg_y1, cg_x2, cg_y2, cg_x3, cg_y3: CGFloat
        cg_x1 = x1.convert()
        cg_y1 = y1.convert()
        cg_x2 = x2.convert()
        cg_y2 = y2.convert()
        cg_x3 = x3.convert()
        cg_y3 = y3.convert()
        
        context?.beginPath()
        context?.move(to: CGPoint(x: cg_x1, y: cg_y1))
        context?.addLine(to: CGPoint(x: cg_x2, y: cg_y2))
        context?.addLine(to: CGPoint(x: cg_x3, y: cg_y3))
        context?.closePath()
        context?.drawPath(using: .eoFillStroke)
    }
    
    public func quad<T: Numeric>(_ x1: T, _ y1: T, _ x2: T, _ y2: T, _ x3: T, _ y3: T, _ x4: T, _ y4: T) {
        var cg_x1, cg_y1, cg_x2, cg_y2, cg_x3, cg_y3, cg_x4, cg_y4: CGFloat
        cg_x1 = x1.convert()
        cg_y1 = y1.convert()
        cg_x2 = x2.convert()
        cg_y2 = y2.convert()
        cg_x3 = x3.convert()
        cg_y3 = y3.convert()
        cg_x4 = x4.convert()
        cg_y4 = y4.convert()
        
        context?.beginPath()
        context?.move(to: CGPoint(x: cg_x1, y: cg_y1))
        context?.addLine(to: CGPoint(x: cg_x2, y: cg_y2))
        context?.addLine(to: CGPoint(x: cg_x3, y: cg_y3))
        context?.addLine(to: CGPoint(x: cg_x4, y: cg_y4))
        context?.closePath()
        context?.drawPath(using: .eoFillStroke)
    }
}
