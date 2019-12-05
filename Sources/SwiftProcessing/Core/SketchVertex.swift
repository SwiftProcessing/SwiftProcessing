
import UIKit

public extension Sketch{
    
    func beginShape() {
        context!.beginPath()
    }
    
    func endShape(_ mode: String = "open"){
        if mode == CLOSE{
            context!.closePath()
        }
        context!.drawPath(using: .fillStroke)
        context!.strokePath()
        context!.fillPath()
    }
    
    func vertex(_ x: CGFloat, _ y: CGFloat){
        if context!.isPathEmpty{
            context?.move(to: CGPoint(x: x, y: y))
        }else{
            context?.addLine(to: CGPoint(x: x, y: y))
        }
    }
}
