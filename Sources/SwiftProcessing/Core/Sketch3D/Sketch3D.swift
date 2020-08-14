import UIKit
import SceneKit

public extension Sketch {

    func preDraw3D(){

        self.lastFrameTransformationNodes = self.stackOfTransformationNodes
        self.stackOfTransformationNodes = [self.rootNode]
        self.rootNode.position = SCNVector3(0,0,0)
        self.rootNode.eulerAngles = SCNVector3(0,0,0)
        self.currentTransformationNode = self.rootNode

        for node in lastFrameTransformationNodes {
            node.addTransitionNodes()
            node.removeShapeNodes()
        }

        self.drawFramePosition = self.globalPosition
        
        self.scnmat = SCNMaterial()
    }

    func postDraw3D(){

        for node in lastFrameTransformationNodes {
            node.removeUnusedTransitionNodes()
        }

    }
}

extension SCNVector3 {
    mutating func add(_ v1: SCNVector3){
        self.x += v1.x
        self.y += v1.y
        self.z += v1.z
    }

    func equals(_ vector: SCNVector3)-> Bool {
        return self.x == vector.x && self.y == vector.y && self.z == vector.z
    }
}

extension SCNNode {

    func sameNode(_ vector: SCNVector3, _ property: String) -> Bool{

        if property == "rotation" {

            return vector.equals(self.eulerAngles)

        } else if property == "position" {

            return vector.equals(self.position)

        }

        return false

    }

    func sameNode(_ geometry: SCNGeometry) -> Bool{

        return self.geometry! == geometry

    }

    func cleanup() {
        for child in childNodes {
           child.cleanup()
        }
        self.constraints = []
        self.geometry?.materials = []
        self.geometry = nil
    }
}
