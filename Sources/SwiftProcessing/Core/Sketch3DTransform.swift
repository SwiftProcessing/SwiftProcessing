import UIKit
import SceneKit

public extension Sketch {

    func translationNode(_ vector: SCNVector3,_ property: String, _ checkNoShapeNodes: Bool = true, _ changeCurrentTransitionNode: Bool = true) {
        let lastNode = currentTransformationNode

        if lastNode.hasAvailableTransitionNodes() {
            // select node from available nodes from last frome branching off
            // current transition node
            let nextNode = lastNode.getNextAvailableTransitionNode()

            switch property {

            case "position":
                nextNode.position = vector
                nextNode.eulerAngles = SCNVector3(0,0,0)

            case "rotation":
                nextNode.eulerAngles = vector
                nextNode.position = SCNVector3(0,0,0)

            default:
                print("Wrong translation property key word")

            }
            self.stackOfTransformationNodes.append(nextNode)

            // changeCurrentTransitionNode enabled default
            // determines if future nodes will branch off this node
            if (changeCurrentTransitionNode){
                self.currentTransformationNode = nextNode
            }

        } else {
            // creating new node because no nodes available
            let newTransformationNode: TransitionSCNNode = TransitionSCNNode()

            lastNode.addChildNode(newTransformationNode)

            switch property {
            case "position":
                newTransformationNode.position = vector

            case "rotation":
                newTransformationNode.eulerAngles = vector
            default:
                print("Wrong translation property key word")
            }
            self.stackOfTransformationNodes.append(newTransformationNode)

            if (changeCurrentTransitionNode){
                self.currentTransformationNode = newTransformationNode
            }

        }

    }

    func translate(_ x: Float, _ y: Float, _ z: Float){

        let tempPosition: SCNVector3 = SCNVector3(x,y,z)

        self.translationNode(tempPosition, "position")

    }

    func rotate(_ x: Float, _ y: Float, _ z: Float){

        let tempRotation: SCNVector3 = SCNVector3(x,y,z)

        self.translationNode(tempRotation, "rotation")
    }

    func rotateX(_ r: Float){
        rotate(r, 0, 0)
    }

    func rotateY(_ r: Float){
        rotate(0, r, 0)
    }

    func rotateZ(_ r: Float){
        rotate(0, 0, r)
    }

}
