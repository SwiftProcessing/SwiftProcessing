/*
 * SwiftProcessing: Structure
 *
 * This is where the draw loop is structured using CADisplayLink.
 * This is also where beginDraw() and endDraw() are called.
 *
 * */

import UIKit

public extension Sketch {
    
    /// Tells to SwiftProcessing to loop the draw cycle at the frame rate (default is 60).
    
    func loop() {
        beginDraw()
        if #available(iOS 10.0, *) {
            
            fpsTimer = CADisplayLink(target: self,
                                     selector: #selector(nextFrame))
            fpsTimer?.preferredFramesPerSecond = Int(fps)
            fpsTimer!.add(to: .main, forMode: RunLoop.Mode.default)
            fpsTimer!.add(to: .main, forMode: RunLoop.Mode.tracking)
        } else {
            // Note for future contributors:
            // Unimplemented for earlier versions.
        }
    }
    
    @objc func nextFrame(displaylink: CADisplayLink) {
        self.setNeedsDisplay()
    }
    
    /// Tells SwiftProcessing not to loop. Can be used to stop looping at any time in branching logic.
    
    func noLoop() {
        fpsTimer!.invalidate()
        // Clean up stack. At this point the stack size should be 0.
        endDraw()
    }
    
    /// Notifies the graphics context that a change has been made and that the screen needs to be refreshed.
    
    func redraw() {
        self.setNeedsDisplay()
    }
}
