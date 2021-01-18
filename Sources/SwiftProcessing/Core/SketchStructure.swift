import UIKit

public extension Sketch {

    func loop() {
        if #available(iOS 10.0, *) {
           
            fpsTimer = CADisplayLink(target: self,
                                            selector: #selector(nextFrame))
            fpsTimer?.preferredFramesPerSecond = Int(fps)
            fpsTimer!.add(to: .main,
                            forMode: RunLoop.Mode.default)
            fpsTimer!.add(to: .main,
                            forMode: RunLoop.Mode.tracking)
        } else {
            // Fallback on earlier versions
        }
    }
    @objc func nextFrame(displaylink: CADisplayLink) {
        self.setNeedsDisplay()
    }
    func noLoop() {
        fpsTimer!.invalidate()
    }

    func redraw() {
        self.setNeedsDisplay()
    }
}
