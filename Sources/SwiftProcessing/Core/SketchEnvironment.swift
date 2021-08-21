/*
 * SwiftProcessing: Environment
 *
 * */

import UIKit

public extension Sketch {
    
    func frameRate() -> Double {
        return fps
    }
    
    func frameRate<T: Numeric>(_ fps: T) {
        self.fps = fps.convert()
        fpsTimer?.preferredFramesPerSecond = fps.convert()
    }
}

/*
 LEAVING HERE FOR FUTURE CONTRIBUTORS:
 
 It would be convenient for performance testing to create a getter for a frameRate variable that calculates current frames per second. This is done in the Processing source code like this:
 
 // Calculate frameRate through average frame times, not average fps, e.g.:
 //
 // Alternating 2 ms and 20 ms frames (JavaFX or JOGL sometimes does this)
 // is around 90.91 fps (two frames in 22 ms, one frame 11 ms).
 //
 // However, averaging fps gives us: (500 fps + 50 fps) / 2 = 275 fps.
 // This is because we had 500 fps for 2 ms and 50 fps for 20 ms, but we
 // counted them with equal weight.
 //
 // If we average frame times instead, we get the right result:
 // (2 ms + 20 ms) / 2 = 11 ms per frame, which is 1000/11 = 90.91 fps.
 //
 // The counter below uses exponential moving average. To do the
 // calculation, we first convert the accumulated frame rate to average
 // frame time, then calculate the exponential moving average, and then
 // convert the average frame time back to frame rate.
 {
   // Get the frame time of the last frame
   double frameTimeSecs = (now - frameRateLastNanos) / 1e9;
   // Convert average frames per second to average frame time
   double avgFrameTimeSecs = 1.0 / frameRate;
   // Calculate exponential moving average of frame time
   final double alpha = 0.05;
   avgFrameTimeSecs = (1.0 - alpha) * avgFrameTimeSecs + alpha * frameTimeSecs;
   // Convert frame time back to frames per second
   frameRate = (float) (1.0 / avgFrameTimeSecs);
 }
 */
