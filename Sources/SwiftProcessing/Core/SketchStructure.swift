import UIKit

public extension Sketch {

    func loop() {
        if #available(iOS 10.0, *) {
            fpsTimer = Timer(timeInterval: Double(1.0 / self.fps), repeats: true, block: {  _ in
                self.setNeedsDisplay()
            })
            RunLoop.main.add(fpsTimer!, forMode: RunLoop.Mode.common)
        } else {
            // Fallback on earlier versions
        }
    }

    func noLoop() {
        fpsTimer!.invalidate()
    }

    func redraw() {
        self.setNeedsDisplay()
    }
}
