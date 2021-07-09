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
    
    func rotate<T: Numeric>(_ angle: T) {
        context?.rotate(by: angle.convert())
    }
    
    func translate<T: Numeric>(_ x: T, _ y: T) {
        context?.translateBy(x: x.convert(), y: y.convert())
    }
    
    func scale<T: Numeric>(_ x: T, _ y: T) {
        context?.scaleBy(x: x.convert(), y: y.convert())
    }
}
