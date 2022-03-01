/*
 * SwiftProcessing: Image
 *
 * */

import Foundation
import UIKit

// =======================================================================
// MARK: - Image Class
// =======================================================================

public extension Sketch {
    
    class Image {
        
        /*
         * MARK: - STILL IMAGE PROPERTIES
         */
        
        open var ciContext: CIContext = CIContext()
        open var pixels: [UInt8] = []
        
        /// Width of image.
        
        var width: Double = 0
        
        /// Height of image.
        
        var height: Double = 0
        
        /// Blend mode: Possible values are, .normal, .multiply, .screen, .overlay, .darken, .lighten, .colorDodge, .colorBurn, .softLight, .hardLight, .difference, .exclusion, .hue, .saturation, .color, and .luminosity. There are more availailable as well, which can be found here: https://developer.apple.com/documentation/coregraphics/cgblendmode
        
        open var blendMode: CGBlendMode = .normal
        
        /// Alpha value of the image which specifies it's transparency.
        
        open var alpha: Double = 1.0
        
        /*
         * MARK: - ANIMATED IMAGE PROPERTIES
         */
        
        var uiImage: [UIImage] // An array of images because it may be animated.
        var delay: Double = 0
        var curFrame: Int = 0
        var isPlaying = true
        var lastFrameDrawn: Double = -1
        var deltaTime: Double = 0
        
        open var loop: Double = 0
        open var loopMax: Double = -1
        
        public init(_ image: UIImage) {
            self.width = Double(image.size.width)
            self.height = Double(image.size.height)
            self.uiImage = image.images != nil ? image.images! : [image]
            self.delay = image.duration / 100
        }
        
        /*
         * MARK: - STILL IMAGE METHODS
         */
        
        /// Returns the size of the image in a CGSize object. The width and height of CGSize objects are of the CGFloat type, so to use them in SwiftProcessing you'll need to convert them to Doubles with the `Double()` function.
        
        open func size() -> CGSize {
            return CGSize(width: self.width, height: self.height)
        }
        
        /// Returns the size of the image in a CGSize object. The width and height of CGSize objects are of the CGFloat type, so to use them in SwiftProcessing you'll need to convert them to Doubles with the `Double()` function.
        
        
        open func rawSize() -> CGSize {
            return self.uiImage[curFrame].size
        }
        
        /// Takes a snapshot of the pixel data and saves it as an array of `UInt8`'s. `UInt8` stands for unsigned integer 8-bit and it is one standard method for storing image data. R G B A data is stored in sequence, so one method to access and manipulate this data is with the % operator. This data can be found in the `.pixels` parameter of the image.
        
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
        
        /// Returns a cropped portion of your sketch as an image. Works similar to the CORNER method of drawing rectangles with x, y, width, and height.
        ///
        /// - Parameters:
        ///     - x: x position of upper-left hand corner.
        ///     - y: y position of upper-left hand corner.
        ///     - w: width of crop.
        ///     - h: height of crop.
        
        open func get<X: Numeric, Y: Numeric, W: Numeric, H: Numeric>(_ x: X, _ y: Y, _ w: W, _ h: H) -> Image {
            var cg_x, cg_y, cg_w, cg_h: CGFloat
            cg_x = x.convert()
            cg_y = y.convert()
            cg_w = w.convert()
            cg_h = h.convert()
            
            UIGraphicsBeginImageContextWithOptions(CGSize(width: cg_w, height: cg_h), false, 1.0)
            let container = CGRect(x: -cg_x, y: -cg_y, width: CGFloat(self.width), height: CGFloat(self.height))
            UIGraphicsGetCurrentContext()!.clip(to: CGRect(x: 0, y: 0,
                                                           width: cg_w, height: cg_h))
            self.uiImage[0].draw(in: container)
            let newImage = Image(UIGraphicsGetImageFromCurrentImageContext()!)
            UIGraphicsEndImageContext()
            
            return newImage
        }
        
        /// Updates the display to reflect changes in pixel data. To be used in conjunction with `loadPixels()`.
        
        @available(iOS 9.0, *)
        open func updatePixels() {
            self.updatePixels(0, 0, uiImage[curFrame].size.width, uiImage[curFrame].size.height)
        }
        
        /// Updates the specified portion of the display to reflect changes in pixel data. To be used in conjunction with `loadPixels()`.
        ///
        /// - Parameters:
        ///     - x: x position of upper-left hand corner.
        ///     - y: y position of upper-left hand corner.
        ///     - w: width of crop.
        ///     - h: height of crop.
        
        @available(iOS 9.0, *)
        open func updatePixels<X: Numeric, Y: Numeric, W: Numeric, H: Numeric>(_ x: X, _ y: Y, _ w: W, _ h: H) {
            //retrieve the current image and apply the current pixels loaded into the pixels array using the x, y, w, h inputs
            var cg_x, cg_y, cg_w, cg_h: CGFloat
            cg_x = x.convert()
            cg_y = y.convert()
            cg_w = w.convert()
            cg_h = h.convert()
            
            var newImage = getPixelData()
            let curImage = self.uiImage[curFrame]
            let size = curImage.size
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            
            for dy in Int(cg_y)..<Int(cg_h) {
                for dx in Int(cg_x)..<Int(cg_w) {
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
        
        /// Resizes the image to the new specified size.
        ///
        /// - Parameters:
        ///     - w: new width.
        ///     - h: new height.
        
        open func resize<W: Numeric, H: Numeric>(_ width: W, _ height: H) {
            self.width = width.convert()
            self.height = height.convert()
            
            var cg_width, cg_height: CGFloat
            cg_width = width.convert()
            cg_height = height.convert()
            let newSize = CGSize(width: cg_width, height: cg_height)
            
            self.uiImage = self.uiImage.map({
                UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
                $0.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
                
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return newImage!
            })
        }
        
        /// Copies a portion specified of the image to a destination location.
        ///
        /// - Parameters:
        ///     - sx: x position of upper-left hand corner.
        ///     - sy: y position of upper-left hand corner.
        ///     - sw: width of crop.
        ///     - sh: height of crop.
        ///     - dx: x position of upper-left hand corner.
        ///     - dy: y position of upper-left hand corner.
        ///     - dw: width of crop.
        ///     - dh: height of crop.
        
        open func copy<SX: Numeric, SY: Numeric, SW: Numeric, SH: Numeric, DX: Numeric, DY: Numeric, DW: Numeric, DH: Numeric>(_ srcImage: Image, _ sx: SX, _ sy: SY, _ sw: SW, _ sh: SH, _ dx: DX, _ dy: DY, _ dw: DW, _ dh: DH) {
            
            var cg_sx, cg_sy, cg_sw, cg_sh, cg_dx, cg_dy, cg_dw, cg_dh: CGFloat
            cg_sx = sx.convert()
            cg_sy = sy.convert()
            cg_sw = sw.convert()
            cg_sh = sh.convert()
            cg_dx = dx.convert()
            cg_dy = dy.convert()
            cg_dw = dw.convert()
            cg_dh = dh.convert()
            
            UIGraphicsBeginImageContextWithOptions(CGSize(width: self.width, height: self.height), false, 2.0)
            UIGraphicsGetCurrentContext()!.interpolationQuality = .high
            
            self.uiImage[0].draw(in: CGRect(x: 0, y: 0, width: self.width, height: self.height))
            srcImage.get(cg_sx, cg_sy, cg_sw, cg_sh).uiImage[0].draw(in: CGRect(x: cg_dx, y: cg_dy, width: cg_dw, height: cg_dh), blendMode: .normal, alpha: 1.0)
            
            //set to self if nothing is found in the image context... possible when bad parameters are passed into this function
            self.uiImage[0] = UIGraphicsGetImageFromCurrentImageContext() ?? self.uiImage[0]
            UIGraphicsEndImageContext()
        }
        
        /// Masks a portion of the image with a supplied mask.
        ///
        /// - Parameters:
        ///     - srcImage: an image
        
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
            context.translateBy(x: 0.0, y: CGFloat(self.height))
            context.scaleBy(x: 1.0, y: -1.0)
            context.clip(to: CGRect(x: 0, y: 0, width: self.width, height: self.height), mask: mask!)
            context.scaleBy(x: 1.0, y: -1.0)
            context.translateBy(x: 0.0, y: CGFloat(-self.height))
            self.uiImage[0].draw(in: CGRect(x: 0, y: 0, width: self.width, height: self.height))
            context.restoreGState()
            let image = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            self.uiImage[0] = image
        }
        
        open func filter(_ filterType:Filter, _ params: Any? = nil){
            for i in 0...uiImage.count - 1{
                guard let currentCGImage = self.uiImage[i].cgImage else { return }
                let currentCIImage = CIImage(cgImage: currentCGImage)
                var filter: CIFilter?
                
                switch filterType {
                case Filter.pixellate:
                    filter = CIFilter(name: "CIPixellate")
                    filter?.setValue(currentCIImage, forKey: kCIInputImageKey)
                    filter?.setValue(params ?? 50, forKey: kCIInputScaleKey)
                case Filter.hue_rotate:
                    filter = CIFilter(name: "CIHueAdjust")
                    filter?.setValue(currentCIImage, forKey: kCIInputImageKey)
                    filter?.setValue(params ?? 50, forKey: kCIInputAngleKey)
                case Filter.sepia_tone:
                    filter = CIFilter(name: "CISepiaTone")
                    filter?.setValue(currentCIImage, forKey: kCIInputImageKey)
                    filter?.setValue(params ?? 1.0, forKey: kCIInputIntensityKey)
                case Filter.tonal:
                    filter = CIFilter(name: "CIPhotoEffectTonal")
                    filter?.setValue(currentCIImage, forKey: kCIInputImageKey)
                case Filter.monochrome:
                    filter = CIFilter(name: "CIColorMonochrome")
                    let c = params as! Color
                    let ciColor = CIColor(red: c.uiColor().rgba.red, green: c.uiColor().rgba.green, blue: c.uiColor().rgba.blue, alpha: c.uiColor().rgba.alpha)
                    filter?.setValue(currentCIImage, forKey: kCIInputImageKey)
                    filter?.setValue(ciColor, forKey: kCIInputColorKey)
                case Filter.invert:
                    filter = CIFilter(name: "CIColorInvert")
                    filter?.setValue(currentCIImage, forKey: kCIInputImageKey)
                }
                
                guard let outputImage = filter?.outputImage else { return }
                
                let processedImage = UIImage(cgImage: ciContext.createCGImage(outputImage, from: outputImage.extent)!)
                self.uiImage[i] = processedImage
            }
        }
        
        /*
         * MARK: - ANIMATED IMAGE METHODS
         */
        
        open func delay<D: Numeric>(_ d: D) {
            self.delay = d.convert()
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
        
        public func frame<D: Numeric, F: Numeric>(_ deltaTime: D, _ frameCount: F) -> UIImage {
            var d_deltaTime, d_frameCount: Double
            d_deltaTime = deltaTime.convert()
            d_frameCount = frameCount.convert()
            
            if uiImage.count == 1 {
                return uiImage[0]
            } else if !isPlaying || d_frameCount == lastFrameDrawn {
                return uiImage[curFrame]
            }
            
            self.lastFrameDrawn = d_frameCount
            self.deltaTime = self.deltaTime + d_deltaTime
            if self.deltaTime > self.delay {
                curFrame = curFrame + Int(self.deltaTime / self.delay)
                self.deltaTime = 0
            }
            if !(loop < loopMax || loopMax == -1){
                curFrame = uiImage.count - 1
            }
            else if curFrame >= uiImage.count {
                //todo simplify this logic
                curFrame = (loop + 1 < loopMax || loopMax == -1) ? 0 : uiImage.count - 1
                loop += 1
            }
            return uiImage[curFrame]
        }
        
        open func currentFrame() -> UIImage{
            return self.uiImage[curFrame]
        }
    }
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
