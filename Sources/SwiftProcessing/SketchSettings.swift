//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 10/31/19.
//

import UIKit

public extension Sketch{
    
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
}
