import UIKit
import SceneKit
import Foundation


public extension Sketch {

    func texture(_ image: Image) {

        self.texture = image
        self.textureEnabled = true
        self.textureID = String(UInt(bitPattern: ObjectIdentifier(self.texture!)))
    }
    
    func shininess(_ shine: CGFloat) {
        self.scnmat.shininess = shine
    }
    
    func specularMaterial(_ grey: CGFloat, _ alpha: CGFloat = 0) {
        self.scnmat.specular.contents = UIColor(white: grey, alpha: alpha)
    }
    
    func specularMaterial(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 0) {
        self.scnmat.specular.contents = UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func specularMaterial(_ color: UIColor) {
        self.scnmat.specular.contents = color
    }
    
    func ambientMaterial(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 0) {
        self.scnmat.ambient.contents = UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func ambientMaterial(_ color: UIColor) {
        self.scnmat.ambient.contents = color
    }
    
    func emissiveMaterial(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 0) {
        self.scnmat.emission.contents = UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func emissiveMaterial(_ color: UIColor) {
        self.scnmat.emission.contents = color
    }
}
