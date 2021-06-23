/*
 * SwiftProcessing: Random
 *
 * */

import Foundation
import UIKit

public extension Sketch {
    func random(_ low: CGFloat = 0, _ high: CGFloat = 1) -> CGFloat {
        return CGFloat.random(in: low...high)
    }
    
    func random(_ low: Double = 0, _ high: Double = 1) -> Double {
        return Double.random(in: low...high)
    }
    
    func random(_ high: CGFloat = 1) -> CGFloat {
        return CGFloat.random(in: 0.0...high)
    }
    
    func random(_ high: Double = 1) -> Double {
        return Double.random(in: 0.0...high)
    }
}

