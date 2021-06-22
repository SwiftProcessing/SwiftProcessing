import UIKit

public extension Sketch {
    
    var translation: Vector{
        get{
            let translationX = context == nil ? 0 : (context?.ctm.tx)! / UIScreen.main.scale
            let translationY = context == nil ? 0 :  -(context?.ctm.ty)! / UIScreen.main.scale + frame.height
            return createVector(translationX, translationY)
        }
    }
    
    var scale: Vector{
        get{
            let scaleX = context == nil ? 1 : (context?.ctm.a)! / UIScreen.main.scale
            let scaleY = context == nil ? 1 :  -(context?.ctm.d)! / UIScreen.main.scale
            return createVector(scaleX, scaleY)
        }
    }
    
    func rotate(_ angle: CGFloat) {
        context?.rotate(by: angle)
    }
    
    func rotate(_ angle: Double) {
        rotate(CGFloat(angle))
    }
    
    func translate(_ x: CGFloat, _ y: CGFloat) {
        context?.translateBy(x: x, y: y)
    }
    
    func translate(_ x: Double, _ y: Double) {
        translate(CGFloat(x), CGFloat(y))
    }
    
    func scale(_ x: CGFloat, _ y: CGFloat) {
        context?.scaleBy(x: x, y: y)
    }
    
    func scale(_ x: Double, _ y: Double) {
        scale(CGFloat(x), CGFloat(y))
    }
}
