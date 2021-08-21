/*
 * SwiftProcessing: Vertex
 *
 * */


import UIKit

// =======================================================================
// MARK: - Vertex Sketch Extension
// =======================================================================

public extension Sketch {

    /*
     * MARK: - BEGINSHAPE / ENDSHAPE
     */
    
    // NOTE TO FUTURE CONTRIBUTORS: There really should be a check to make sure that beginShape() is never called without an endShape(). It should gracefully throw an error that is meaningful and explains the issue.
    
    /// Marks the beginning of a vertex shape.
    /// ```
    /// // Creates a square shape with 4 vertex points
    /// beginShape()
    /// vertex(10, 10)
    /// vertex(90, 10)
    /// vertex(90, 90)
    /// vertex(10, 90)
    /// endShape(.close)
    /// ```
    
    func beginShape() {
        shapePoints = []
    }
    
    /// Marks the beginning of a vertex shape.
    /// ```
    /// // Creates a square shape with 4 vertex points
    /// beginShape()
    /// vertex(10, 10)
    /// vertex(90, 10)
    /// vertex(90, 90)
    /// vertex(10, 90)
    /// endShape(.close)
    /// ```
    /// - Parameters:
    ///      - mode: Shape path mode. Options are `.open` for an open shape and `.close` with a shape that is closed between its first and last points.
    
    func endShape(_ mode: ShapePath = .open) {
        context?.beginTransparencyLayer(auxiliaryInfo: .none)
        
        if vertexMode == VertexMode.normal {
            
            // DRAW SHAPE
            context?.beginPath()
            context?.move(to: shapePoints.first!)
            for p in shapePoints {
                context?.addLine(to: p)
            }
            
            if mode == ShapePath.close {
                context?.closePath()
            }
            context?.drawPath(using: .fillStroke)
            
            // NOTE FOR FUTURE CONTRIBUTORS: This approach *simulates* the behavior of beginContour, but is not actually how it works. Quartz (and Java 2D) use the non-zero winding number rule. This means that clockwise winding are beginShape and counter-clockwise winding are beginContour. This happens under the hood and that's how we should be implementing beginContour().
            // RESOURCE: https://en.wikipedia.org/wiki/Nonzero-rule
            
            // TO BE FIXED.
            
            // DRAW CONTOUR AS AN ERASE
            if contourPoints.count > 0 {
                context?.beginPath()
                context?.setBlendMode(CGBlendMode.clear)
                context?.move(to: contourPoints.first!)
                for p in contourPoints {
                    context?.addLine(to: p)
                }
                context?.drawPath(using: .fillStroke)
                // STROKE CONTOUR
                context?.setBlendMode(CGBlendMode.normal)
                context?.beginPath()
                context?.move(to: contourPoints.first!)
                for p in contourPoints {
                    context?.addLine(to: p)
                }
                context?.strokePath()
            }
            
        } else if vertexMode == VertexMode.curve {

            context?.beginPath()
            let curveDetail = 20.0
            let curvePath = CurvePath(points: shapePoints)
            
            context?.move(to: curvePath.points.first!)
            
            if mode == ShapePath.close {
                for p in stride(from: 0.0, to: Double(curvePath.points.count), by: 1.0/curveDetail) {
                    let curvePoint = (curvePath.getSplinePoint(u: CGFloat(p), closed: true))
                    // NOTE FOR FUTURE CONTRIBUTORS: This may be a place where multithreading could speed up execution. Async would be the thing to research. You could turn this into a closure, precompute the values, and then put them back together with another array.
                    context?.addLine(to: curvePoint)
                }
                context?.closePath()
            } else {
                for p in stride(from: 0.0, to: Double(curvePath.points.count) - 3.0, by: 1.0/curveDetail) {
                    let curvePoint = (curvePath.getSplinePoint(u: CGFloat(p), closed: false))
                    context?.addLine(to: curvePoint)
                }
            }
            context?.drawPath(using: .fillStroke)
            
        } else if vertexMode == VertexMode.bezier {
            context?.move(to: shapePoints.first!)
            var z = 1
            while z < shapePoints.count {
                context?.addCurve(to: shapePoints[z + 2], control1: shapePoints[z], control2: shapePoints[z + 1])
                z = z + 3
            }
            context?.drawPath(using: .fillStroke)
        }
        context?.endTransparencyLayer()
        
        shapePoints = []
        contourPoints = []
        vertexMode = VertexMode.normal
    }
    
    /*
     * MARK: - BEGINCONTOUR / ENDCONTOUR
     */
    
    // NOTE TO FUTURE CONTRIBUTORS: We really should be checking whether every beginContour() corresponds to an endContour(). If any calls don't correspond, then we should throw a meaningful error.
    
    /// Marks the beginning of a vertex contour. A contour is distinct from a shape in that it is a shape that cuts out of another shape. **Note:** Contour shapes are always 'closed'. A `beginContour()` call must always be accompanied by an `endContour()` call.
    /// ```
    /// // Creates a square shape with 4 vertex points
    /// beginShape()
    /// vertex(10, 10)
    /// vertex(90, 10)
    /// vertex(90, 90)
    /// vertex(10, 90)
    /// endShape(.close)
    ///
    ///// Cuts a smaller shape out of the larger shape
    /// beginContour()
    /// vertex(20, 20)
    /// vertex(80, 20)
    /// vertex(80, 80)
    /// vertex(20, 80)
    /// endContour()
    /// ```
    
    func beginContour() {
        isContourStarted = true
        contourPoints = []
    }
    
    /// Marks the end of a vertex contour. A contour is distinct from a shape in that it is a shape that cuts out of another shape. **Note:** Contour shapes are always 'closed'. A `beginContour()` call must always be accompanied by an `endContour()` call.
    /// ```
    /// // Creates a square shape with 4 vertex points
    /// beginShape()
    /// vertex(10, 10)
    /// vertex(90, 10)
    /// vertex(90, 90)
    /// vertex(10, 90)
    /// endShape(.close)
    ///
    ///// Cuts a smaller shape out of the larger shape
    /// beginContour()
    /// vertex(20, 20)
    /// vertex(80, 20)
    /// vertex(80, 80)
    /// vertex(20, 80)
    /// endContour()
    /// ```
    
    func endContour() {
        isContourStarted = false
        contourPoints.append(contourPoints.first!)
    }
    
    /*
     * MARK: - VERTEX FUNCTIONS
     */
    
    /// Creates a vertex point for creating shapes or contours.
    /// ```
    /// // Creates a square shape with 4 vertex points
    /// beginShape()
    /// vertex(10, 10)
    /// vertex(90, 10)
    /// vertex(90, 90)
    /// vertex(10, 90)
    /// endShape(.close)
    /// ```
    /// - Parameters:
    ///      - x: x-position of point
    ///      - x: y-position of point
    
    func vertex<X: Numeric, Y: Numeric>(_ x: X, _ y: Y) {
        let cg_x, cg_y: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        
        let point = CGPoint(x: cg_x, y: cg_y)
        
        if isContourStarted {
            contourPoints.append(point)
        } else {
            shapePoints.append(point)
        }
    }
    
    /// Creates a curve vertex point for creating curved shapes or contours.
    /// ```
    /// // Creates a rounded square shape with 4 vertex points
    /// beginShape()
    /// curveVertex(10, 10)
    /// curveVertex(90, 10)
    /// curveVertex(90, 90)
    /// curveVertex(10, 90)
    /// endShape(.close)
    /// ```
    /// - Parameters:
    ///      - x: x-position of point
    ///      - x: y-position of point
    
    func curveVertex<X: Numeric, Y: Numeric>(_ x: X, _ y: Y) {
        let cg_x, cg_y: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        
        vertexMode = VertexMode.curve
        
        vertex(cg_x, cg_y)
    }
    
    /// Creates a bezier curve vertex point for creating curved shapes or contours.
    /// ```
    /// // Creates a rounded square shape with 4 vertex points
    /// beginShape()
    /// vertex(120, 80);
    /// bezierVertex(320, 0, 320, 300, 90, 300);
    /// bezierVertex(200, 320, 240, 100, 120, 80);
    /// endShape(.close)
    /// ```
    /// - Parameters:
    ///      - x: x-position of point
    ///      - x: y-position of point
    
    func bezierVertex(_ x2: CGFloat, _ y2: CGFloat, _ x3: CGFloat, _ y3: CGFloat, _ x4: CGFloat, _ y4: CGFloat) {
        vertexMode = VertexMode.bezier
        vertex(x2, y2)
        vertex(x3, y3)
        vertex(x4, y4)
    }
    
    /*
     * MARK: - CATMULL-ROM SPLINE IMPLEMENTATION
     */
    
    // NOTE FOR FUTURE CONTRIBUTORS: The behavior of open and closed Catmull-Rom Spline curves is slightly different in SwiftProessing than Processing. The behavior of Processing is the correct behavior according to the algorithm. The curve should really begin at the second point and end at the 2nd to last point. That's how these curves are supposed to work. This is TO BE FIXED.
    
    private struct CurvePath {
        var points = [CGPoint]()

        // Source: https://en.wikipedia.org/wiki/Cubic_Hermite_spline#Interpolation_on_the_unit_interval_with_matched_derivatives_at_endpoints
        // https://www.youtube.com/watch?v=9_aJGUTePYo
        // https://lucidar.me/en/mathematics/catmull-rom-splines/
        // https://www.mvps.org/directx/articles/catmull/

        func getSplinePoint(u: CGFloat, closed: Bool) -> CGPoint{
            let p0, p1, p2, p3: Int
            
            // Curve tightness is not implemented yet. See Processing source code and Catmull-Rom info for more details. Tightness would be an additional way of controlling the curve.
            
            if (!closed) {
                p1 = Int(u) + 1
                p2 = p1 + 1
                p3 = p2 + 1
                p0 = p1 - 1
            } else {
                p1 = Int(u)
                p2 = (p1 + 1) % points.count
                p3 = (p2 + 1) % points.count
                p0 = p1 >= 1 ? p1 - 1 : points.count - 1
            }
            
            let u = u - floor(u)
            
            let uu = u * u
            let uuu = uu * u
            
            let q1 = -uuu + 2.0*uu - u
            let q2 = 3.0*uuu - 5.0*uu + 2.0
            let q3 = -3.0*uuu + 4.0*uu + u
            let q4 = uuu - uu

            let tx = 0.5 * (points[p0].x * q1 + points[p1].x * q2 + points[p2].x * q3 + points[p3].x * q4)
            let ty = 0.5 * (points[p0].y * q1 + points[p1].y * q2 + points[p2].y * q3 + points[p3].y * q4)
            
            return CGPoint(x: tx, y: ty)
        }
    }
}
