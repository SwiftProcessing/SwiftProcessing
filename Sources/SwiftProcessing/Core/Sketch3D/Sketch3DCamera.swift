import UIKit
import SceneKit
import Foundation


public extension Sketch {
    
    func camera(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat, _ centerX: CGFloat, _ centerY: CGFloat, _ centerZ: CGFloat, _ upX: CGFloat, _ upY: CGFloat, _ upZ: CGFloat){
        
        self.cameraNode.position = SCNVector3(x, y, z)
        self.cameraBase.position = SCNVector3(centerX, centerY, centerZ)
        
        self.cameraNode.rotation = SCNVector4(upX,upY,upZ,1)
        
    }
    
    func setCamera(_ camNode: Camera3D) {
        
        self.cameraBase.removeFromParentNode()
        self.cameraNode.removeFromParentNode()
        self.scene.rootNode.addChildNode(camNode.baseNode)
        self.scene.rootNode.addChildNode(camNode.cameraNode)
        self.cameraBase = camNode.baseNode
        self.cameraNode = camNode.cameraNode
        
    }
    
    func createCamera3D() -> Camera3D{
        let cam: Camera3D = Camera3D()
        return cam
    }
        
}
