import UIKit

public extension Sketch {

    func arc(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat, _ start: CGFloat, _ stop: CGFloat) {
        let cx = x + w * 0.5
        let cy = y + h * 0.5
        let r = w * 0.5

        let t = CGAffineTransform(translationX: cx, y: cy)
        context?.beginPath()
        let path: CGMutablePath = CGMutablePath()
        path.addArc(center: CGPoint(x: x, y: y), radius: r, startAngle: start, endAngle: stop, clockwise: false, transform: t)
        context?.addPath(path)
        context?.drawPath(using: .eoFillStroke)
    }

    func ellipse(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat = -1 ) {
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

    func circle(_ x: CGFloat, _ y: CGFloat, _ d: CGFloat) {
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

    func line(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat) {
        context?.move(to: CGPoint(x: x1, y: y1))
        context?.addLine(to: CGPoint(x: x2, y: y2))
        context?.strokePath()
    }

    func point(_ x: CGFloat, _ y: CGFloat) {
        line(x, y, x + strokeWeight, y)
    }

    func rect(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) {
        context?.stroke(CGRect(x: x, y: y, width: w, height: h))
        context?.fill(CGRect(x: x, y: y, width: w, height: h))
    }

    func square(_ x: CGFloat, _ y: CGFloat, _ s: CGFloat) {
        rect(x, y, s, s)
    }

    func triangle(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ x3: CGFloat, _ y3: CGFloat) {
        context?.beginPath()
        context?.move(to: CGPoint(x: x1, y: y1))
        context?.addLine(to: CGPoint(x: x2, y: y2))
        context?.addLine(to: CGPoint(x: x3, y: y3))
        context?.closePath()
        context?.drawPath(using: .eoFillStroke)
    }
}
