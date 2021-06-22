import Foundation
import UIKit

/// Atributes used for drawing
public protocol Attributes {
    
    /// Sets the width of the stroke used for lines, points and the border around shapes.
    /// - Parameter weight: the weight of the stroke
    func strokeWeight(_ weight: CGFloat)
    
    /// Draws all geometry with smooth (anti-aliased) edges
    func smooth()
    
    /// Draws all geometry with jagged (aliased) edges
    func noSmooth()
    
    /// Modifies the location from which ellipses, circles, and arcs are drawn. The default mode is CENTER.
    /// - Parameter eMode: either CENTER, RADIUS, CORNER, or CORNERS
    func ellipseMode(_ eMode: String)
}

extension Sketch: Attributes {
    public func strokeWeight(_ weight: CGFloat) {
        context?.setLineWidth(weight)
        settings.strokeWeight = Double(weight)
    }

    public func strokeWeight(_ weight: Double) {
        strokeWeight(CGFloat(weight))
    }
    
    public func smooth() {
        context?.setShouldAntialias(true)
    }

    public func noSmooth() {
        context?.setShouldAntialias(false)
    }

    public func ellipseMode(_ eMode: String) {
        settings.ellipseMode = eMode
    }
}
