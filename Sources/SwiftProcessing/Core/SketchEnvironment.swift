import UIKit

public extension Sketch {

    func frameRate() -> CGFloat {
        return fps
    }

    func frameRate(fps: CGFloat) {
        self.fps = fps
    }
}
