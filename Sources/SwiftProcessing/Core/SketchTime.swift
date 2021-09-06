/*
 * SwiftProcessing: Structure
 *
 * This is where the draw loop is structured using CADisplayLink.
 * This is also where beginDraw() and endDraw() are called.
 *
 * */

import Foundation
import SceneKit

extension Sketch {
    
    func updateTimes() {
        frameCount =  frameCount + 1
        let newTime = CACurrentMediaTime()
        deltaTime = newTime - lastTime
        lastTime = newTime
    }
    
    /// Returns the number of milliseconds since the sketch began running.
    /// ```
    /// func draw() {
    ///   print(millis())
    /// }
    /// ```
    
    public func millis() -> Int {
        return Int(Date().timeIntervalSince1970 * 1000 - millsOffset)
    }
    
    // FOR FUTURE CONTRIBUTORS
    
    // Processing has many Time & Date functions. These return the date formatted in different ways. The functions would be easy to implement. They are day(), hour(), minute(), month(), second(), and year().
    
    // The Date and Calender classes are the best places to start.
    
    // Resources: https://coderwall.com/p/b8pz5q/swift-4-current-year-mont-day
    // https://developer.apple.com/documentation/foundation/date
    // https://developer.apple.com/documentation/foundation/calendar
    
}
