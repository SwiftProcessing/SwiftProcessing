import Foundation
import UIKit

open class Image {
    open var pixels: [UInt8] = []

    var uiImage: [UIImage]
    var delay: CGFloat = 0
    var curFrame: Int = 0
    var isPlaying = true
    var deltaTime: CGFloat = 0

    var width: CGFloat = 0
    var height: CGFloat = 0
    
    open  var loop: CGFloat = 0
    open var loopMax: CGFloat = -1

    public init(_ image: UIImage) {
        self.width = image.size.width
        self.height = image.size.height
        self.uiImage = image.images != nil ? image.images! : [image]
        self.delay = CGFloat(image.duration) / 100
    }

    open func size() -> CGSize {
        return CGSize(width: self.width, height: self.height)
    }

    open func rawSize() -> CGSize {
        return self.uiImage[curFrame].size
    }

    open func loadPixels() {
        self.pixels = getPixelData()
    }

    func getPixelData() -> [UInt8] {
        let curImage = self.uiImage[curFrame]
        let size = curImage.size
        let dataSize = size.width * size.height * 4
        var pixelData = [UInt8](repeating: 0, count: Int(dataSize))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: &pixelData,
                                width: Int(size.width),
                                height: Int(size.height),
                                bitsPerComponent: 8,
                                bytesPerRow: 4 * Int(size.width),
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        context?.draw(curImage.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        return pixelData
    }

    open func get(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) -> Image {
           UIGraphicsBeginImageContextWithOptions(CGSize(width: w, height: h), false, 2.0)
           let container = CGRect(x: -x, y: -y, width: self.width, height: self.height)
           UIGraphicsGetCurrentContext()!.clip(to: CGRect(x: 0, y: 0,
                                                          width: w, height: h))
           self.uiImage[0].draw(in: container)
           let newImage = Image(UIGraphicsGetImageFromCurrentImageContext()!)
           UIGraphicsEndImageContext()
           return newImage
    }

    @available(iOS 9.0, *)
    open func updatePixels() {
        self.updatePixels(0, 0, uiImage[curFrame].size.width, uiImage[curFrame].size.height)
    }

    @available(iOS 9.0, *)
    open func updatePixels(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) {
        //retrieve the current image and apply the current pixels loaded into the pixels array using the x, y, w, h inputs
        var newImage = getPixelData()
        let curImage = self.uiImage[curFrame]
        let size = curImage.size
        let colorSpace = CGColorSpaceCreateDeviceRGB()

        for dy in Int(y)..<Int(h) {
            for dx in Int(x)..<Int(w) {
                let pixelPos = (dx * 4) + (Int(dy) * 4 * Int(size.width))
                newImage[pixelPos] = self.pixels[pixelPos]
                newImage[pixelPos + 1] = self.pixels[pixelPos + 1]
                newImage[pixelPos + 2] = self.pixels[pixelPos + 2]
                newImage[pixelPos + 3] = self.pixels[pixelPos + 3]
            }
        }

        //create a CGContext and draw the pixels as a CGImage.
        let context = CGContext(data: &newImage,
                                width: Int(size.width),
                                height: Int(size.height),
                                bitsPerComponent: 8,
                                bytesPerRow: 4 * Int(size.width),
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)!
        UIGraphicsPushContext(context)
        //without this clip, the data fails to draw
        context.clip(to: CGRect())
        context.draw(curImage.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))

        //         Make an image from the context and set to current frame
        self.uiImage[curFrame] = UIImage(cgImage: (context.makeImage()!))
        UIGraphicsEndImageContext()
        UIGraphicsPopContext()
    }

    open func resize(_ width: CGFloat, _ height: CGFloat) {
        self.width = width
        self.height = height
    }

    open func copy(_ srcImage: Image, _ sx: CGFloat, _ sy: CGFloat, _ sw: CGFloat, _ sh: CGFloat, _ dx: CGFloat, _ dy: CGFloat, _ dw: CGFloat, _ dh: CGFloat) {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.width, height: self.height), false, 2.0)
        UIGraphicsGetCurrentContext()!.interpolationQuality = .high

        self.uiImage[0].draw(in: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        srcImage.get(sx, sy, sw, sh).uiImage[0].draw(in: CGRect(x: dx, y: dy, width: dw, height: dh), blendMode: .normal, alpha: 1.0)

        //set to self if nothing is found in the image context... possible when bad parameters are passed into this function
        self.uiImage[0] = UIGraphicsGetImageFromCurrentImageContext() ?? self.uiImage[0]
        UIGraphicsEndImageContext()
    }

    open func mask(_ srcImage: Image) {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.width, height: self.height), false, 2.0)
        let context = UIGraphicsGetCurrentContext()!
        //mask strategy adapted from https://stackoverflow.com/questions/8126276/how-to-convert-uiimage-cgimagerefs-alpha-channel-to-mask
        let decode = [ CGFloat(1), CGFloat(0),
                       CGFloat(0), CGFloat(1),
                       CGFloat(0), CGFloat(1),
                       CGFloat(0), CGFloat(1) ]

        let cgImage = srcImage.uiImage[0].cgImage!

        // Create the mask `CGImage` by reusing the existing image data
        // but applying a custom decode array.
        let mask =  CGImage(width: cgImage.width,
                            height: cgImage.height,
                            bitsPerComponent: cgImage.bitsPerComponent,
                            bitsPerPixel: cgImage.bitsPerPixel,
                            bytesPerRow: cgImage.bytesPerRow,
                            space: cgImage.colorSpace!,
                            bitmapInfo: cgImage.bitmapInfo,
                            provider: cgImage.dataProvider!,
                            decode: decode,
                            shouldInterpolate: cgImage.shouldInterpolate,
                            intent: cgImage.renderingIntent)

        context.saveGState()
        context.translateBy(x: 0.0, y: self.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.clip(to: CGRect(x: 0, y: 0, width: self.width, height: self.height), mask: mask!)
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0.0, y: -self.height)
        self.uiImage[0].draw(in: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        context.restoreGState()
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        self.uiImage[0] = image
    }

    open func delay(_ d: CGFloat) {
        self.delay = d
    }

    open func numFrames() -> Int {
        return self.uiImage.count
    }

    open func getCurrentFrame() -> Int {
        return self.curFrame
    }

    open func setFrame(_ index: Int) {
        self.curFrame = index
    }

    open func reset() {
        self.curFrame = 0
    }

    open func play() {
        self.isPlaying = true
    }

    open func pause() {
        self.isPlaying = false
    }

    func frame(_ deltaTime: CGFloat) -> UIImage {
        if uiImage.count == 1 {
            return uiImage[0]
        } else if !isPlaying {
            return uiImage[curFrame]
        }

        self.deltaTime = self.deltaTime + deltaTime
        if self.deltaTime > self.delay {
            curFrame = curFrame + Int(self.deltaTime / self.delay)
            self.deltaTime = 0
        }
        if !(loop < loopMax || loopMax == -1){
            curFrame = curFrame - 1
        }
        else if curFrame >= uiImage.count {
            curFrame = 0
            loop += 1
        }
        return uiImage[curFrame]
    }
    
    open func filter(_ filterType:String, _ params: Any? = nil){
        if filterType == Sketch.PIXELLATE{
            guard let currentCGImage = self.uiImage[curFrame].cgImage else { return }
            let currentCIImage = CIImage(cgImage: currentCGImage)

            let filter = CIFilter(name: "CIPixellate")
            filter?.setValue(currentCIImage, forKey: kCIInputImageKey)
            filter?.setValue(params ?? 50, forKey: kCIInputScaleKey)
            guard let outputImage = filter?.outputImage else { return }

            let context = CIContext()

            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                let processedImage = UIImage(cgImage: cgimg)
                self.uiImage[curFrame] = processedImage
            }
        }
    }
    
    open func currentFrame() -> UIImage{
        return self.uiImage[curFrame]
    }
}
