import UIKit

public extension Sketch {

    // FOR FUTURE CONTRIBUTORS: There is currently a bug that prevents animated gifs from loading if their extension is in the file name. A little string modification should be able to fix this bug.
    
    // Adjust so that it takes the file type into account.
    // https://github.com/jjkaufman/SwiftProcessing/issues/95
    
    /// Loads an image to be stored in a variable. Images must be located within the project of an Xcode project or in the Resources folder of a Playground.
    /// ```
    /// let image = loadImage("myjpeg")
    /// ```
    /// - Parameters:
    ///   - name: The file name. Leave off the file extension.
    
    func loadImage(_ name: String) -> Image {
        var image = UIImage(named: name)
        if image == nil {
            image = UIImage.gifImageWithName(name)
        }
        return Image(image!)
    }
    
    // FOR FUTURE CONTRIBUTORS: UIImage must be supported to accept image literals in Playgrounds.
    /*
    func loadImage(_ image: UIImage) -> Image {
        var out_image = UIImage.gifImageWithData(image.data)
        return Image(out_image!)
    }
    */
    
    // FOR FUTURE CONTRIBUTORS: The basic infrastructure for tinting images and the sketch view is here, but it has not been implemented.
    
    /// Tints an image to a color or makes the image transparent. NOT IMPLEMENTED.
    /// ```
    /// // Tints the image to a red color with 50% tranparency if in RGB mode.
    /// tint(127,0,0, 127)
    /// image(image, 0, 0)
    /// ```
    /// - Parameters:
    ///     - v1: A red value from 0-255 (RGB). A hue value from 0-360 (HSB).
    ///     - v2: A green value from 0-255 (RGB). A saturation value from 0-100 (HSB).
    ///     - v3: A blue value from 0-255 (RGB). A brightness value from 0-100 (HSB).
    ///     - a: An optional alpha value from 0-255. Defaults to 255 (RGB). An alpha value from 0-100. Defaults to 255 (HSB). Defaults to 255.
    
    func tint<V1: Numeric, V2: Numeric, V3: Numeric, A: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3, _ a: A) {
        let cg_v1, cg_v2, cg_v3, cg_a: CGFloat
        cg_v1 = v1.convert()
        cg_v2 = v2.convert()
        cg_v3 = v3.convert()
        cg_a = a.convert()
        settings.tint = Color(cg_v1, cg_v2, cg_v3, cg_a, settings.colorMode)
    }
    
    /// Tints an image to a color. NOT IMPLEMENTED.
    /// ```
    /// // Tints the image to a red color if in RGB mode.
    /// tint(127,0,0)
    /// image(image, 0, 0)
    /// ```
    /// - Parameters:
    ///     - v1: A red value from 0-255 (RGB). A hue value from 0-360 (HSB).
    ///     - v2: A green value from 0-255 (RGB). A saturation value from 0-100 (HSB).
    ///     - v3: A blue value from 0-255 (RGB). A brightness value from 0-100 (HSB).
    
    func tint<V1: Numeric, V2: Numeric, V3: Numeric>(_ v1: V1, _ v2: V2, _ v3: V3) {
        let cg_v1, cg_v2, cg_v3, cg_a: CGFloat
        cg_v1 = v1.convert()
        cg_v2 = v2.convert()
        cg_v3 = v3.convert()
        cg_a = 255.0
        settings.tint = Color(cg_v1, cg_v2, cg_v3, cg_a, settings.colorMode)
    }
    
    /// Tints an image to a gray value or makes the image transparent. NOT IMPLEMENTED.
    /// ```
    /// // Tints the image to a gray color and 50% transparency.
    /// tint(127,127)
    /// image(image, 0, 0)
    /// ```
    /// - Parameters:
    ///     - v1: A red value from 0-255 (RGB). A hue value from 0-360 (HSB).
    ///     - a: An optional alpha value from 0-255.
    
    func tint<V1: Numeric, A: Numeric>(_ v1: V1, _ a: A) {
        let cg_v1, cg_a: CGFloat
        cg_v1 = v1.convert()
        cg_a = a.convert()
        settings.tint = Color(cg_v1, cg_v1, cg_v1, cg_a, .rgb)
    }
    
    /// Tints an image to a gray value. NOT IMPLEMENTED.
    /// ```
    /// // Tints the image to a gray color.
    /// tint(127)
    /// image(image, 0, 0)
    /// ```
    /// - Parameters:
    ///     - v1: A gray value from 0-255.
    
    func tint<V1: Numeric>(_ v1: V1) {
        let cg_v1, cg_a: CGFloat
        cg_v1 = v1.convert()
        cg_a = 255.0
        settings.tint = Color(cg_v1, cg_v1, cg_v1, cg_a, .rgb)
    }
    
    /// Tints an image to a color or makes the image transparent. NOT IMPLEMENTED.
    /// ```
    /// // Tints the image to a gray color.
    /// myColor = Color(127, 0, 0, 127)
    /// tint(myColor)
    /// image(image, 0, 0)
    /// ```
    /// - Parameters:
    ///     - color: A Color instance.
    
    func tint(_ color: Color) {
        settings.tint = color
    }
    
    /// Tints an image to a color or makes the image transparent. NOT IMPLEMENTED.
    /// ```
    /// // Tints the image to a UIColor, which is useful for color literals.
    /// tint(ColorLiteral) // Typing ColorLiteral will bring up a color picker.
    /// image(image, 0, 0)
    /// ```
    /// - Parameters:
    ///     - color: A UIColor or Color Literal
    
    func tint(_ color: UIColor) {
        settings.tint = Color(color)
    }
    
    /// Places an image in a sketch with an x and y position. Image placement is partially controlled by the `imageMode()` function. By default the x and y values are the upper-left- and upper-right-hand corner of the image.
    /// ```
    /// // Tints the image to a UIColor, which is useful for color literals.
    /// tint(ColorLiteral) // Typing ColorLiteral will bring up a color picker.
    /// image(image, 0, 0)
    /// ```
    /// - Parameters:
    ///     - image: Image instance
    ///     - x: x position
    ///     - y: y position
    
    func image<X: Numeric, Y: Numeric>(_ image: Image, _ x: X, _ y: Y) {
        self.image(image, x, y, nil as Double?, nil as Double?)
    }
    
    /// Places an image in a sketch with an x, y, width, and height. Image placement is partially controlled by the `imageMode()` function. By default the x and y values are the upper-left- and upper-right-hand corner of the image.
    /// ```
    /// // Tints the image to a UIColor, which is useful for color literals.
    /// tint(ColorLiteral) // Typing ColorLiteral will bring up a color picker.
    /// image(image, 0, 0)
    /// ```
    /// - Parameters:
    ///     - image: Image instance
    ///     - x: x position
    ///     - y: y position
    ///     - width: width of the image
    ///     - height: height of the image

    func image<X: Numeric, Y: Numeric, W: Numeric, H: Numeric>(_ image: Image, _ x: X, _ y: Y, _ width: W? = nil, _ height: H? = nil) {
        let cg_x, cg_y: CGFloat
        cg_x = x.convert()
        cg_y = y.convert()
        
        let cg_w:CGFloat = width == nil ? CGFloat(image.width) : width!.convert()
        let cg_h:CGFloat = height == nil ? CGFloat(image.height) : height!.convert()
                
        image.width = Double(cg_w)
        image.height = Double(cg_h)
        
        // We're going to manipulate the coordinate matrix, so we need to freeze everything.
        context?.saveGState()
        
        imageModeHelper(cg_x, cg_y, cg_w, cg_h)
        
        // Corners adjustment
        var newW = cg_w
        var newH = cg_h
        if settings.imageMode == .corners {
            newW = cg_w - cg_x
            newH = cg_h - cg_y
        }
        
        image.frame(CGFloat(deltaTime), CGFloat(frameCount)).draw(in: CGRect(x: cg_x, y: cg_y, width: newW, height: newH), blendMode: image.blendMode, alpha: CGFloat(image.alpha))
        
        // We're going to restore the matrix to the previous state.
        context?.restoreGState()
    }
    
    private func imageModeHelper(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) {
        switch settings.ellipseMode {
        case .center:
            translate(-w * 0.5, -h * 0.5)
        case .radius:
            scale(0.5, 0.5)
        case .corner:
            return
        case .corners:
            return
        }
    }
    
    /// Saves an image of your sketch to your photo album. This should probably be placed within a touch responder or a button. Don't place this in `draw()`.
    /// ```
    /// func touchStarted() {
    ///   saveSketch()
    /// }
    /// ```
    
    func saveSketch() {
        UIGraphicsBeginImageContext(self.frame.size)
        self.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
    }
}
