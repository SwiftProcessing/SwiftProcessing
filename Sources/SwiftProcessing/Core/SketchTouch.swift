/*
 * SwiftProcessing: Touch
 *
 * */

import Foundation
import UIKit

extension Sketch: UIGestureRecognizerDelegate {
    
    open func touchMode(_ mode: TouchMode) {
        self.touchMode = mode
    }
    
    func initTouch() {
        isMultipleTouchEnabled = true
        touchRecongizer = UIGestureRecognizer()
        touchRecongizer.delegate = self
        touchRecongizer.cancelsTouchesInView = false
        addGestureRecognizer(touchRecongizer)
    }
    
    // This helps distinguish between touches on the sketch and ui elements.
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touchMode == .sketch {
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
        
        var newTouches = (0...touchRecongizer.numberOfTouches - 1)
            .map({touchRecongizer.location(ofTouch: $0, in: self)})
            .map({createVector($0.x, $0.y)})
        
        print(newTouches)
        
        // Step 2: If a touch started, then execute touchStarted(), update touchX and touchY, and add it to the touches array so it's accurately collecting all touches.
        if isTouchStarted {
            let startTouch = touchRecongizer.location(ofTouch: 0, in: self)
            print("touchStarted at \(startTouch)")
            touchX = Double(startTouch.x)
            touchY = Double(startTouch.y)
            let startTouchV = createVector(startTouch.x, startTouch.y)
            touches.insert(startTouchV, at: 0)
            
            sketchDelegate?.touchStarted?()
        }
        
        // Step 3: If the touch is moving, then execute touchMoved()
        let moveThreshold: Double = 1.0
        if newTouches.count == touches.count {
            var totalDiff: Double = 0
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
