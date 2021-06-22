import Foundation
import UIKit

//currently broken
@available(iOS 10.0, *)
public extension Sketch {

    func updatePixels(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) {
        let curImage = Image(UIImage(cgImage: context!.makeImage()!))
        curImage.loadPixels()
        curImage.pixels = self.pixels
        curImage.updatePixels(x, y, w, h)
        curImage.loadPixels()
        image(curImage, 0, 0, CGFloat(self.width), CGFloat(self.height))
    }

    func loadPixels() {
        var i = get()
        i.loadPixels()
        self.pixels = i.pixels
    }

    func get() -> Image {
        get(0, 0, CGFloat(self.width), CGFloat(self.height))
    }

    func get(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) -> Image {
        var image = context!.makeImage()
        var screenScale = UIScreen.main.scale
        image = image?.cropping(to: CGRect(x: x * self.scale.x * screenScale, y: y * self.scale.y * screenScale, width: w * self.scale.x * screenScale, height: h * self.scale.y * screenScale))
        return Image(UIImage(cgImage: image!))
    }

    func get(_ x: CGFloat, _ y: CGFloat) -> Image {
        get(x, y, CGFloat(self.width), CGFloat(self.height))
    }

}
