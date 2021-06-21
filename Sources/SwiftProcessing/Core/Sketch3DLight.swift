import SceneKit
import Foundation


public extension Sketch {
    
    func ambientLight(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ alpha: CGFloat = 1){
        self.ambientLightNode.light?.type = SCNLight.LightType.ambient
        self.ambientLightNode.light?.color = CGColor(srgbRed: v1, green: v2, blue: v3, alpha: alpha)
    }
    
    func ambientLight(_ gray: CGFloat, _ alpha: CGFloat = 1){
        self.ambientLightNode.light?.type = SCNLight.LightType.ambient
        self.ambientLightNode.light?.color = CGColor(genericGrayGamma2_2Gray: gray, alpha: alpha)
    }
    
    func createLight(_ tag: String, _ lightSCN: SCNLight, _type: String){
        
        let newtag = tag
        
        if(self.currentTransformationNode.getAvailableShape(newtag) == nil) {

            let node = SCNNode()
            node.position = SCNVector3(x: 0, y: 0, z: 0)

            let constraint = SCNLookAtConstraint(target: node)
            constraint.isGimbalLockEnabled = true
            node.constraints = [constraint]
            
            node.light = lightSCN
            
            self.currentTransformationNode.addShapeNode(node,newtag)

        }
    }
    
    func pointLight(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ x: CGFloat, _ y: CGFloat, _ z: CGFloat){
        let light = SCNLight()
        light.type = SCNLight.LightType.spot
        light.color = CGColor(srgbRed: v1, green: v2, blue: v3, alpha: alpha)
        
        let tag = "SPOT" + "r" + v1.description + "g" + v2.description + "b" + v3.description
        
        let positiontag = "x" + x.description + "y" + y.description + "z" + z.description
        
        let newtag = tag + positiontag
        
        createLight(newtag, light, _type: "SPOT")
    }
    
    func directionalLight(_ v1: CGFloat, _ v2: CGFloat, _ v3: CGFloat, _ x: CGFloat, _ y: CGFloat, _ z: CGFloat){
        let light = SCNLight()
        light.type = SCNLight.LightType.directional
        light.color = CGColor(srgbRed: v1, green: v2, blue: v3, alpha: alpha)
        
        let tag = "SPOT" + "r" + v1.description + "g" + v2.description + "b" + v3.description
        
        let positiontag = "x" + x.description + "y" + y.description + "z" + z.description
        
        let newtag = tag + positiontag
        
        createLight(newtag, light, _type: "DIRECTIONAL")
    }
    
}


