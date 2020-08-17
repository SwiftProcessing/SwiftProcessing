import UIKit
import SceneKit

class TransitionSCNNode: SCNNode {

    var parentTransitionNodeTag: String = ""
    var tag: String = ""
    var availabletransitionNodes: [TransitionSCNNode] = []
    var currentShapes: [SCNNode] = []
    var availableShapeNodes: [String : [SCNNode]] = [:]
    var currentShapeNodes: [String : [SCNNode]] = [:]

    func hasNoShapeNodes() -> Bool {
        return self.currentShapes.count == 0
    }

    func hasAvailableTransitionNodes() -> Bool {
        return self.availabletransitionNodes.count > 0
    }

    func getNextAvailableTransitionNode() -> TransitionSCNNode {
        return self.availabletransitionNodes.popLast()!
    }

    func deleteTransitionNode() {
        for node in self.availabletransitionNodes {
            node.deleteTransitionNode()
        }
        self.availabletransitionNodes = []
        self.removeFromParentNode()
        self.removeShapeNodes()
    }

    func removeUnusedTransitionNodes() {
        for node in self.availabletransitionNodes {
            node.deleteTransitionNode()
        }

        availabletransitionNodes = []
    }

    func addTransitionNodes() {
        for node in self.childNodes {
            if node is TransitionSCNNode {
                self.availabletransitionNodes.append(node as! TransitionSCNNode)
            }
        }
    }

    func addShapeNode(_ node: SCNNode, _ tag: String) {
        self.addChildNode(node)
        self.currentShapes.append(node)
        if var arrayOfAvailableShapes = self.currentShapeNodes[tag] {
            arrayOfAvailableShapes.append(node)
        } else {
            self.currentShapeNodes[tag] = [node]
        }
    }

    func hasAvailableShape(_ tag: String) -> Bool{
        return self.availableShapeNodes[tag]!.count > 0
    }

    func getAvailableShape(_ tag: String) -> SCNNode? {
        if self.availableShapeNodes[tag] != nil && self.availableShapeNodes[tag]!.count > 0 {
            let usedNode = self.availableShapeNodes[tag]!.popLast()
            if var arrayOfAvailableShapes = self.currentShapeNodes[tag] {
                arrayOfAvailableShapes.append(usedNode!)
            } else {
                self.currentShapeNodes[tag] = [usedNode!]
            }
            self.currentShapes.append(usedNode!)
            return usedNode
        }
        return nil
    }

    func removeShapeNodes() {
        for (key, arrayOfShapes) in self.availableShapeNodes {
            for shapes in arrayOfShapes {
                shapes.cleanup()
                shapes.removeFromParentNode()
            }
        }
        self.availableShapeNodes = self.currentShapeNodes
        self.currentShapeNodes = [:]
        self.currentShapes = []
    }

    func addNewTransitionNode() -> TransitionSCNNode{

        if self.hasAvailableTransitionNodes() {

            let nextNode = self.getNextAvailableTransitionNode()

            nextNode.position = SCNVector3(0,0,0)
            nextNode.eulerAngles = SCNVector3(0,0,0)

            return nextNode

        } else {

            let newTransitionNode = TransitionSCNNode()

            self.addChildNode(newTransitionNode)

            newTransitionNode.position = SCNVector3(0,0,0)
            newTransitionNode.eulerAngles = SCNVector3(0,0,0)

            return newTransitionNode

        }

    }
}
