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
// MARK: - GENERIC SHAPES PROTOCOL
// =======================================================================


/// Draw 2D Primitives to the screen
public protocol Shapes: Sketch {
    
    /// Draw an arc to the screen.
    /// - Parameters:
    ///   - x: x-coordinate of the arc's ellipse
    ///   - y:  y-coordinate of the arc's ellipse
    ///   - width: width of the arc's ellipse by default
    ///   - height: height of the arc's ellipse by default
    ///   - start: angle to start the arc, specified in radians
    ///   - stop: angle to stop the arc, specified in radians
    ///   - mode:  optional parameter to determine the way of drawing the arc. either CHORD, PIE or OPEN
    func arc<X: Numeric, Y: Numeric, W: Numeric, H: Numeric, S1: Numeric, S2: Numeric>(_ x: X, _ y: Y, _ width: W, _ height: H, _ start: S1, _ stop: S2, _ mode: ArcMode)
    
    /// Draw an ellipse to the screen.
    /// - Parameters:
    ///   - x: x-coordinate of the center of ellipse.
    ///   - y: y-coordinate of the center of ellipse.
    ///   - width: width of the ellipse.
    ///   - height: height of the ellipse. (optional)
    func ellipse<X: Numeric, Y: Numeric, W: Numeric, H: Numeric>(_ x: X, _ y: Y, _ width: W, _ height: H)
    
    /// Draw a circle to the screen
    /// - Parameters:
    ///   - x: x-coordinate of the centre of the circle.
    ///   - y: y-coordinate of the centre of the circle.
    ///   - diameter: diameter of the circle.
    func circle<X: Numeric, Y: Numeric, D: Numeric>(_ x: X, _ y: Y, _ diameter: D)
    
    /// Draw a line to the screen.
    /// - Parameters:
    ///   - x1: the x-coordinate of the first point
    ///   - y1: the y-coordinate of the first point
    ///   - x2: the x-coordinate of the second point
    ///   - y2: the y-coordinate of the second point
    
    func line<X1: Numeric, Y1: Numeric, X2: Numeric, Y2: Numeric>(_ x1: X1, _ y1: Y1, _ x2: X2, _ y2: Y2)
    
    /// Draws a single point on the screen using the current stroke weight.
    /// - Parameters:
    ///   - x: the x-coordinate
    ///   - y: the y-coordinate
    func point<X: Numeric, Y: Numeric>(_ x: X, _ y: Y)
    
    /// Draws a rectangle on the screen
    /// - Parameters:
    ///   - x: x-coordinate of the rectangle.
    ///   - y: y-coordinate of the rectangle.
    ///   - width: width of the rectangle.
    ///   - height: height of the rectangle. (Optional)
    func rect<X: Numeric, Y: Numeric, W: Numeric, H: Numeric>(_ x: X, _ y: Y, _ width: W, _ height: H)
    
    /// Draws a square to the screen.
    /// - Parameters:
    ///   - x: x-coordinate of the square.
    ///   - y: y-coordinate of the square.
    ///   - size: size of the square.
    func square<X: Numeric, Y: Numeric, S: Numeric>(_ x: X, _ y: Y, _ size: S)
    
    /// Draws a trangle to the screen.
    /// - Parameters:
    ///   - x1: x-coordinate of the first point
    ///   - y1: y-coordinate of the first point
    ///   - x2: x-coordinate of the second point
    ///   - y2: y-coordinate of the second point
    ///   - x3: x-coordinate of the third point
    ///   - y3: y-coordinate of the third point
    func triangle<X1: Numeric, Y1: Numeric, X2: Numeric, Y2: Numeric, X3: Numeric, Y3: Numeric>(_ x1: X1, _ y1: Y1, _ x2: X2, _ y2: Y2, _ x3: X3, _ y3: Y3)
    
    /// Draws a quad to the screen.
    /// - Parameters:
    ///   - x1: x-coordinate of the first point
    ///   - y1: y-coordinate of the first point
    ///   - x2: x-coordinate of the second point
    ///   - y2: y-coordinate of the second point
    ///   - x3: x-coordinate of the third point
    ///   - y3: y-coordinate of the third point
    ///   - x4: x-coordinate of the fourth point
    func quad<X1: Numeric, Y1: Numeric, X2: Numeric, Y2: Numeric, X3: Numeric, Y3: Numeric, X4: Numeric, Y4: Numeric>(_ x1: X1, _ y1: Y1, _ x2: X2, _ y2: Y2, _ x3: X3, _ y3: Y3, _ x4: X4, _ y4: Y4)
}

// =======================================================================
// MARK: - GENERIC SHAPES EXTENSION
// =======================================================================

extension Sketch: Shapes {
    
    public func arc<X: Numeric, Y: Numeric, W: Numeric, H: Numeric, S1: Numeric, S2: Numeric>(_ x: X, _ y: Y, _ width: W, _ height: H, _ start: S1, _ stop: S2, _ mode: ArcMode = .pie) {
        var cg_x, cg_y, cg_w, cg_h, cg_start, cg_stop: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        cg_w = width.convert()
        cg_h = height.convert()
        cg_start = start.convert()
        cg_stop = stop.convert()
        
        let r = cg_w * 0.5
        let t = CGAffineTransform(scaleX: 1.0, y: cg_h / cg_w)
        
        context?.beginPath()
        let path: CGMutablePath = CGMutablePath()
        path.addArc(center: CGPoint(x: cg_x, y: cg_y / t.d), radius: r, startAngle: cg_start, endAngle: cg_stop, clockwise: false, transform: t)
        switch mode{
        case ArcMode.pie:
            path.addLine(to: CGPoint(x: cg_x, y: cg_y))
            path.closeSubpath()
        case ArcMode.chord:
            path.closeSubpath()
        case ArcMode.open:
            // NEEDS TESTING
            break
        }
        context?.addPath(path)
        context?.drawPath(using: .eoFillStroke)
    }
    
    public func ellipse<X: Numeric, Y: Numeric, W: Numeric, H: Numeric>(_ x: X, _ y: Y, _ width: W, _ height: H = -1 as! H ) {
        var cg_x, cg_y, cg_w, cg_h: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        cg_w = width.convert()
        cg_h = height.convert()
        
        // We're going to manipulate the coordinate matrix, so we need to freeze everything.
        context?.saveGState()
        ellipseModeHelper(cg_x, cg_y, cg_w, cg_h)
        
        // Corners adjustment
        var newW = cg_w
        var newH = cg_h
        if settings.ellipseMode == ShapeMode.corners {
            newW = cg_w - cg_x
            newH = cg_h - cg_y
        }
        
        context?.fillEllipse(in: CGRect(x: cg_x, y: cg_y, width: newW, height: newH))
        context?.strokeEllipse(in: CGRect(x: cg_x, y: cg_y, width: newW, height: newH))
        
        // We're going to restore the matrix to the previous state.
        context?.restoreGState()
    }
    
    public func circle<X: Numeric, Y: Numeric, D: Numeric>(_ x: X, _ y: Y, _ diameter: D) {
        ellipse(x, y, diameter, diameter)
    }
    
    // Private methods remain CGFloat.
    private func ellipseModeHelper(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        switch settings.ellipseMode {
        case .center:
            translate(-width * 0.5, -height * 0.5)
        case .radius:
            scale(0.5, 0.5)
        case .corner:
            return
        case .corners:
            return
        }
    }
    
    public func line<X1: Numeric, Y1: Numeric, X2: Numeric, Y2: Numeric>(_ x1: X1, _ y1: Y1, _ x2: X2, _ y2: Y2) {
        var cg_x1, cg_y1, cg_x2, cg_y2: CGFloat
        cg_x1 = x1.convert()
        cg_y1 = y1.convert()
        cg_x2 = x2.convert()
        cg_y2 = y2.convert()
        
        context?.move(to: CGPoint(x: cg_x1, y: cg_y1))
        context?.addLine(to: CGPoint(x: cg_x2, y: cg_y2))
        context?.strokePath()
    }
    
    public func point<X: Numeric, Y: Numeric>(_ x: X, _ y: Y) {
        var cg_x, cg_y: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        
        context?.setLineCap(.round)
        line(cg_x, cg_y, cg_x + CGFloat(settings.strokeWeight), cg_y)
        context?.setLineCap(.square)
    }
    
    public func rect<X: Numeric, Y: Numeric, W: Numeric, H: Numeric>(_ x: X, _ y: Y, _ width: W, _ height: H) {
        var cg_x, cg_y, cg_w, cg_h: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        cg_w = width.convert()
        cg_h = height.convert()
        
        // We're going to manipulate the coordinate matrix, so we need to freeze everything.
        context?.saveGState()
        
        rectModeHelper(cg_x, cg_y, cg_w, cg_h)
        
        var newW = cg_w
        var newH = cg_h
        if settings.rectMode == .corners {
            newW = cg_w - cg_x
            newH = cg_h - cg_y
        }
        
        // Apple recommends doing fill before stroke. This is consistent with how
        // Processing works as well. Using the painting metaphor we imagine that
        // we fill the shape, before stroking it's outline and stroke weights behave
        // and appear how we would expect them to.
        
        context?.fill(CGRect(x: cg_x, y: cg_y, width: newW, height: newH))
        context?.stroke(CGRect(x: cg_x, y: cg_y, width: newW, height: newH))
        
        // We're going to restore the matrix to the previous state.
        context?.restoreGState()
    }
    
    private func rectModeHelper(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        switch settings.rectMode {
        case .center:
            translate(-width * 0.5, -height * 0.5)
        case .radius:
            scale(0.5, 0.5)
        case .corner:
            return
        case .corners:
            return
        }
    }
    
    // A function for use internally. Setting backgroundColor of the view does not seem to work, so we are forced to draw a rectangle to set the background color. That's fine, except that the rect function reads from the Processing graphics state, which is not what we want. We want consistent behavior no matter what API users are setting the state to.
    
    public func internalRect<X: Numeric, Y: Numeric, W: Numeric, H: Numeric>(_ x: X, _ y: Y, _ width: W, _ height: H) {
        var cg_x, cg_y, cg_w, cg_h: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        cg_w = width.convert()
        cg_h = height.convert()
        
        context?.fill(CGRect(x: cg_x, y: cg_y, width: cg_w, height: cg_h))
    }
    
    public func square<X: Numeric, Y: Numeric, S: Numeric>(_ x: X, _ y: Y, _ start: S) {
        rect(x, y, start, start)
    }
    
    public func triangle<X1: Numeric, Y1: Numeric, X2: Numeric, Y2: Numeric, X3: Numeric, Y3: Numeric>(_ x1: X1, _ y1: Y1, _ x2: X2, _ y2: Y2, _ x3: X3, _ y3: Y3) {
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
    
    public func quad<X1: Numeric, Y1: Numeric, X2: Numeric, Y2: Numeric, X3: Numeric, Y3: Numeric, X4: Numeric, Y4: Numeric>(_ x1: X1, _ y1: Y1, _ x2: X2, _ y2: Y2, _ x3: X3, _ y3: Y3, _ x4: X4, _ y4: Y4) {
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

