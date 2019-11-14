//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 11/2/19.
//

import UIKit

public struct SketchSettings{
//   Stores properties
//    fill(), noFill(), noStroke(), stroke(), tint(), noTint(), strokeWeight(), strokeCap(), strokeJoin(), imageMode(), rectMode(), ellipseMode(), colorMode(), textAlign(), textFont(), textSize(), textLeading(), applyMatrix(), resetMatrix(), rotate(), scale(), shearX(), shearY(), translate(), noiseSeed().
    
    var textSize: CGFloat = 32
    var textFont: String = "HelveticaNeue-Thin"
    var ellipseMode: String = "CENTER"
   
    func restore(sketch: Sketch){
        sketch.textSize(textSize)
        sketch.textFont(textFont)
        sketch.ellipseMode(ellipseMode)
    }
}
