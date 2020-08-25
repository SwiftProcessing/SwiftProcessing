import UIKit
import SceneKit

public extension Sketch {

    func create3D(){

        let sceneView = SCNView(frame: self.frame)
        self.addSubview(sceneView)

        self.scene = SCNScene()
        sceneView.scene = scene
        
        self.lookAtNode = SCNNode()
        self.lookAtNode.position = SCNVector3(x: 0, y: 0, z: 0)
        
        let camera = SCNCamera()
        self.cameraNode = SCNNode()
        self.cameraNode.camera = camera
        self.cameraNode.position = SCNVector3(x: 0, y: 0, z: 100)
        
        let lookAtConstraint = SCNLookAtConstraint(target: self.lookAtNode)
        self.cameraNode.constraints = [lookAtConstraint]

        let light = SCNLight()
        light.type = SCNLight.LightType.omni
        self.lightNode = SCNNode()
        self.lightNode.light = light
        self.lightNode.position = SCNVector3(x: 0, y: 0, z: 110)

        let baseTransformationNode = TransitionSCNNode()
        self.rootNode = baseTransformationNode

        self.scene.rootNode.addChildNode(baseTransformationNode)
        self.scene.rootNode.addChildNode(lightNode)
        self.scene.rootNode.addChildNode(lookAtNode)
        self.scene.rootNode.addChildNode(cameraNode)

        self.enable3DMode = true
    }

}
