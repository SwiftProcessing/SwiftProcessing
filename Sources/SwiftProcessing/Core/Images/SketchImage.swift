import UIKit

public extension Sketch {

    func loadImage(_ name: String) -> Image {
        var image = UIImage(named: name)
        if image == nil {
            image = UIImage.gifImageWithName(name)
        }
        return Image(image!)
    }
    
    // TO DO: UIImage must be supported to accept image literals.
    /*
    func loadImage(_ image: UIImage) -> Image {
        var out_image = UIImage.gifImageWithData(image.data)
        return Image(out_image!)
    }
    */
    
    func image<X: Numeric, Y: Numeric>(_ image: Image, _ x: X, _ y: Y) {
        self.image(image, x, y, nil as Double?, nil as Double?)
    }

    func image<X: Numeric, Y: Numeric, W: Numeric, H: Numeric>(_ image: Image, _ x: X, _ y: Y, _ width: W? = nil, _ height: H? = nil) {
        var cg_x, cg_y: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        
        let w:CGFloat = width == nil ? CGFloat(image.width) : width!.convert()
        let h:CGFloat = height == nil ? CGFloat(image.height) : height!.convert()
        
        image.width = Double(w)
        image.height = Double(h)
        
        push()
        imageModeHelper(cg_x, cg_y, w, h)
        image.frame(CGFloat(deltaTime), CGFloat(frameCount)).draw(in: CGRect(x: cg_x, y: cg_y, width: w, height: h), blendMode: image.blendMode, alpha: CGFloat(image.alpha))
        pop()
    }
    
    private func imageModeHelper(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) {
        switch settings.ellipseMode {
        case CENTER:
            translate(-w * 0.5, -h * 0.5)
        case RADIUS:
            scale(0.5, 0.5)
        case CORNER:
            return
        case CORNERS:
            return
        default:
            print("invalid imageModeValue")
        }
    }
    
    func saveSketch() {
        UIGraphicsBeginImageContext(self.frame.size)
        self.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
    }
}
