//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 10/31/19.
//

import UIKit

public extension Sketch{
    
    func rotate(_ angle: CGFloat){
        context?.rotate(by: angle)
    }
    
    func translate(_ x: CGFloat, _ y:CGFloat){
        context?.translateBy(x: x, y: y)
    }
    
    func scale(_ x: CGFloat, _ y:CGFloat){
        context?.scaleBy(x: x, y: y)
    }
}
