//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 11/7/19.
//

import Foundation
import UIKit

public extension Sketch{

//    func abs(_ n: CGFloat) -> CGFloat{
//        return fabs(n)
//    }
    
    func constrain(_ n: CGFloat, _ low: CGFloat, _ high: CGFloat) -> CGFloat{
        return min(max(n, low), high)
    }
    
    func distance(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat) -> CGFloat{
        let distanceSquared = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
        return sqrt(distanceSquared)
    }
    
    func lerp(_ start: CGFloat, _ stop: CGFloat, _ amt: CGFloat) -> CGFloat{
        return start + ((stop - start) * amt)
    }
    
    func mag(_ a: CGFloat, _ b:CGFloat) -> CGFloat{
        return distance(0, 0, a, b)
    }
    
    
}
