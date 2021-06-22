import UIKit

public extension Sketch {

    func frameRate() -> Double {
        return fps
    }

    func frameRate(fps: Double) {
        self.fps = fps
        fpsTimer?.preferredFramesPerSecond = Int(fps)
    }
    
    func frameRate(fps: CGFloat) {
        frameRate(fps: Double(fps))
    }
}
