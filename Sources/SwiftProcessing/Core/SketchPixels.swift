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
        image(curImage, 0, 0, self.width, self.height)
    }

    func loadPixels() {
        var i = get()
        i.loadPixels()
        self.pixels = i.pixels
    }

    func get() -> Image {
        get(0, 0, self.width, self.height)
    }

    func get(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) -> Image {
        var image = context!.makeImage()
        image = image?.cropping(to: CGRect(x: x, y: y, width: w, height: h))
        return Image(UIImage(cgImage: image!))
    }

    func get(_ x: CGFloat, _ y: CGFloat) -> Image {
        get(x, y, self.width, self.height)
    }

}
