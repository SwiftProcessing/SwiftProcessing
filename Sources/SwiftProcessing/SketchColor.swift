//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 10/31/19.
//

import UIKit

public extension Sketch{
    
    func color(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255) -> Color{
        return Color(v1, v2, v3, a)
    }
    
    func background(_ color: Color){
        background(color.red, color.green, color.blue, color.alpha)
    }
    
    func background(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255){
        backgroundColor = UIColor(red: v1 / 255, green: v2 / 255, blue: v3 / 255, alpha: a / 255)
    }
    
    func fill(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255){
        isFill = true
        context?.setFillColor(red: v1, green: v2, blue: v3, alpha: a)
    }
    
    func noFill(){
        isFill = false
    }
    
    func stroke(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255){
        isStroke = true
        context?.setStrokeColor(red: v1, green: v2, blue: v3, alpha: a)
    }
    
    func noStroke(){
        isStroke = false
    }
    
    func red(_ color: Color){
        red(color.toArray())
    }
    
    func red(_ color: [CGFloat]) -> CGFloat{
        return color[0]
    }
}

public class Color{
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
    
    
    init(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ a: CGFloat = 255) {
        self.red = v1
        self.green = v2
        self.blue = v3
        self.alpha = a
    }
    
    func setRed(_ red: CGFloat){
        self.red = red
    }
    
    func setGreen(_ green: CGFloat){
        self.green = green
    }
    
    func setBlue(_ blue: CGFloat){
        self.blue = blue
    }
    
    func setAlpha(_ alpha: CGFloat){
        self.alpha = alpha
    }
    
    func uiColor() -> UIColor{
        return UIColor(red: self.red, green: self.green, blue: self.blue, alpha: self.alpha)
    }
    
    func toString() -> String{
        return "rgba(\(self.red),\(self.green),\(self.blue),\(self.blue))"
    }
    
    func toArray() -> [CGFloat]{
        return [red, green, blue, alpha]
    }
}

