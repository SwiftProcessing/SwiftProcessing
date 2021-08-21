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
    /// - parameter at: a CGPoint.
    
    open func pushMatrix() {
        let currentTransformation = (context?.ctm)!
        matrixStack.push(matrix: currentTransformation)
    }
    
    open func popMatrix() {
        resetMatrixToIdentity()
        context?.concatenate(matrixStack.pop()!)
    }
    
    // =======================================================================
    // MARK: - PUSH AND POP STYLE
    // =======================================================================

    open func pushStyle() {
        settingsStack.push(settings: settings)
    }
    
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
        popMatrix()
        
        if(self.enable3DMode){
            self.currentTransformationNode = self.currentStack.popLast()!
        }
    }
}
