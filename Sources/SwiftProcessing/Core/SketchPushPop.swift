/*
 * SwiftProcessing: Push, Pop
 *
 * */

import SceneKit

extension Sketch {
    
    // NOTE FOR FUTURE CONTRIBUTORS: There needs to be a check done at each draw cycle for whether there are any push(), pushStyle(), or pushMatrix() calls that are unaccompanied by a corresponding pop(), popStyle(), or popMatrix call. This can easily be done by comparing the size of the stacks and throwing a meaningful error that explains that all pushes require a corresponding pop. This will prevent the accumulation of states in the stack which could lead to memory leaks.

    // =======================================================================
    // MARK: - PUSH AND POP MATRIX
    // =======================================================================

    /// Resets the current transformation matrix to the identity. Used internally.
    
    public func resetMatrixToIdentity() {
        //Get current transformation matrix via CGContextGetCTM, invert it with CGAffineTransformInvert and multiply the current matrix by the inverted one (that's important!) with CGContextConcatCTM. CTM is now identity.
        
        // Source: https://stackoverflow.com/questions/469505/how-to-reset-to-identity-the-current-transformation-matrix-with-some-cgcontext
        
        let inverted = context?.ctm.inverted()
        context?.concatenate(inverted!)
    }
    
    ///  `pushMatrix()` saves the current transformation matrix of the graphics context and pushes it onto the matrix stacks. **Note:** Each `pushMatrix()` must be accompanied by a `popMatrix()`.
    ///  ````
    ///  pushMatrix()
    ///  ````
    
    open func pushMatrix() {
        let currentTransformation = (context?.ctm)!
        matrixStack.push(matrix: currentTransformation)
    }
    
    ///  `pushMatrix()` saves the current transformation matrix of the graphics context and pushes it onto the matrix stacks. **Note:** Each `pushMatrix()` must be accompanied by a `popMatrix()`.
    ///  ````
    ///  pushMatrix()
    ///  ````
    
    open func popMatrix() {
        resetMatrixToIdentity()
        context?.concatenate(matrixStack.pop()!)
    }
    
    // =======================================================================
    // MARK: - PUSH AND POP STYLE
    // =======================================================================

    /// The `pushStyle()` function saves the current style settings and `popStyle()` restores the prior settings. Note that these functions are always used together. They allow you to change the style settings and later return to what you had. When a new style is started with `pushStyle()`, it builds on the current style information. The `pushStyle()` and `popStyle()` functions can be embedded to provide more control (see the second example above for a demonstration`.)
    /// The style information controlled by the following functions are included in the style: `fill()`, `stroke()`, `tint()`, `strokeWeight()`, `strokeCap()`, `strokeJoin()`, `imageMode()`, `rectMode()`, `ellipseMode()`, `shapeMode()`, `colorMode()`, `textAlign()`, `textFont()`, `textMode()`, `textSize()`, `textLeading()`
    /// Not yet implemented: `emissive()`, `specular()`, `shininess()`, `ambient()`
    
    open func pushStyle() {
        settingsStack.push(settings: settings)
        setTextAttributes()
    }
    
    /// The `pushStyle()` function saves the current style settings and `popStyle()` restores the prior settings. Note that these functions are always used together. They allow you to change the style settings and later return to what you had. When a new style is started with `pushStyle()`, it builds on the current style information. The `pushStyle()` and `popStyle()` functions can be embedded to provide more control (see the second example above for a demonstration`.)
    /// The style information controlled by the following functions are included in the style: `fill()`, `stroke()`, `tint()`, `strokeWeight()`, `strokeCap()`, `strokeJoin()`, `imageMode()`, `rectMode()`, `ellipseMode()`, `shapeMode()`, `colorMode()`, `textAlign()`, `textFont()`, `textMode()`, `textSize()`, `textLeading()`
    /// Not yet implemented: `emissive()`, `specular()`, `shininess()`, `ambient()`
    
    open func popStyle() {
        settings = settingsStack.pop()!
        settings.reapplySettings(self)
    }
    
    // =======================================================================
    // MARK: - PUSH AND POP
    // =======================================================================

    /// `push()` saves the current style and matrix state of the graphics context and pushes it onto the style and matrix stacks. SwiftProcessing saves the following style states: `colorMode`, `fill`, `stroke`, `tint`, `strokeWeight`, `strokeJoin`, `strokeCap`, `rectMode`, `ellipseMode`, `imageMode`, `textFont`, `textSize`, `textLeading`, `textAlign`, `textAlignY`, and `blendMode`. It also stores the current transformation matrix, including any `scale()`, `translate()`, or `rotate()`'s that have been applied. **Note:** For every `push()`, there must be a corresponding `pop()`.
    
    open func push() {
        pushStyle()
        setTextAttributes()
        
        pushMatrix()
        
        if (self.enable3DMode) {
            let rootTransformationNode = self.currentTransformationNode
            
            let newTransformationNode = rootTransformationNode.addNewTransitionNode()
            
            self.currentStack.append(newTransformationNode)
            self.stackOfTransformationNodes.append(newTransformationNode)
            
            self.translationNode(SCNVector3(0,0,0), "position", false)
        }
    }
    
    /// `pop()` restores the current style and matrix state of the graphics context and removes it from the style and matrix stacks. SwiftProcessing saves the following style states: `colorMode`, `fill`, `stroke`, `tint`, `strokeWeight`, `strokeJoin`, `strokeCap`, `rectMode`, `ellipseMode`, `imageMode`, `textFont`, `textSize`, `textLeading`, `textAlign`, `textAlignY`, and `blendMode`. It also stores the current transformation matrix, including any `scale()`, `translate()`, or `rotate()`'s that have been applied. **Note:** For every `push()`, there must be a corresponding `pop()`.
    
    open func pop() {
        popStyle()
        setTextAttributes()
        
        popMatrix()
        
        if(self.enable3DMode){
            self.currentTransformationNode = self.currentStack.popLast()!
        }
    }
}
