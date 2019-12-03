import Foundation
import UIKit

open class Image{
    
    var uiImage: [UIImage]
    var delay: CGFloat = 0
    var curFrame: Int = 0
    var isPlaying = true
    var deltaTime: CGFloat = 0
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    init(_ image: UIImage){
        self.width = image.size.width
        self.height = image.size.height
        self.uiImage = image.images != nil ? image.images! : [image]
        self.delay = CGFloat(image.duration) / 100
    }
    
    open func get(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) -> Image{
        UIGraphicsBeginImageContextWithOptions(CGSize(width: w, height:  h), false, 2.0)
        let container = CGRect(x: -x, y: -y, width: self.width, height: self.height)
        UIGraphicsGetCurrentContext()!.clip(to: CGRect(x: 0, y: 0,
        width: w, height: h))
        self.uiImage[0].draw(in: container)
        let newImage = Image(UIGraphicsGetImageFromCurrentImageContext()!)
        UIGraphicsEndImageContext()
        return newImage
    }
    
    open func resize(_ width: CGFloat, _ height: CGFloat){
        self.width = width
        self.height = height
    }
    
    open func copy(_ srcImage: Image, _ sx: CGFloat, _ sy: CGFloat, _ sw: CGFloat, _ sh: CGFloat, _ dx: CGFloat, _ dy: CGFloat, _ dw: CGFloat, _ dh: CGFloat){
        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.width, height:  self.height), false, 2.0)
        UIGraphicsGetCurrentContext()!.interpolationQuality = .high
        
        self.uiImage[0].draw(in: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        srcImage.get(sx, sy, sw, sh).uiImage[0].draw(in: CGRect(x: dx, y: dy, width: dw, height: dh), blendMode: .normal, alpha: 1.0)
        
        //set to self if nothing is found in the image context... possible when bad parameters are passed into this function
        self.uiImage[0] = UIGraphicsGetImageFromCurrentImageContext() ?? self.uiImage[0]
        UIGraphicsEndImageContext()
    }
    
    open func mask(_ srcImage: Image){
        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.width, height:  self.height), false, 2.0)
        let context = UIGraphicsGetCurrentContext()!
        //mask strategy adapted from https://stackoverflow.com/questions/8126276/how-to-convert-uiimage-cgimagerefs-alpha-channel-to-mask
        let decode = [ CGFloat(1), CGFloat(0),
                       CGFloat(0), CGFloat(1),
                       CGFloat(0), CGFloat(1),
                       CGFloat(0), CGFloat(1) ]
        
        let cgImage = srcImage.uiImage[0].cgImage!
        
        // Create the mask `CGImage` by reusing the existing image data
        // but applying a custom decode array.
        let mask =  CGImage(width:              cgImage.width,
                            height:             cgImage.height,
                            bitsPerComponent:   cgImage.bitsPerComponent,
                            bitsPerPixel:       cgImage.bitsPerPixel,
                            bytesPerRow:        cgImage.bytesPerRow,
                            space:              cgImage.colorSpace!,
                            bitmapInfo:         cgImage.bitmapInfo,
                            provider:           cgImage.dataProvider!,
                            decode:             decode,
                            shouldInterpolate:  cgImage.shouldInterpolate,
                            intent:             cgImage.renderingIntent)
        
        context.saveGState();
        context.translateBy(x: 0.0, y: self.height);
        context.scaleBy(x: 1.0, y: -1.0);
        context.clip(to: CGRect(x: 0, y: 0, width: self.width, height: self.height), mask: mask!)
        context.scaleBy(x: 1.0, y: -1.0);
        context.translateBy(x: 0.0, y: -self.height);
        self.uiImage[0].draw(in: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        context.restoreGState();
                
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.uiImage[0] = image
    }
    
    open func delay(_ d: CGFloat){
          self.delay = d
    }
    
    open func numFrames() -> Int{
        return self.uiImage.count
    }
    
    open func getCurrentFrame() -> Int{
        return self.curFrame
    }
    
    open func setFrame(_ index: Int){
        self.curFrame = index
    }
    
    open func reset(){
        self.curFrame = 0
    }
    
    open func play(){
        self.isPlaying = true
    }
    
    open func pause(){
        self.isPlaying = false
    }
    
    func frame(_ deltaTime: CGFloat) -> UIImage{
        if(uiImage.count == 1){
            return uiImage[0]
        }else if(!isPlaying){
            return uiImage[curFrame]
        }
        
        self.deltaTime = self.deltaTime + deltaTime
        if(self.deltaTime > self.delay){
            curFrame = curFrame + Int(self.deltaTime / self.delay)
            self.deltaTime = 0
        }
        if curFrame >= uiImage.count{
            curFrame = 0
        }
        return uiImage[curFrame]
    }
}
