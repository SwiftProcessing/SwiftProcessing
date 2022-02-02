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
    
    /// Returns the current day as a value from 1 - 31.
    /// ```
    /// func draw() {
    ///   print(day())
    /// }
    /// ```
    
    public func day() -> Int {
        let dateNow = Date()
        let components = Calendar.current.dateComponents([.day], from: dateNow)
        return components.day ?? 0
    }
    
    /// Returns the current hour as a value from 0 - 23.
    /// ```
    /// func draw() {
    ///   print(hour())
    /// }
    /// ```
    
    public func hour() -> Int {
        let dateNow = Date()
        let components = Calendar.current.dateComponents([.hour], from: dateNow)
        return components.hour ?? 0
    }
    
    /// Returns the current minute as a value from 0 - 59.
    /// ```
    /// func draw() {
    ///   print(minute())
    /// }
    /// ```
    
    public func minute() -> Int {
        let dateNow = Date()
        let components = Calendar.current.dateComponents([.minute], from: dateNow)
        return components.minute ?? 0
    }
    
    /// Returns the current month as a value from 1 - 12.
    /// ```
    /// func draw() {
    ///   print(month())
    /// }
    /// ```
    
    public func month() -> Int {
        let dateNow = Date()
        let components = Calendar.current.dateComponents([.month], from: dateNow)
        return components.month ?? 0
    }
    
    /// Returns the current second as a value from 0 - 59.
    /// ```
    /// func draw() {
    ///   print(second())
    /// }
    /// ```
    
    public func second() -> Int {
        let dateNow = Date()
        let components = Calendar.current.dateComponents([.second], from: dateNow)
        return components.second ?? 0
    }
    
    /// Returns the current year as an integer (2003, 2004, 2005, etc).
    /// ```
    /// func draw() {
    ///   print(year())
    /// }
    /// ```
    
    public func year() -> Int {
        let dateNow = Date()
        let components = Calendar.current.dateComponents([.year], from: dateNow)
        return components.year ?? 0
    }
    
}
