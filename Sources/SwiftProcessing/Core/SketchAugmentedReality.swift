import Foundation
import UIKit

public extension Sketch {
    func faceMode() {
        self.isFaceMode = true
    }
    func appMode() {
        self.isFaceMode = false
    }
    func faceFill() {
        self.isFaceFill = true
    }
    func noFaceFill() {
        self.isFaceFill = false
    }

}
