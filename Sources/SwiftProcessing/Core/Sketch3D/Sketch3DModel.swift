import UIKit
import SceneKit
import Foundation
import SceneKit.ModelIO


public extension Sketch {

    func loadModelObj(_ assetName: String, _ extensionName: String) -> ModelNode {
        guard let url = Bundle.main.url(forResource: assetName, withExtension: extensionName)
             else { fatalError("Failed to find model file.") }

        let asset = MDLAsset(url:url)
        guard let object = asset.object(at: 0) as? MDLMesh
             else { fatalError("Failed to get mesh from asset.") }
        var tag = "model" + assetName + extensionName
        
        var modelObject = ModelNode(tag: tag, mdlObject: object)
        
        return modelObject
    }
    
    func model(_ mdlObject: ModelNode){
        if var shapeNode = self.currentTransformationNode.getAvailableShape(mdlObject.tag) {


        } else {
            let node = SCNNode(mdlObject: mdlObject.mdlOject)
            node.position = SCNVector3(x: 0, y: 0, z: 0)

            let constraint = SCNLookAtConstraint(target: node)
            constraint.isGimbalLockEnabled = true
            node.constraints = [constraint]

            self.currentTransformationNode.addShapeNode(node,mdlObject.tag)
        }
        
    }

}
