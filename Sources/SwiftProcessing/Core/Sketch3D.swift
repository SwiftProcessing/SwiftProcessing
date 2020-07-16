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
        self.cameraNode.position = SCNVector3(x: 0, y: 0, z: 40)
        
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
        
        let tempPosition: SCNVector3 = SCNVector3(x,y,z)
        
        var lastNode = self.stackOfTransformationNodes.last!
                
        if lastNode.childNodes.count == 0 && self.stackOfTransformationNodes.count > 1{
            
            lastNode.position.add(tempPosition)
            
        } else {
                        
            let newTransformationNode = SCNNode()
            
            
            lastNode.addChildNode(newTransformationNode)

            
            self.stackOfTransformationNodes.append(newTransformationNode)

            newTransformationNode.position = tempPosition
            
        }
        
        drawFramePosition += simd_float4(x, y, z, 0)
    }
    
    func rotate(_ vector: SCNVector3){
        
        let lastNode = self.stackOfTransformationNodes.last!

        if lastNode.childNodes.count == 0 && self.stackOfTransformationNodes.count > 1{
            
            lastNode.eulerAngles.add(vector)
            
        } else {
            
            let newTransformationNode = SCNNode()
            
            lastNode.addChildNode(newTransformationNode)
            
            self.stackOfTransformationNodes.append(newTransformationNode)

            newTransformationNode.eulerAngles = vector
            
        }
        
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
        rotate(SCNVector3(r, 0, 0))
        drawFramePosition += simd_float4(0, 0, 0, r)
        //let spin = CABasicAnimation(keyPath: "rotation")
    }
    
    func rotateY(_ r: Float){
        rotate(SCNVector3(0, r, 0))
        drawFramePosition += simd_float4(0, 0, 0, r)
    }
    
    func rotateZ(_ r: Float){
        rotate(SCNVector3(0, 0, r))
        drawFramePosition += simd_float4(0, 0, 0, r)
    }
    
    func shapeCreate(_ tag: String, _ geometry: SCNGeometry) {
        
        let newTag = tag + "position" + "x" + self.drawFramePosition.x.description + "y" + self.drawFramePosition.y.description + "z" + self.drawFramePosition.z.description + "w" + self.drawFramePosition.w.description
                
        if self.nodeShapes[newTag] == nil {
            
            let node = SCNNode(geometry: geometry)
            node.position = SCNVector3(x: 0, y: 0, z: 0)
            
            print(nodeShapes.count)
            
            let constraint = SCNLookAtConstraint(target: node)
            constraint.isGimbalLockEnabled = true
            cameraNode.constraints = [constraint]
            
            
            self.stackOfTransformationNodes.last!.addChildNode(node)
            
            self.nodeShapes[newTag] = node
            
        }
        
        self.currentNodes[newTag] = true
    }
    
    func sphere(_ radius: CGFloat){
        
        let tag: String = "Sphere" + radius.description + "x" +
            String(self.drawFramePosition.x) + "y" + String(self.drawFramePosition.y) + "z" +
        String(self.drawFramePosition.z)
        
        let sphereGeometry = SCNSphere(radius: (radius))
        
        sphereGeometry.isGeodesic = true
        sphereGeometry.segmentCount = 20
        
        shapeCreate(tag, sphereGeometry)
    }
    
    func box(_ w: CGFloat,_ h: CGFloat,_ l: CGFloat,_ rounded: CGFloat = 0){
        
        let tag: String = "Cube" + "width" + w.description + "height" + h.description
        + "length" + l.description + "chamfer" + rounded.description + "x"
            
        let boxGeometry = SCNBox(width: w, height: h, length: l, chamferRadius: rounded)
        
        shapeCreate(tag, boxGeometry)

    }
    
}

extension SCNVector3 {
    mutating func add(_ v1: SCNVector3){
        self.x += v1.x
        self.y += v1.y
        self.z += v1.z
    }
}
