import Foundation
import UIKit

public extension Sketch{
    func faceMode(){
        self.isFaceMode = true
    }
    
    func faceFill(){
        self.settings.faceFill = true
    }
    func noFaceFill(){
        self.settings.faceFill = false
    }
    
    func appMode(){
        self.isFaceMode = false
    }
}
