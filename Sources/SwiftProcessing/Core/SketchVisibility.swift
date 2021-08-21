/*
 * SwiftProcessing: Visibility
 *
 * */

public extension Sketch {
    
    /// Shows the sketch, i.e. turns the sketch's view's visibility on. This can be useful if you have a toggle or are handling multiple views.
    /// ```
    /// // Shows current sketch.
    /// show()
    /// ```
    
    func show(){
        self.isHidden = false
    }
    
    /// Hide's the sketch, i.e. turns the sketch's view's visibility off. This can be useful if you have a toggle or are handling multiple views.
    /// ```
    /// // Hide current sketch.
    /// hide()
    /// ```
    
    func hide(){
        self.isHidden = true
    }

}
