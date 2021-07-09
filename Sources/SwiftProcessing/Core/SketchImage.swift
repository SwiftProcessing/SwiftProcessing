import UIKit

public extension Sketch {

    func loadImage(_ name: String) -> Image {
        var image = UIImage(named: name)
        if image == nil {
            image = UIImage.gifImageWithName(name)
        }
        return Image(image!)
    }

    func image<T: Numeric>(_ image: Image, _ x: T, _ y: T, _ width: T? = nil, _ height: T? = nil) {
        var cg_x, cg_y: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        
        let w:CGFloat = width == nil ? CGFloat(image.width) : width! as! CGFloat
        let h:CGFloat = height == nil ? CGFloat(image.height) : height! as! CGFloat
        
        image.width = Double(w)
        image.height = Double(h)
        
        image.frame(CGFloat(deltaTime), CGFloat(frameCount)).draw(in: CGRect(x: cg_x, y: cg_y, width: w, height: h), blendMode: image.blendMode, alpha: CGFloat(image.alpha))
    }
    
    func saveSketch() {
        UIGraphicsBeginImageContext(self.frame.size)
        self.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
    }
}
