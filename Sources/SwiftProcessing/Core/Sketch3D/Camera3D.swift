import UIKit
import SceneKit
import Foundation


open class Camera3D {
    
    var baseNode: SCNNode = SCNNode()
    var cameraNode: SCNNode = SCNNode()
    var upVector: simd_float3 = simd_float3(0,1,0)
    
    init(){
        self.baseNode = SCNNode()
        self.baseNode.position = SCNVector3(x: 0, y: 0, z: 0)
        
        let camera = SCNCamera()
        self.cameraNode = SCNNode()
        self.cameraNode.camera = camera
        self.cameraNode.position = SCNVector3(x: 0, y: 0, z: 100)
        
        let lookAtConstraint = SCNLookAtConstraint(target: self.baseNode)
        self.cameraNode.constraints = [lookAtConstraint]
    }
    
    
    open func perspective(_ fovy: CGFloat,_ aspect: CGFloat, _ near: CGFloat, _ far: CGFloat){
        
        self.cameraNode.camera!.zFar = Double(far)
        self.cameraNode.camera!.zNear = Double(near)
        
        self.cameraNode.camera!.focalLength = fovy
        
    }
    
    open func ortho(_ left: CGFloat, _ right: CGFloat, _ bottom: CGFloat, _ top: CGFloat, _ near: CGFloat, _ far: CGFloat) {
        
        self.cameraNode.camera!.usesOrthographicProjection = true
        
    }
    
    open func frustum(_ viewingAngle: CGFloat, _ direction: String){
        
        if (direction == "vertical"){
            self.cameraNode.camera!.projectionDirection = SCNCameraProjectionDirection(rawValue: 0)!
        } else if (direction == "horizontal"){
            self.cameraNode.camera!.projectionDirection = SCNCameraProjectionDirection(rawValue: 1)!
        } else {
            
        }
        self.cameraNode.camera!.fieldOfView = viewingAngle
        
    }
    
    open func move(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat){
        self.cameraNode.position = SCNVector3(self.cameraNode.position.x + Float(x),self.cameraNode.position.y + Float(y),self.cameraNode.position.z + Float(z))
    }
    
    open func setPosition(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat){
        self.cameraNode.position = SCNVector3(x,y,z)
    }
    
    open func lookAt(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat){
        self.baseNode.position = SCNVector3(x,y,z)
    }
    
    open func camera(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat, _ centerX: CGFloat, _ centerY: CGFloat, _ centerZ: CGFloat, _ upX: CGFloat, _ upY: CGFloat, _ upZ: CGFloat){
        
        self.cameraNode.position = SCNVector3(x, y, z)
        self.baseNode.position = SCNVector3(centerX, centerY, centerZ)
        
        self.cameraNode.rotation = SCNVector4(upX,upY,upZ,1)
    }
    
    

    
}
