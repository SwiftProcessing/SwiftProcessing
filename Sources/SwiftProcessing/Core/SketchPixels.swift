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

    // The following strategy is adapted from C4iOS with some modifications.
    // Source: https://github.com/C4Labs/C4iOS/blob/master/C4/UI/Image%2BColorAt.swift
    
    ///  Initializes and returns a new cgimage from the color at a specified point in the receiver.
    ///  ````
    ///  let image = cgimage(at: CGPoint())
    ///  ````
    /// - parameter at: a CGPoint.
    
    private func cgimage(at point: CGPoint) -> CGImage? {
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)

        guard let offscreenContext = CGContext(data: nil, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: bitmapInfo.rawValue) else {
            print("Could not create offscreenContext")
            return nil
        }

        offscreenContext.translateBy(x: CGFloat(-point.x), y: CGFloat(-point.y))

        layer.render(in: offscreenContext)

        guard let image = offscreenContext.makeImage() else {
            print("Could not create pixel image")
            return nil
        }
        return image
    }
    
    ///  Initializes and returns a new Color from an x and y coordinate.
    ///  ````
    ///  let color = img.color(at: Point())
    ///  ````
    /// - parameter x: x-position.
    /// - parameter y: y-position.
    
    func get<X: Numeric, Y: Numeric>(_ x: X, _ y: Y) -> Color {
        
        var cg_x, cg_y: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        
        var point = CGPoint(x: cg_x, y: cg_y)
        
        guard bounds.contains(point) else {
            // print("Point is outside the image bounds")
            return Color(0, 0 ,0)
        }

        guard let pixelImage = cgimage(at: point) else {
            // print("Could not create pixel Image from CGImage")
            return Color(0, 0 ,0)
        }

        let imageProvider = pixelImage.dataProvider
        let imageData = imageProvider?.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(imageData)

        return Color(data[1],
                     data[2],
                     data[3],
                     data[0])
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
        image = image?.cropping(to: CGRect(x: cg_x * CGFloat(self.scale.x) * screenScale, y: cg_y * CGFloat(self.scale.y) * screenScale, width: cg_w * CGFloat(self.scale.x) * screenScale, height: cg_h * CGFloat(self.scale.y) * screenScale))
        return Image(UIImage(cgImage: image!))
    }

//    func getPixels<T: Numeric>(_ x: T, _ y: T) -> Image {
//        getPixels(x, y, self.width as! T, self.height as! T)
//    }

}
