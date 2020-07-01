import UIKit

public extension Sketch {

    func loadImage(_ name: String) -> Image {
        var image = UIImage(named: name)
        if image == nil {
            image = UIImage.gifImageWithName(name)
        }
        return Image(image!)
    }

    func image(_ image: Image, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat? = nil, _ height: CGFloat? = nil) {
        let w = width == nil ? CGFloat(image.width) : width!
        let h = height == nil ? CGFloat(image.height) : height!
        image.width = w
        image.height = h
        image.frame(deltaTime, frameCount).draw(in: CGRect(x: x, y: y, width: w, height: h), blendMode: image.blendMode, alpha: image.alpha)
    }
    
    func saveSketch() {
        UIGraphicsBeginImageContext(self.frame.size)
        self.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
    }
}
