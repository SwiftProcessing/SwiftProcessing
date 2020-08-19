import SceneKit
import Foundation


public extension Sketch {
    
    func ambientLight(_ v1: CGFloat, _v2: CGFloat, _v3: CGFloat, _ alpha: CGFloat = 1){
        self.lightNode.light?.type = SCNLight.LightType.ambient
        self.lightNode.light?.color = CGColor(srgbRed: v1, green: v2, blue: v3, alpha: alpha)
    }
    
    func ambientLight(_ gray: CGFloat, _ alpha: CGFloat = 1){
        self.lightNode.light?.type = SCNLight.LightType.ambient
        self.lightNode.light?.color = CGColor(genericGrayGamma2_2Gray: gray, alpha: alpha)
    }
    
    func createLight(_ tag: String, _ lightSCN: SCNLight, _type: String){
        
        var newtag = tag

        if var shapeNode = self.currentTransformationNode.getAvailableShape(newtag) {


        } else {

            let node = SCNNode(geometry: geometry)
            node.position = SCNVector3(x: 0, y: 0, z: 0)

            let constraint = SCNLookAtConstraint(target: node)
            constraint.isGimbalLockEnabled = true
            node.constraints = [constraint]
            
            node.light = lightSCN
            
            self.currentTransformationNode.addShapeNode(node,newtag)

        }
    }
    
    func pointLight(_ v1: CGFloat, _v2: CGFloat, _v3: CGFloat, _x: CGFloat, _y: CGFloat, _z: CGFloat){
        let light = SCNLight()
        light.type = SCNLight.LightType.spot
        
        light.color = CGColor(srgbRed: v1, green: v2, blue: v3, alpha: alpha)
        
        let tag = "SPOT" + "r" + v1 + "g" + v2 + "b" + v3 + "x" + x + "y" + y + "z" + z
        
        createLight(tag, light, _type: "SPOT")
    }
    
    func directionalLight(_ v1: CGFloat, _v2: CGFloat, _v3: CGFloat, _x: CGFloat, _y: CGFloat, _z: CGFloat){
        let light = SCNLight()
        light.type = SCNLight.LightType.directional
        
        light.color = CGColor(srgbRed: v1, green: v2, blue: v3, alpha: alpha)
        
        let tag = "DIRECTIONAL" + "r" + v1 + "g" + v2 + "b" + v3 + "x" + x + "y" + y + "z" + z
        
        createLight(tag, light, _type: "DIRECTIONAL")
    }
    
}


