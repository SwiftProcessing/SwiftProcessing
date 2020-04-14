//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 4/13/20.
//

import Foundation
import UIKit

extension Sketch {
    func initTouch(){
        isMultipleTouchEnabled = true
        touchRecongizer = UIGestureRecognizer()
        addGestureRecognizer(touchRecongizer)
    }
    
    func updateTouches(){
        
        if touchRecongizer.numberOfTouches > touches.count{
            sketchDelegate?.touchStarted?()
        }else if touchRecongizer.numberOfTouches < touches.count{
            sketchDelegate?.touchEnded?()
        }
        
        if touchRecongizer.numberOfTouches == 0{
            touches = []
            return
        }
        
        let newTouches = (0...touchRecongizer.numberOfTouches - 1)
            .map({touchRecongizer.location(ofTouch: $0, in: self)})
            .map({createVector($0.x, $0.y)})
        
        let moveThreshold: CGFloat = 1.0
        if newTouches.count == touches.count{
            var totalDiff: CGFloat = 0
            for (i, oldTouch) in touches.enumerated(){
                totalDiff += oldTouch.dist(newTouches[i])
            }
            if totalDiff > moveThreshold{
                sketchDelegate?.touchMoved?()
            }
        }
        
        touches = newTouches
    }

}
