//
//  SketchTouch.swift
//  
//
//  Created by Jonathan Kaufman on 4/13/20.
//

import Foundation
import UIKit

extension Sketch: UIGestureRecognizerDelegate {
    
    open func touchMode(_ mode: String) {
        self.touchMode = mode
    }
    
    func initTouch() {
        isMultipleTouchEnabled = true
        touchRecongizer = UIGestureRecognizer()
        touchRecongizer.delegate = self
        touchRecongizer.cancelsTouchesInView = false
        addGestureRecognizer(touchRecongizer)
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touchMode == SELF {
            return touch.view == gestureRecognizer.view
        } else if (touch.view as? UIControl) != nil {
            return false
        } else {
            return true
        }
    }
    
    func updateTouches(){
        var isTouchStarted: Bool = false
        var isTouchEnded: Bool = false
        touchRecongizer.cancelsTouchesInView = false
        
        print("touchRecongizer.numberOfTouches: \(touchRecongizer.numberOfTouches)")
        print("touches.count: \(touches.count)")
        
        if touchRecongizer.numberOfTouches > touches.count {
            isTouchStarted = true
        }
        
        if touchRecongizer.numberOfTouches < touches.count {
            isTouchEnded = true
        }
        
        // Step 1: Let's check if the touch has ended,
        // because if it's ended, we can just stop here.
        if isTouchEnded {
            sketchDelegate?.touchEnded?()
        }
        
        if touchRecongizer.numberOfTouches == 0 {
            touches = []
            touched = false
            return // This cuts out of the function.
        }
        
        let newTouches = (0...touchRecongizer.numberOfTouches - 1)
            .map({touchRecongizer.location(ofTouch: $0, in: self)})
            .map({createVector($0.x, $0.y)})
        
        // Step 2: If a touch started, then execute touchStarted()
        if isTouchStarted {
            sketchDelegate?.touchStarted?()
        }
        
        // Step 3: If the touch is moving, then execute touchMoved()
        let moveThreshold: CGFloat = 1.0
        if newTouches.count == touches.count {
            var totalDiff: CGFloat = 0
            for (i, oldTouch) in touches.enumerated() {
                totalDiff += oldTouch.dist(newTouches[i])
            }
            if totalDiff > moveThreshold{
                sketchDelegate?.touchMoved?()
            }
        }
        
        touches = newTouches
        
        touched =  touches.count > 0
        if let t = touches.first {
            touchX = Double(t.x)
            touchY = Double(t.y)
        }
    }
    
}
