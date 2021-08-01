/*
 * SwiftProcessing: Attributes
 *
 * */

import Foundation
import UIKit

/// Atributes used for drawing
public protocol Attributes {
    
    /// Sets the width of the stroke used for lines, points and the border around shapes.
    /// - Parameter weight: the weight of the stroke
    func strokeWeight<W: Numeric>(_ weight: W)
    
    /// Draws all geometry with smooth (anti-aliased) edges
    func smooth()
    
    /// Draws all geometry with jagged (aliased) edges
    func noSmooth()
    
    /// Modifies the location from which ellipses, circles, and arcs are drawn. The default mode is CENTER.
    /// - Parameter eMode: either CENTER, RADIUS, CORNER, or CORNERS
    func ellipseMode(_ eMode: String)
    
    /// Modifies the location from which rectangles are drawn. The default mode is CORNER.
    /// - Parameter eMode: either CENTER, RADIUS, CORNER, or CORNERS
    func rectMode(_ rMode: String)
    
    /// Modifies the location from which images are drawn. The default mode is CORNER.
    /// - Parameter eMode: either CENTER, RADIUS, CORNER, or CORNERS
    func imageMode(_ iMode: String)
}

extension Sketch: Attributes {
    public func strokeWeight<T: Numeric>(_ weight: T) {
        context?.setLineWidth(weight.convert())
        settings.strokeWeight = weight.convert()
    }
    
    public func smooth() {
        context?.setShouldAntialias(true)
    }

    public func noSmooth() {
        context?.setShouldAntialias(false)
    }

    public func ellipseMode(_ mode: String) {
        settings.ellipseMode = mode
    }
    
    public func rectMode(_ mode: String) {
        settings.rectMode = mode
    }
    
    public func imageMode(_ mode: String) {
        settings.imageMode = mode
    }
}
