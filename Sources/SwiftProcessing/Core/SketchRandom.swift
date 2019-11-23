import Foundation
import UIKit

public extension Sketch{
    func random(_ start: CGFloat = 0, _ end: CGFloat = 1) -> CGFloat{
        return CGFloat.random(in: start...end)
    }
}
