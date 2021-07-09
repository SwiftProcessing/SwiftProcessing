import UIKit

public extension Sketch {

    func frameRate() -> Double {
        return fps
    }

    func frameRate<T: Numeric>(fps: T) {
        self.fps = fps.convert()
        fpsTimer?.preferredFramesPerSecond = fps.convert()
    }
}
