
import UIKit

public extension Sketch{
    
    func beginShape() {
        shapePoints = []
    }
    
    func endShape(_ mode: String = "open"){
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 2.0)
        
        let localContext = UIGraphicsGetCurrentContext()!
        localContext.setFillColor(settings.fill.uiColor().cgColor)
        localContext.setStrokeColor(settings.stroke.uiColor().cgColor)
        
        if mode == CLOSE{
            shapePoints.append(shapePoints.first!)
        }
        
        //draw shape
        localContext.beginPath()
        localContext.move(to: shapePoints.first!)
        for p in shapePoints{
            localContext.addLine(to: p)
        }
        localContext.drawPath(using: .fillStroke)
        
        //draw contour as an erase
        localContext.beginPath()
        localContext.setBlendMode(CGBlendMode.clear)
        localContext.move(to: contourPoints.first!)
        for p in contourPoints{
            localContext.addLine(to: p)
        }
        localContext.drawPath(using: .fillStroke)
        
        //stroke contour
        localContext.setBlendMode(CGBlendMode.normal)
        localContext.beginPath()
        localContext.move(to: contourPoints.first!)
        for p in contourPoints{
            localContext.addLine(to: p)
        }
        localContext.strokePath()
        
        //extract image from image context and display it
        let i = Image(UIGraphicsGetImageFromCurrentImageContext()!)
        UIGraphicsEndImageContext()
        image(i, 0, 0)
    }
    
    func beginContour(){
        isContourStarted = true
        contourPoints = []
    }
    
    func endContour(){
        isContourStarted = false
        contourPoints.append(contourPoints.first!)
    }
    
    func vertex(_ x: CGFloat, _ y: CGFloat){
        let point = CGPoint(x: x, y: y)
        
        if isContourStarted{
            contourPoints.append(point)
        }
        else{
            shapePoints.append(point)
        }
    }
}
