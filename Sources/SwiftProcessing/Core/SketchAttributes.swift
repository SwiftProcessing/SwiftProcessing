import Foundation
import UIKit

public extension Sketch {
    func strokeWeight(_ weight: CGFloat) {
        context?.setLineWidth(weight)
        settings.strokeWeight = weight
    }

    func smooth() {
        context?.setShouldAntialias(true)
    }

    func noSmooth() {
        context?.setShouldAntialias(false)
    }

    func ellipseMode(_ eMode: String) {
        settings.ellipseMode = eMode
    }
}
