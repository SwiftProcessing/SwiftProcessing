/*
 * SwiftProcessing: Sketch Settings
 *
 * SwiftProcessing and Apple's Core Graphics both have push and pop
 * functions that overlap somewhat, but SwiftProcessing includes many
 * other things. For this reason it's necessary to create this
 * structure. Care should be made to ensure that these settings are
 * in sync with their Core Graphics counterparts within the context.
 *
 * This struct only contains the settings which Core Graphics lacks
 * or where the defaults deviate from SwiftProcessing's desired
 * defaults.
 *
 * */

import UIKit

public extension Sketch{

    struct SketchSettings {
        // Source: https://processing.org/reference/push_.html
        // push() stores information related to the current transformation state and style settings controlled by the following functions: rotate(), translate(), scale(), fill(), stroke(), tint(), strokeWeight(), strokeCap(), strokeJoin(), imageMode(), rectMode(), ellipseMode(), colorMode(), textAlign(), textFont(), textMode(), textSize(), textLeading().
        // The source code has a more comprehensive list of states.
        
        var colorMode = Default.colorMode
        var fill = Default.fill
        var stroke = Default.stroke
        var tint = Default.tint
        var strokeWeight = Default.strokeWeight
        var strokeJoin = Default.strokeJoin
        var strokeCap = Default.strokeCap
        var rectMode = Default.rectMode
        var ellipseMode = Default.ellipseMode
        var imageMode = Default.imageMode
        var textFont = Default.textFont
        var textSize = Default.textSize
        var textLeading = Default.textLeading
        var textAlign = Default.textAlign
        var textAlignY = Default.textAlignY
        var blendMode = Default.blendMode
        
        var perlinSize = Default.perlinSize
        var perlinOctaves = Default.perlinOctaves
        var perlinFalloff = Default.perlinFalloff
        
        // Re: textMode – A bitmap mode could be done using CTLineDraw from Core Text.
        // Source 1: https://developer.apple.com/documentation/coretext/1511145-ctlinedraw
        // Source 2: https://blog.krzyzanowskim.com/2020/07/13/coretext-swift-academy-part-3/
        
        static func defaultSettings(_ sketch: Sketch) {
            sketch.settings.reapplySettings(sketch)
        }
        
        public func reapplySettings(_ sketch: Sketch) {
            sketch.colorMode(colorMode)
            sketch.fill(fill)
            sketch.stroke(stroke)
            sketch.tint(tint)
            sketch.strokeWeight(strokeWeight)
            sketch.strokeJoin(strokeJoin)
            sketch.strokeCap(strokeCap)
            sketch.rectMode(rectMode)
            sketch.ellipseMode(ellipseMode)
            sketch.imageMode(imageMode)
            sketch.textFont(textFont)
            sketch.textSize(textSize)
            sketch.textLeading(textLeading)
            sketch.textAlign(textAlign)
            // Leaving Perlin settings off for now because they are not really global states that need to be tracked.
        }
        
        public func debugSettings() {
            print("""
            colorMode = \(colorMode)
            fill = \(fill.toString())
            stroke = \(stroke.toString())
            tint = \(tint.toString())
            strokeWeight = \(strokeWeight)
            strokeJoin = \(strokeJoin)
            strokeCap = \(strokeCap)
            rectMode = \(rectMode)
            ellipseMode = \(ellipseMode)
            imageMode = \(imageMode)
            textFont = \(textFont)
            textSize = \(textSize)
            textLeading = \(textLeading)
            textAlign = \(textAlign)
            """
            )
        }
    }
}

// NOTES FOR FUTURE CONTRIBUTORS:

// Core Graphics .saveGState() and .restoreGState() are similar to push and pop.

// Core Graphics .saveGState() pushes all the settings from the current context to the graphics stack. The graphics state parameters that are saved are:

// CTM (current transformation matrix), clip region***, image interpolation quality***, line width, line join, miter limit***, line cap, line dash***, flatness***, should anti-alias***, rendering intent***, fill color space***, stroke color space***, fill color, stroke color, alpha value***, font, font size, character spacing, text drawing mode***, shadow parameters***, the pattern phase***, the font smoothing parameter***, blend mode***

// Source: https://developer.apple.com/documentation/coregraphics/cgcontext/1456156-savegstate

// Processing push() and pop() work similarly, but have a different set of states. The states affected by Processing's push() and pop() are:

// push() stores information related to the current transformation state and style settings controlled by the following functions: rotate(), translate(), scale(), fill(), stroke(), tint()***, strokeWeight(), strokeCap(), strokeJoin(), imageMode()***, rectMode()***, ellipseMode()***, colorMode()***, textAlign()***, textFont(), textMode()***, textSize(), textLeading().

// *** – Inconsistencies.

// NOTE: Reminder that defaults for Apple's Quartz/Core Graphics are inconsistent with Processing's defaults in many situations. State needs to be set up.

// Processing maintains two classes: PStyle and PMatrix

// From Processing source code's PStyle constant:

/*
 public int imageMode;
 public int rectMode;
 public int ellipseMode;
 public int shapeMode;
 
 public int blendMode;
 
 public int colorMode;
 public float colorModeX;
 public float colorModeY;
 public float colorModeZ;
 public float colorModeA;
 
 public boolean tint;
 public int tintColor;
 public boolean fill;
 public int fillColor;
 public boolean stroke;
 public int strokeColor;
 public float strokeWeight;
 public int strokeCap;
 public int strokeJoin;
 */


/*
 *              GRAPHICS STATES ON BOTH PLATFORMS
 *----------------------------------------------------------------
 *      Apple Core Graphics      |          Processing           |
 *----------------------------------------------------------------
 * Current Transformation Matrix | rotate(), translate(), scale()|
 * line width                    | strokeWeight()                |
 * line join                     | strokeJoin()                  |
 * line cap                      | strokeCap()                   |
 * fill color                    | fill()                        |
 * stroke color                  | stroke()                      |
 * font                          | textFont()                    |
 * font size                     | textSize()                    |
 * character spacing             | textLeading()                 |
 * ---------------------------------------------------------------
 *
 *  INCONSISTENT GRAPHICS STATES
 *--------------------------------
 *      Apple Core Graphics      |
 *--------------------------------
 * clip region                   |
 * image interpolation quality   |
 * miter limit                   |
 * line dash                     |
 * flatness                      |
 * should anti-alias             |
 * rendering intent              |
 * fill color space              |
 * stroke color space            |
 * alpha value                   |
 * text drawing mode             |
 * shadow parameters             |
 * the pattern phase             |
 * font smoothing paramters      |
 * blend mode                    |
 *--------------------------------
 *
 *--------------------------------
 *          Processing           |
 *--------------------------------
 * tint()                        |
 * imageMode()                   |
 * rectMode()                    |
 * ellipseMode()                 |
 * colorMode()                   |
 * textAlign()                   |
 * textMode()                    |
 * -------------------------------
 */



