import Foundation
import UIKit

//currently broken
@available(iOS 10.0, *)
public extension Sketch{
    
    func updatePixels(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat){
        let curImage = Image(UIImage(cgImage: context!.makeImage()!))
        curImage.loadPixels()
        curImage.pixels = self.pixels
        curImage.updatePixels(x, y, w, h)
        curImage.loadPixels()
        image(curImage, 0, 0, self.width, self.height)
    }
    
    func loadPixels(){
        self.pixels = get()
    }
    
    func get() -> [UInt8] {
        get(0, 0, self.width, self.height)
    }
    
    func get(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) ->  [UInt8] {
        let image = Image(UIImage(cgImage: context!.makeImage()!))
        image.loadPixels()
        return image.pixels
    }
    
    func get(_ x: CGFloat, _ y: CGFloat) ->  [UInt8] {
        get(x, y, self.width, self.height)
    }
    
    
}
