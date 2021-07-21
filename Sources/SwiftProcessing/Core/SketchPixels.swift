import Foundation
import UIKit

//currently broken
@available(iOS 10.0, *)
public extension Sketch {

    func updatePixels<T: Numeric>(_ x: T, _ y: T, _ w: T, _ h: T) {
        var cg_x, cg_y, cg_w, cg_h: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        cg_w = w.convert()
        cg_h = h.convert()
        
        let curImage = Image(UIImage(cgImage: context!.makeImage()!))
        curImage.loadPixels()
        curImage.pixels = self.pixels
        curImage.updatePixels(cg_x, cg_y, cg_w, cg_h)
        curImage.loadPixels()
        image(curImage, 0, 0, CGFloat(self.width), CGFloat(self.height))
    }

    func loadPixels() {
        let image = get()
        image.loadPixels()
        self.pixels = image.pixels
    }

    func get() -> Image {
        get(0, 0, CGFloat(self.width), CGFloat(self.height))
    }

    func get<T: Numeric>(_ x: T, _ y: T, _ w: T, _ h: T) -> Image {
        var cg_x, cg_y, cg_w, cg_h: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        cg_w = w.convert()
        cg_h = h.convert()
        
        var image = context!.makeImage()
        let screenScale = UIScreen.main.scale
        image = image?.cropping(to: CGRect(x: cg_x * self.scale.x * screenScale, y: cg_y * self.scale.y * screenScale, width: cg_w * self.scale.x * screenScale, height: cg_h * self.scale.y * screenScale))
        return Image(UIImage(cgImage: image!))
    }

    func get<T: Numeric>(_ x: T, _ y: T) -> Image {
        get(x, y, self.width as! T, self.height as! T)
    }

}
