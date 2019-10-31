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
    
    func fill(){
        isFill = true
    }
    
    func noFill(){
        isFill = false
    }
    
    func stroke(){
        isStroke = true
    }
    
    func noStroke(){
        isStroke = false
    }
}
