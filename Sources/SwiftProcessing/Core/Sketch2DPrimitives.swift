/*
 * SwiftProcessing: 2D Primitives
 *
 */

import UIKit

// =======================================================================
// MARK: - SHAPES PROTOCOL
// =======================================================================

/// Draw 2D Primitives to the screen
public protocol Shapes {
    
    /*
    * MARK: - CGFLOAT SHAPES
    */
    
    /// Draw an arc to the screen.
    /// - Parameters:
    ///   - x: x-coordinate of the arc's ellipse
    ///   - y:  y-coordinate of the arc's ellipse
    ///   - w: width of the arc's ellipse by default
    ///   - h: height of the arc's ellipse by default
    ///   - start: angle to start the arc, specified in radians
    ///   - stop: angle to stop the arc, specified in radians
    ///   - mode:  optional parameter to determine the way of drawing the arc. either CHORD, PIE or OPEN
    func arc(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat, _ start: CGFloat, _ stop: CGFloat, _ mode: String)
    
    /// Draw an ellipse to the screen.
    /// - Parameters:
    ///   - x: x-coordinate of the center of ellipse.
    ///   - y: y-coordinate of the center of ellipse.
    ///   - w: width of the ellipse.
    ///   - h: height of the ellipse. (optional)
    func ellipse(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat)
    
    /// Draw a circle to the screen
    /// - Parameters:
    ///   - x: x-coordinate of the centre of the circle.
    ///   - y: y-coordinate of the centre of the circle.
    ///   - d: diameter of the circle.
    func circle(_ x: CGFloat, _ y: CGFloat, _ d: CGFloat)
    
    /// Draw a line to the screen.
    /// - Parameters:
    ///   - x1: the x-coordinate of the first point
    ///   - y1: the y-coordinate of the first point
    ///   - x2: the x-coordinate of the second point
    ///   - y2: the y-coordinate of the second point
    func line(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat)
    
    /// Draws a single point on the screen using the current stroke weight.
    /// - Parameters:
    ///   - x: the x-coordinate
    ///   - y: the y-coordinate
    func point(_ x: CGFloat, _ y: CGFloat)
    
    /// Draws a rectangle on the screen
    /// - Parameters:
    ///   - x: x-coordinate of the rectangle.
    ///   - y: y-coordinate of the rectangle.
    ///   - w: width of the rectangle.
    ///   - h: height of the rectangle. (Optional)
    func rect(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat)
    
    /// Draws a square to the screen.
    /// - Parameters:
    ///   - x: x-coordinate of the square.
    ///   - y: y-coordinate of the square.
    ///   - s: size of the square.
    func square(_ x: CGFloat, _ y: CGFloat, _ s: CGFloat)
    
    /// Draws a trangle to the screen.
    /// - Parameters:
    ///   - x1: x-coordinate of the first point
    ///   - y1: y-coordinate of the first point
    ///   - x2: x-coordinate of the second point
    ///   - y2: y-coordinate of the second point
    ///   - x3: x-coordinate of the third point
    ///   - y3: y-coordinate of the third point
    func triangle(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ x3: CGFloat, _ y3: CGFloat)
    
    /*
    * MARK: - DOUBLE SHAPES
    */
    
    /// Draw an arc to the screen.
    /// - Parameters:
    ///   - x: x-coordinate of the arc's ellipse
    ///   - y:  y-coordinate of the arc's ellipse
    ///   - w: width of the arc's ellipse by default
    ///   - h: height of the arc's ellipse by default
    ///   - start: angle to start the arc, specified in radians
    ///   - stop: angle to stop the arc, specified in radians
    ///   - mode:  optional parameter to determine the way of drawing the arc. either CHORD, PIE or OPEN
    func arc(_ x: Double, _ y: Double, _ w: Double, _ h: Double, _ start: Double, _ stop: Double, _ mode: String)
    
    /// Draw an ellipse to the screen.
    /// - Parameters:
    ///   - x: x-coordinate of the center of ellipse.
    ///   - y: y-coordinate of the center of ellipse.
    ///   - w: width of the ellipse.
    ///   - h: height of the ellipse. (optional)
    func ellipse(_ x: Double, _ y: Double, _ w: Double, _ h: Double)
    
    /// Draw a circle to the screen
    /// - Parameters:
    ///   - x: x-coordinate of the centre of the circle.
    ///   - y: y-coordinate of the centre of the circle.
    ///   - d: diameter of the circle.
    func circle(_ x: Double, _ y: Double, _ d: Double)
    
    /// Draw a line to the screen.
    /// - Parameters:
    ///   - x1: the x-coordinate of the first point
    ///   - y1: the y-coordinate of the first point
    ///   - x2: the x-coordinate of the second point
    ///   - y2: the y-coordinate of the second point
    //func line(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double)
    
    /// Draws a single point on the screen using the current stroke weight.
    /// - Parameters:
    ///   - x: the x-coordinate
    ///   - y: the y-coordinate
    func point(_ x: Double, _ y: Double)
    
    /// Draws a rectangle on the screen
    /// - Parameters:
    ///   - x: x-coordinate of the rectangle.
    ///   - y: y-coordinate of the rectangle.
    ///   - w: width of the rectangle.
    ///   - h: height of the rectangle. (Optional)
    func rect(_ x: Double, _ y: Double, _ w: Double, _ h: Double)
    
    /// Draws a square to the screen.
    /// - Parameters:
    ///   - x: x-coordinate of the square.
    ///   - y: y-coordinate of the square.
    ///   - s: size of the square.
    func square(_ x: Double, _ y: Double, _ s: Double)
    
    /// Draws a quad to the screen.
    /// - Parameters:
    ///   - x1: x-coordinate of the first point
    ///   - y1: y-coordinate of the first point
    ///   - x2: x-coordinate of the second point
    ///   - y2: y-coordinate of the second point
    ///   - x3: x-coordinate of the third point
    ///   - y3: y-coordinate of the third point
    ///   - x4: x-coordinate of the fourth point
    func quad(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double, _ x3: Double, _ y3: Double, _ x4: Double, _ y4: Double)
    
    /// Draws a triangle to the screen.
    /// - Parameters:
    ///   - x1: x-coordinate of the first point
    ///   - y1: y-coordinate of the first point
    ///   - x2: x-coordinate of the second point
    ///   - y2: y-coordinate of the second point
    ///   - x3: x-coordinate of the third point
    ///   - y3: y-coordinate of the third point
    func triangle(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double, _ x3: Double, _ y3: Double)

}

// =======================================================================
// MARK: - SHAPES EXTENSION
// =======================================================================

extension Sketch: Shapes {
    /*
    * MARK: - CGFLOAT IMPLEMENTATION
    */
    
    public func arc(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat, _ start: CGFloat, _ stop: CGFloat, _ mode: String = "pie") {
 
        let r = w * 0.5
        let t = CGAffineTransform(scaleX: 1.0, y: h / w)
        
        context?.beginPath()
        let path: CGMutablePath = CGMutablePath()
        path.addArc(center: CGPoint(x: x, y: y / t.d), radius: r, startAngle: start, endAngle: stop, clockwise: false, transform: t)
        switch mode{
            case PIE:
                path.addLine(to: CGPoint(x: x, y: y))
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

    public func ellipse(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat = -1 ) {
        var height = h
        if h == -1 {
            height = w
        }
        push()
        ellipseModeHelper(x, y, w, height)

        var newW = w
        var newH = height
        if settings.ellipseMode == CORNERS {
            newW = w - x
            newH = h - y
        }

        context?.strokeEllipse(in: CGRect(x: x, y: y, width: newW, height: newH))
        context?.fillEllipse(in: CGRect(x: x, y: y, width: newW, height: newH))

        pop()
    }

    public func circle(_ x: CGFloat, _ y: CGFloat, _ d: CGFloat) {
        ellipse(x, y, d, d)
    }

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

    public func line(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat) {
        context?.move(to: CGPoint(x: x1, y: y1))
        context?.addLine(to: CGPoint(x: x2, y: y2))
        context?.strokePath()
    }

    public func point(_ x: CGFloat, _ y: CGFloat) {
        line(x, y, x + CGFloat(strokeWeight), y)
    }

    public func rect(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) {
        context?.stroke(CGRect(x: x, y: y, width: w, height: h))
        context?.fill(CGRect(x: x, y: y, width: w, height: h))
    }

    public func square(_ x: CGFloat, _ y: CGFloat, _ s: CGFloat) {
        rect(x, y, s, s)
    }
    
    public func quad(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ x3: CGFloat, _ y3: CGFloat, _ x4: CGFloat, _ y4: CGFloat) {
        context?.beginPath()
        context?.move(to: CGPoint(x: x1, y: y1))
        context?.addLine(to: CGPoint(x: x2, y: y2))
        context?.addLine(to: CGPoint(x: x3, y: y3))
        context?.addLine(to: CGPoint(x: x4, y: y4))
        context?.closePath()
        context?.drawPath(using: .eoFillStroke)
    }

    public func triangle(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ x3: CGFloat, _ y3: CGFloat) {
        context?.beginPath()
        context?.move(to: CGPoint(x: x1, y: y1))
        context?.addLine(to: CGPoint(x: x2, y: y2))
        context?.addLine(to: CGPoint(x: x3, y: y3))
        context?.closePath()
        context?.drawPath(using: .eoFillStroke)
    }
    
    /*
    * MARK: - DOUBLE IMPLEMENTATION
    */
    public func arc(_ x: Double, _ y: Double, _ w: Double, _ h: Double, _ start: Double, _ stop: Double, _ mode: String = "pie") {
 
        let r = w * 0.5
        let ratio:CGFloat = CGFloat(h/w)
        let t = CGAffineTransform(scaleX: 1.0, y: ratio)
        
        context?.beginPath()
        let path: CGMutablePath = CGMutablePath()
        path.addArc(center: CGPoint(x: CGFloat(x), y: CGFloat(y) / t.d), radius: CGFloat(r), startAngle: CGFloat(start), endAngle: CGFloat(stop), clockwise: false, transform: t)
        switch mode{
            case PIE:
                path.addLine(to: CGPoint(x: x, y: y))
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

    public func ellipse(_ x: Double, _ y: Double, _ w: Double, _ h: Double = -1 ) {
        var height = h
        if h == -1 {
            height = w
        }
        push()
        ellipseModeHelper(x, y, w, height)

        var newW = w
        var newH = height
        if settings.ellipseMode == CORNERS {
            newW = w - x
            newH = h - y
        }

        context?.strokeEllipse(in: CGRect(x: x, y: y, width: newW, height: newH))
        context?.fillEllipse(in: CGRect(x: x, y: y, width: newW, height: newH))

        pop()
    }

    public func circle(_ x: Double, _ y: Double, _ d: Double) {
        ellipse(x, y, d, d)
    }

    private func ellipseModeHelper(_ x: Double, _ y: Double, _ w: Double, _ h: Double) {
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

    public func line(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) {
        context?.move(to: CGPoint(x: x1, y: y1))
        context?.addLine(to: CGPoint(x: x2, y: y2))
        context?.strokePath()
    }

    public func point(_ x: Double, _ y: Double) {
        line(x, y, x + strokeWeight, y)
    }

    public func rect(_ x: Double, _ y: Double, _ w: Double, _ h: Double) {
        context?.stroke(CGRect(x: x, y: y, width: w, height: h))
        context?.fill(CGRect(x: x, y: y, width: w, height: h))
    }

    public func square(_ x: Double, _ y: Double, _ s: Double) {
        rect(x, y, s, s)
    }
    
    public func quad(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double, _ x3: Double, _ y3: Double, _ x4: Double, _ y4: Double) {
        context?.beginPath()
        context?.move(to: CGPoint(x: x1, y: y1))
        context?.addLine(to: CGPoint(x: x2, y: y2))
        context?.addLine(to: CGPoint(x: x3, y: y3))
        context?.addLine(to: CGPoint(x: x4, y: y4))
        context?.closePath()
        context?.drawPath(using: .eoFillStroke)
    }

    public func triangle(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double, _ x3: Double, _ y3: Double) {
        context?.beginPath()
        context?.move(to: CGPoint(x: x1, y: y1))
        context?.addLine(to: CGPoint(x: x2, y: y2))
        context?.addLine(to: CGPoint(x: x3, y: y3))
        context?.closePath()
        context?.drawPath(using: .eoFillStroke)
    }
}
