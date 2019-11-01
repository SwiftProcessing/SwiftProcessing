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
}
