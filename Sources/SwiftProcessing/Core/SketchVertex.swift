import UIKit

public extension Sketch {

    func beginShape() {
        shapePoints = []
    }

    func endShape(_ mode: String = "open") {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 2.0)

        let localContext = UIGraphicsGetCurrentContext()!
        localContext.setFillColor(settings.fill.uiColor().cgColor)
        localContext.setStrokeColor(settings.stroke.uiColor().cgColor)
        if vertexMode == NORMAL_VERTEX {
            if mode == CLOSE {
                shapePoints.append(shapePoints.first!)
            }

            //draw shape
            localContext.beginPath()
            localContext.move(to: shapePoints.first!)
            for p in shapePoints {
                localContext.addLine(to: p)
            }
            localContext.drawPath(using: .fillStroke)

            //draw contour as an erase
            localContext.beginPath()
            localContext.setBlendMode(CGBlendMode.clear)
            localContext.move(to: contourPoints.first!)
            for p in contourPoints {
                localContext.addLine(to: p)
            }
            localContext.drawPath(using: .fillStroke)

            //stroke contour
            localContext.setBlendMode(CGBlendMode.normal)
            localContext.beginPath()
            localContext.move(to: contourPoints.first!)
            for p in contourPoints {
                localContext.addLine(to: p)
            }
            localContext.strokePath()
        } else if vertexMode == CURVE_VERTEX {
            //todo
        } else if vertexMode == BEZIER_VERTEX {
            localContext.move(to: shapePoints.first!)
            var z = 1
            while z < shapePoints.count {
                localContext.addCurve(to: shapePoints[z + 2], control1: shapePoints[z], control2: shapePoints[z + 1])
                z = z + 3
            }
            localContext.drawPath(using: .fillStroke)
        }

        //extract image from image context and display it
        let i = Image(UIGraphicsGetImageFromCurrentImageContext()!)
        UIGraphicsEndImageContext()
        image(i, 0, 0)

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
