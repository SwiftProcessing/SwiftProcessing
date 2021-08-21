/*
 https://github.com/raywenderlich/swift-algorithm-club
 */

import CoreGraphics

public extension Sketch {
    
    struct SketchSettingsStack {
        fileprivate var array = [SketchSettings]()
        
        public var isEmpty: Bool {
            return array.isEmpty
        }
        
        public var count: Int {
            return array.count
        }
        
        public mutating func push(settings: SketchSettings) {
            array.append(settings)
        }
        
        public mutating func pop() -> SketchSettings? {
            if array.count == 0 {
                assertionFailure("Error: invalid call to pop")
            }
            return array.popLast()
        }
        
        public var top: SketchSettings? {
            return array.last
        }
        
        public func printStackSize() {
            print("Stack size is \(array.count)")
        }
    }
    
    struct SketchMatrixStack {
        fileprivate var array = [CGAffineTransform]()
        
        public var isEmpty: Bool {
            return array.isEmpty
        }
        
        public var count: Int {
            return array.count
        }
        
        public mutating func push(settings: SketchSettings) {
            array.append(settings)
        }
        
        public mutating func pop() -> SketchSettings? {
            if array.count == 0 {
                assertionFailure("Error: invalid call to pop")
            }
            return array.popLast()
        }
        
        public var top: CGAffineTransform? {
            return array.last
        }
        
        public func printStackSize() {
            print("Stack size is \(array.count)")
        }
    }
    
}
