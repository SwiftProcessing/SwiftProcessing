/*
 * SwiftProcessing: Enums
 *
 * This deviates from Processing because of a difference
 * in the Java, JavaScript, and Swift design guidelines.
 * Regarding naming conventions for enums and constants.
 * Although it's different, the thought here is to honor
 * Swift's design guidelines while taking advantage of code
 * completion and context-specific suggestions.
 *
 * Strings could also be used, but they are prone to error
 * and don't give new learners access to auto-complete.
 *
 * Source: https://stackoverflow.com/questions/24244326/swift-global-constant-naming-convention
 *
 * */

import Foundation

extension Sketch {
    // Not currently implemented but leaving hear as a placeholder for future contributors.
    // Reference: https://p5js.org/reference/#/p5/angleMode
    
    /*
    public enum AngleMode {
        case degrees
        case radians
    }
    */
    
    /// The `ShapeMode` enum affects how the shape parameters are used when they are drawn to the screen. `.corner` interprets the first two parameters as the x and y position of the shape. The third and fourth parameters are the width and height of the shape. `.corners` interprets the first two parameters as the upper left- hand corner and the third and fourth parameters as the lower right-hand corner. `.center` interprets the first two parameters as the center of the shape and the third and fourth parameters as the width and height. `.radius` interprets the first two parameters as the center of the shape and the third and fourth half of the width and height of the shape.
    
    public enum ShapeMode {
        case radius
        case corner
        case corners
        case center
    }
    
    /// The `ArcMode` enum determins how arcs are drawn. `.open` will only draw the exterior of the arc and fill whatever shpae remains. The space between the endpoints will not be stroked. `.chord` is the same as `.open` but will stroke the distance between the two endpoints. `.pie` will treat our arc like a pie and stroke the exterior of the arc as well as from each endpoint to the center.
    
    public enum ArcMode {
        case pie
        case chord
        case open
    }
    
    /// The `ShapePath` enum specifies whether a vertex shape should be open (`.open`) or closed (`.close`). An open shape does not add a line connecting the first and last points. A closed shape forms a loop, connecting the first and last point.

    public enum ShapePath {
        case open
        case close
    }
    
    /// The `VertexMode` enum specifies the type of curve being created. `.normal` creates a hard-edged polygon. `.curve` creates a Catmull-Rom spline. This is a type of curve that conforms to the points given, i.e. the points you supply will be on the curve itself and the curve will be calculated to automatically conform to your points. `.bezier` creates  Bezier curve, which is a curve commonly used in computer graphics. SwiftProcessing uses cubic Bezier curves, in which each point supplied also has an additional control point. The angle of the control point in relation to the curve point is what determines the curvature.

    public enum VertexMode {
        case normal
        case curve
        case bezier
    }
    
    /// The `StrokeJoin` enum specifies the way that strokes are joined at each point when the `strokeWeight` is large. `.miter` creates an angular joint. `.bevel` bevels off the point using a straight edge`.round` rounds each corner.
    
    public enum StrokeJoin {
        case miter
        case bevel
        case round
    }
    
    /// The `StrokeCap` enum specifies how the ends of strokes will behave at their endpoints. `.square` cuts the the line off squarely directly at the endpoint. `.round` rounds the end as if you were to draw a circle with a diameter the size of the `strokeWeight`. `.project` is similar to `.round` except it's as if you draw a square with a centerpoint of your endpoint outward the size of the `strokeWeight`.
    
    public enum StrokeCap {
        case square
        case project
        case round
    }

    public enum Filter {
        case pixellate
        case hue_rotate
        case sepia_tone
        case tonal
        case monochrome
        case invert
    }

    /// The `Alignment` enum specifies the alignment for common procedures that require alignments like the `textAlign()` function. Common alignments are used like `.left`, `.center`, and `.right`.
    
    public enum Alignment {
        case left
        case right
        case center
    }
    
    /// The `AlignmentY` enum specifies the vertical alignment for common procedures that require alignments like the optional second parameter of the `textAlign()` function. Common alignments are used like `.top`, `.bottom`, and `.baseline`.
    
    public enum AlignmentY {
        case top
        case bottom
        case baseline
    }

    
    /// The `CameraPosition` enum specifies whether you would like to use the front (`.front`) or back (`.back`) camera.
    
    public enum CameraPosition {
        case front
        case back
    }
    
    /// The `ImageQuality` enum specifies the image quality of images captured with SwiftProcessing.
    
    public enum ImageQuality {
        case high
        case medium
        case low
        case vga
        case hd
        case qhd
    }
    
    public enum VideoOrientation {
        case up
        case upsidedown
    }
    
    /// The `ImagePickerType` enum specifies the type of image picker you'd like to use when importing images into SwiftProcessing.
    
    public enum ImagePickerType {
        case camera
        case photo_library
        case camera_roll
    }

    public enum TouchMode {
        case sketch
        case all
    }
    
    /*
     * MARK: - COLOR MODE
     */

    // NOTE: Consider putting all SwiftProcessing enums in a separate .swift file.

    public enum ColorMode {
        case rgb
        case hsb
    }

}

// NOTE TO FUTURE CONTRIBUTORS: Leaving this out here because of a quirk with how Label was created. Might be a quick fix. Should really be up with the other enums. This was created to accommodate UIKit's text alignment, which is different from Core Graphics' alignment options.

public enum TextAlignment {
    case natural
    case left
    case center
    case right
    case justified
}
