import UIKit

public struct SketchSettings {
//   Stores properties
//    fill(), noFill(), noStroke(), stroke(), tint(), noTint(), strokeWeight(), strokeCap(), strokeJoin(), imageMode(), rectMode(), ellipseMode(), colorMode(), textAlign(), textFont(), textSize(), textLeading(), applyMatrix(), resetMatrix(), rotate(), scale(), shearX(), shearY(), translate(), noiseSeed().

    var textSize: Double = 32
    var textFont: String = "HelveticaNeue-Thin"
    var textAlignment: String = "left"
    var ellipseMode: String = "center"
    var fill: Color = Color(255, 255, 255)
    var stroke: Color = Color(0, 0, 0)
    var strokeWeight: Double = 1

    func restore(sketch: Sketch) {
        sketch.textAlign(textAlignment)
        sketch.textSize(textSize)
        sketch.textFont(textFont)
        sketch.ellipseMode(ellipseMode)
        sketch.fill(fill)
        sketch.stroke(stroke)
        sketch.strokeWeight(CGFloat(strokeWeight))
    }
}
