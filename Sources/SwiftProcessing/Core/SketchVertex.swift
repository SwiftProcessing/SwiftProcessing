import UIKit

public extension Sketch {
    
    func beginShape() {
        shapePoints = []
    }
    
    func endShape(_ mode: String = "open") {
        context?.beginTransparencyLayer(auxiliaryInfo: .none)
        
        if vertexMode == NORMAL_VERTEX {
            if mode == CLOSE {
                shapePoints.append(shapePoints.first!)
            }
            
            //draw shape
            context?.beginPath()
            context?.move(to: shapePoints.first!)
            for p in shapePoints {
                context?.addLine(to: p)
            }
            context?.drawPath(using: .fillStroke)
            
            //draw contour as an erase
            if contourPoints.count > 0 {
                context?.beginPath()
                context?.setBlendMode(CGBlendMode.clear)
                context?.move(to: contourPoints.first!)
                for p in contourPoints {
                    context?.addLine(to: p)
                }
                context?.drawPath(using: .fillStroke)
                //stroke contour
                context?.setBlendMode(CGBlendMode.normal)
                context?.beginPath()
                context?.move(to: contourPoints.first!)
                for p in contourPoints {
                    context?.addLine(to: p)
                }
                context?.strokePath()
            }
        } else if vertexMode == CURVE_VERTEX {
            //todo
        } else if vertexMode == BEZIER_VERTEX {
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
        vertexMode = NORMAL_VERTEX
    }
    
    func beginContour() {
        isContourStarted = true
        contourPoints = []
    }
    
    func endContour() {
        isContourStarted = false
        contourPoints.append(contourPoints.first!)
    }
    
    func vertex(_ x: CGFloat, _ y: CGFloat) {
        let point = CGPoint(x: x, y: y)
        
        if isContourStarted {
            contourPoints.append(point)
        } else {
            shapePoints.append(point)
        }
    }
    
    func curveVertex(_ x: CGFloat, _ y: CGFloat) {
        vertexMode = CURVE_VERTEX
        vertex(x, y)
    }
    
    func bezierVertex(_ x2: CGFloat, _ y2: CGFloat, _ x3: CGFloat, _ y3: CGFloat, _ x4: CGFloat, _ y4: CGFloat) {
        vertexMode = BEZIER_VERTEX
        vertex(x2, y2)
        vertex(x3, y3)
        vertex(x4, y4)
    }
}
