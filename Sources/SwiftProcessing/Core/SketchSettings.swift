import UIKit

public struct SketchSettings{
//   Stores properties
//    fill(), noFill(), noStroke(), stroke(), tint(), noTint(), strokeWeight(), strokeCap(), strokeJoin(), imageMode(), rectMode(), ellipseMode(), colorMode(), textAlign(), textFont(), textSize(), textLeading(), applyMatrix(), resetMatrix(), rotate(), scale(), shearX(), shearY(), translate(), noiseSeed().
    
    var textSize: CGFloat = 32
    var textFont: String = "HelveticaNeue-Thin"
    var ellipseMode: String = "CENTER"
    var fill: Color = Color(255, 255, 255)
    var stroke: Color = Color(0, 0, 0)
    var strokeWeight: CGFloat = 1
   
    func restore(sketch: Sketch){
        sketch.textSize(textSize)
        sketch.textFont(textFont)
        sketch.ellipseMode(ellipseMode)
        sketch.fill(fill)
        sketch.stroke(stroke)
        sketch.strokeWeight(strokeWeight)
    }
}
