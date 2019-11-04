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
    
    var isFill: Bool = true
    var fillColor: Color
    var isStroke: Bool = true
    var strokeColor: Color
    var strokeWeight: CGFloat = 1
    var isErase: Bool = false
    var rotate: CGFloat = 0
    
    var textSize: CGFloat = 32
    
    init() {
        fillColor = Color(0, 0, 0)
        strokeColor = Color(0, 0, 0)
    }
    mutating func setStrokeWeight(_ weight: CGFloat){
        self.strokeWeight = weight
    }
    func restore(sketch: Sketch){
        if (isFill){
            sketch.fill(fillColor)
        }
            
        if (isStroke){
            sketch.stroke(strokeColor)
        }
        sketch.strokeWeight(strokeWeight)
        
        if (isErase){
            sketch.erase()
        }
        
        sketch.rotate(rotate)
        
        sketch.textSize(textSize)
    }
}
