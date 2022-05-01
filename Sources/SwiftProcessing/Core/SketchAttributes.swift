/*
 * SwiftProcessing: Attributes
 *
 * */

import Foundation
import UIKit

/// Atributes used for drawing
public protocol Attributes: Sketch {
    
    /// Sets the width of the stroke used for lines, points and the border around shapes.
    /// - Parameter weight: the weight of the stroke
    func strokeWeight<W: Numeric>(_ weight: W)
    
    /// Sets how the ends of strokes will behave at their endpoints. `.square` cuts the the line off squarely directly at the endpoint.
    /// - Parameter cap: `.round` rounds the end as if you were to draw a circle with a diameter the size of the `strokeWeight`. `.project` is similar to `.round` except it's as if you draw a square with a centerpoint of your endpoint outward the size of the `strokeWeight`.
    func strokeCap(_ cap: StrokeCap)
    
    /// Sets the way that strokes are joined at each point when the `strokeWeight` is large.
    /// - Parameter join: `.miter` creates an angular joint. `.bevel` bevels off the point using a straight edge`.round` rounds each corner.
    func strokeJoin(_ join: StrokeJoin)
    
    /// Draws all geometry with smooth (anti-aliased) edges
    func smooth()
    
    /// Draws all geometry with jagged (aliased) edges
    func noSmooth()
    
    /// Modifies the location from which ellipses are drawn by changing the way in which parameters given to `ellipse()` are interpreted.
    /// The default mode is `ellipseMode(.center)`, which interprets the first two parameters of `ellipse()` as the shape's center point, while the third and fourth parameters are its width and height.
    /// `ellipseMode(.radius)` also uses the first two parameters of `ellipse()` as the shape's center point, but uses the third and fourth parameters to specify half of the shape's width and height.
    /// `ellipseMode(.corner)` interprets the first two parameters of `ellipse()` as the upper-left corner of the shape, while the third and fourth parameters are its width and height.
    /// `ellipseMode(.corners)` interprets the first two parameters of `ellipse()` as the location of one corner of the ellipse's bounding box, and the third and fourth parameters as the location of the opposite corner.
    /// - Parameter eMode: either `.center`, `.radius`, `.corner`, or `.corners`
    func ellipseMode(_ eMode: ShapeMode)
    
    /// Modifies the location from which rectangles are drawn by changing the way in which parameters given to `rect()` are interpreted.
    /// The default mode is `rectMode(.corner)`, which interprets the first two parameters of `rect()` as the upper-left corner of the shape, while the third and fourth parameters are its width and height.
    /// `rectMode(.corners)` interprets the first two parameters of `rect()` as the location of one corner, and the third and fourth parameters as the location of the opposite corner.
    /// `rectMode(.center)` interprets the first two parameters of `rect()` as the shape's center point, while the third and fourth parameters are its width and height.
    /// `rectMode(.radius)` also uses the first two parameters of `rect()` as the shape's center point, but uses the third and fourth parameters to specify half of the shape's width and height.
    /// - Parameter eMode: either `.center`, `.radius`, `.corner`, or `.corners`
    func rectMode(_ rMode: ShapeMode)
    
    /// Modifies the location from which images are drawn by changing the way in which parameters given to `image()` are interpreted.
    /// The default mode is `imageMode(.corner)`, which interprets the second and third parameters of `image()` as the upper-left corner of the image. If two additional parameters are specified, they are used to set the image's width and height.
    /// `imageMode(.corners)` interprets the second and third parameters of image() as the location of one corner, and the fourth and fifth parameters as the opposite corner.
    /// `imageMode(.center)` interprets the second and third parameters of image() as the image's center point. If two additional parameters are specified, they are used to set the image's width and height.
    /// - Parameter eMode: either `.center`, `.radius`, `.corner`, or `.corners`
    func imageMode(_ iMode: ImageMode)
}

extension Sketch: Attributes {
    public func strokeWeight<T: Numeric>(_ weight: T) {
        context?.setLineWidth(weight.convert())
        settings.strokeWeight = weight.convert()
    }
    
    public func strokeJoin(_ join: StrokeJoin) {
        switch join {
        case .miter:
            context?.setLineJoin(.miter)
        case .bevel:
            context?.setLineJoin(.bevel)
        case .round:
            context?.setLineJoin(.round)
        }
        settings.strokeJoin = join
    }
    
    // It should be noted that Apple's definition of these terms is inconsistent with Processing's. Here's a guide:
    /*
     Processing <-> Quartz
     ---------------------
     project    <-> square
     round      <-> round
     square     <-> butt
     */
    
    public func strokeCap(_ cap: StrokeCap) {
        switch cap {
        case .project:
            context?.setLineCap(.square) // See note above.
        case .round:
            context?.setLineCap(.round)
        case .square:
            context?.setLineCap(.butt) // See note above.
        }
        settings.strokeCap = cap
    }
    
    public func smooth() {
        context?.setShouldAntialias(true)
    }

    public func noSmooth() {
        context?.setShouldAntialias(false)
    }

    public func ellipseMode(_ mode: ShapeMode) {
        settings.ellipseMode = mode
    }
    
    public func rectMode(_ mode: ShapeMode) {
        settings.rectMode = mode
    }
    
    public func imageMode(_ mode: ImageMode) {
        settings.imageMode = mode
    }
}
