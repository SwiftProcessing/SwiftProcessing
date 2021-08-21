/*
 * SwiftProcessing: Sketch Stacks
 *
 * These two stack structs are used to store SwiftProcessing's
 * style and matrix settings. Decoupling the style and matrix
 * settings helps separate internal and external push and pop
 * operations. It also helps us maintain state between Apple's
 * Quartz/Core Graphics framework and Processing's own graphics
 * state.
 *
 * */

/*
 https://github.com/raywenderlich/swift-algorithm-club
 */

import CoreGraphics

public extension Sketch {
    
    struct SketchSettingsStack {
        fileprivate var array = [SketchSettings]()
        
        var isEmpty: Bool {
            return array.isEmpty
        }
        
        var count: Int {
            return array.count
        }
        
        mutating func push(settings: SketchSettings) {
            array.append(settings)
        }
        
        mutating func pop() -> SketchSettings? {
            if array.count == 0 {
                assertionFailure("Error: invalid call to pop")
            }
            return array.popLast()
        }
        
        var top: SketchSettings? {
            return array.last
        }
        
        // For debugging.
        func printStackSize() {
            print("Stack size is \(array.count)")
        }
    }
    
    struct SketchMatrixStack {
        fileprivate var array = [CGAffineTransform]()
        
        var isEmpty: Bool {
            return array.isEmpty
        }
        
        var count: Int {
            return array.count
        }
        
        mutating func push(matrix: CGAffineTransform) {
            array.append(matrix)
        }
        
        mutating func pop() -> CGAffineTransform? {
            if array.count == 0 {
                assertionFailure("Error: invalid call to pop")
            }
            return array.popLast()
        }
        
        var top: CGAffineTransform? {
            return array.last
        }
        
        // For debugging.
        func printStackSize() {
            print("Stack size is \(array.count)")
        }
    }
    
}
