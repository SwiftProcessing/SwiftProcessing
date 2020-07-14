import UIKit
import SceneKit

public extension Sketch {
    
    func create3D(){
        
        let sceneView = SCNView(frame: self.frame)
        self.addSubview(sceneView)
        
        self.scene = SCNScene()
        sceneView.scene = scene
        
        let camera = SCNCamera()
        self.cameraNode = SCNNode()
        self.cameraNode.camera = camera
        self.cameraNode.position = SCNVector3(x: -40, y: 0, z: 0)
        
        let light = SCNLight()
        light.type = SCNLight.LightType.omni
        self.lightNode = SCNNode()
        self.lightNode.light = light
        self.lightNode.position = SCNVector3(x: 0, y: -40, z: -40)
        
        let baseTransformationNode = SCNNode()
        self.rootNode = baseTransformationNode
        self.stackOfTransformationNodes.append(baseTransformationNode)
        
        self.scene.rootNode.addChildNode(baseTransformationNode)
        self.scene.rootNode.addChildNode(lightNode)
        self.scene.rootNode.addChildNode(cameraNode)
    }
    
    func translate(_ x: Float, _ y: Float, _ z: Float){
        
        let newTransformationNode = SCNNode()
        
        
        self.stackOfTransformationNodes.last!.addChildNode(newTransformationNode)

        
        self.stackOfTransformationNodes.append(newTransformationNode)

        let tempPosition: SCNVector3 = SCNVector3(x,y,z)
        newTransformationNode.position = tempPosition
    }
    
    func rotate(_ SCNMatrix4: SCNMatrix4){
        let newTransformationNode = SCNNode()
        
        
        self.stackOfTransformationNodes.last!.addChildNode(newTransformationNode)

        
        self.stackOfTransformationNodes.append(newTransformationNode)

        newTransformationNode.pivot = SCNMatrix4
    }
    
    func rotateX(_ r: Float){
//        let orientation = self.rootNode.orientation
//        var glOrientation = GLKQuaternionMake(orientation.x, orientation.y, orientation.z, orientation.w)
//
//        let multiplier = GLKQuaternionMakeWithAngleAndAxis(Float(r), 0, 0, 1)
//        glOrientation = GLKQuaternionMultiply(glOrientation, multiplier)
//
//        self.rootNode.worldOrientation = SCNQuaternion(x: glOrientation.x, y: glOrientation.y, z: glOrientation.z, w: glOrientation.w)
//
//        let pivot: SCNVector3 = SCNVector3(self.globalPosition.x, self.globalPosition.y, self.globalPosition.z)
//
//        self.rootNode.rotate(by: SCNQuaternion(x: glOrientation.x, y: glOrientation.y, z: glOrientation.z, w: glOrientation.w), aroundTarget: pivot)
        rotate(SCNMatrix4MakeRotation(r, 1, 0, 0))
        //let spin = CABasicAnimation(keyPath: "rotation")
    }
    
    func rotateY(_ r: Float){
        rotate(SCNMatrix4MakeRotation(r, 0, 1, 0))
    }
    
    func rotateZ(_ r: Float){
        rotate(SCNMatrix4MakeRotation(r, 0, 0, 1))
    }
    
    func sphere(_ radius: CGFloat){
        
        let tag: String = "Sphere" + radius.description + "x" +
            String(self.drawFramePosition.x) + "y" + String(self.drawFramePosition.y) + "z" +
            String(self.drawFramePosition.z)
        
        if self.nodeShapes[tag] == nil {
            
            let sphereGeometry = SCNSphere(radius: (radius))
            let sphereNode = SCNNode(geometry: sphereGeometry)
            sphereNode.position = SCNVector3(x: self.drawFramePosition.x, y: self.drawFramePosition.y, z: self.drawFramePosition.z)
            //sphereNode.simdWorldPosition = simd_float3(x: self.drawFramePosition.x, y: self.drawFramePosition.y, z: self.drawFramePosition.z)
                        
            sphereGeometry.isGeodesic = true
            sphereGeometry.segmentCount = 20
            
            print(nodeShapes.count)
            
            let constraint = SCNLookAtConstraint(target: sphereNode)
            constraint.isGimbalLockEnabled = true
            cameraNode.constraints = [constraint]
            
            
            self.rootNode.addChildNode(sphereNode)
            
            self.nodeShapes[tag] = sphereNode
            
        }
        
        self.currentNodes[tag] = true
    }
    
    func box(_ w: CGFloat,_ h: CGFloat,_ l: CGFloat,_ rounded: CGFloat = 0){
        
        let tag: String = "Cube" + "width" + w.description + "height" + h.description
        + "length" + l.description + "chamfer" + rounded.description + "x" +
            String(UInt(bitPattern: ObjectIdentifier(self.stackOfTransformationNodes.last!)))
                
        if self.nodeShapes[tag] == nil {
            
            let boxGeometry = SCNBox(width: w, height: h, length: l, chamferRadius: rounded)
            let boxNode = SCNNode(geometry: boxGeometry)
            boxNode.position = SCNVector3(x: 0, y: 0, z: 0)
            //sphereNode.simdWorldPosition = simd_float3(x: self.drawFramePosition.x, y: self.drawFramePosition.y, z: self.drawFramePosition.z)
            
            print(nodeShapes.count)
            
            let constraint = SCNLookAtConstraint(target: boxNode)
            constraint.isGimbalLockEnabled = true
            cameraNode.constraints = [constraint]
            
            
            self.stackOfTransformationNodes.last!.addChildNode(boxNode)
            
            self.nodeShapes[tag] = boxNode
            
        }
        
        self.currentNodes[tag] = true
    }
    
}
