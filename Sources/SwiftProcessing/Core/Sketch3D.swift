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
        
        let baseTransformationNode = TransitionSCNNode()
        self.rootNode = baseTransformationNode
        self.stackOfTransformationNodes.append(baseTransformationNode)
        
        self.scene.rootNode.addChildNode(baseTransformationNode)
        self.scene.rootNode.addChildNode(lightNode)
        self.scene.rootNode.addChildNode(cameraNode)
    }
    
    func translationNode(_ vector: SCNVector3,_ property: String) {
        
        let lastNode = currentTransformationNode
        
        if lastNode.hasNoShapeNodes() {
            
            switch property {
                
            case "position":
                lastNode.position.add(vector)
                
            case "rotation":
                lastNode.eulerAngles.add(vector)
                
            default:
                print("Wrong translation property key word")
                
            }
                        
        } else if lastNode.hasAvailableTransitionNodes() {
            
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
            self.currentTransformationNode = nextNode
            
            print("!!!!!!")
            
        } else {
            
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
            self.currentTransformationNode = newTransformationNode

            
        }
        
        
        
//        if self.lastFrameAllNodes[self.currentNumber].sameNode(vector, property)  {
//
//            self.allNodes.append(self.lastFrameAllNodes[self.currentNumber])
//
//            self.stackOfTransformationNodes.append(self.lastFrameAllNodes[self.currentNumber] as! TransitionSCNNode)
//
//        } else {
//
//            self.lastFrameAllNodes[self.currentNumber].removeFromParentNode()
//
//            let newTransformationNode: TransitionSCNNode = TransitionSCNNode()
//
//            lastNode.addChildNode(newTransformationNode)
//
//            self.allNodes.append(newTransformationNode)
//
//            self.stackOfTransformationNodes.append(newTransformationNode)
//
//            switch property {
//            case "position":
//                newTransformationNode.position = vector
//
//            case "rotation":
//                newTransformationNode.eulerAngles = vector
//            default:
//                print("Wrong translation property key word")
//            }
//
//        }
        
        //self.currentNumber += 1
        
    }
    
    func translate(_ x: Float, _ y: Float, _ z: Float){
        
        let tempPosition: SCNVector3 = SCNVector3(x,y,z)
        
        self.translationNode(tempPosition, "position")
        
        drawFramePosition += simd_float4(x, y, z, 0)
    }
    
    func rotate(_ x: Float, _ y: Float, _ z: Float){
        
        let tempRotation: SCNVector3 = SCNVector3(x,y,z)
        
        self.translationNode(tempRotation, "rotation")
        
        drawFrameRotation += simd_float4(x,y,z,0)
    }
    
    func rotateX(_ r: Float){
        rotate(r, 0, 0)
        drawFramePosition += simd_float4(0, 0, 0, r)
    }
    
    func rotateY(_ r: Float){
        rotate(0, r, 0)
        drawFramePosition += simd_float4(0, 0, 0, r)
    }
    
    func rotateZ(_ r: Float){
        rotate(0, 0, r)
        drawFramePosition += simd_float4(0, 0, 0, r)
    }
    
    func shapeCreate(_ tag: String, _ geometry: SCNGeometry,_ type: String) {
        
        let newTranslationTag =  "position" + "x" + self.drawFramePosition.x.description + "y" + self.drawFramePosition.y.description + "z" + self.drawFramePosition.z.description
        
        let newRotationTag = "rotation" + "x" + self.drawFrameRotation.x.description + "y" + self.drawFrameRotation.y.description + "z" + self.drawFrameRotation.z.description
        
        let newTag = tag + newTranslationTag + newRotationTag
        
//        if self.currentTransformationNode.availableShapeNodes[type]?.count > 0 {
//
//            self.currentTransformationNode.availableShapeNodes.popFirst().
//
//        } else {
            
            let node = SCNNode(geometry: geometry)
            node.position = SCNVector3(x: 0, y: 0, z: 0)
                        
            let constraint = SCNLookAtConstraint(target: node)
            constraint.isGimbalLockEnabled = true
            node.constraints = [constraint]
            
            self.currentTransformationNode.addShapeNode(node)
            
//        }
    }
    
    func sphere(_ radius: CGFloat){
        
        let tag: String = "Sphere" + radius.description
        
        let sphereGeometry = SCNSphere(radius: (radius))
        
        sphereGeometry.isGeodesic = true
        sphereGeometry.segmentCount = 20
        
        shapeCreate(tag, sphereGeometry, "Sphere")
    }
    
    func box(_ w: CGFloat,_ h: CGFloat,_ l: CGFloat,_ rounded: CGFloat = 0){
        
        let tag: String = "Cube" + "width" + w.description + "height" + h.description
            + "length" + l.description + "chamfer" + rounded.description
        
        let boxGeometry = SCNBox(width: w, height: h, length: l, chamferRadius: rounded)
        
        shapeCreate(tag, boxGeometry, "Box")
        
    }
    
    func beforeNodes(){
        
        self.lastFrameTransformationNodes = self.stackOfTransformationNodes
        self.stackOfTransformationNodes = [self.rootNode]
        self.rootNode.position = SCNVector3(0,0,0)
        self.rootNode.eulerAngles = SCNVector3(0,0,0)
        self.currentTransformationNode = self.rootNode
        
        for node in lastFrameTransformationNodes {
            print(node.childNodes.count)
            node.addTransitionNodes()
            node.removeShapeNodes()
        }
        
        
//        self.lastFrameAllNodes = self.allNodes
//        self.currentTransformationNode = self.rootNode
//        self.allNodes = []
//        self.currentNodes = [:]
        
        
        self.drawFramePosition = self.globalPosition
        
    }
    
//    func removeUnusedNodes(){
//
//        for (tag,node) in self.nodeShapes {
//            if self.currentNodes[tag] == nil {
//                node.removeFromParentNode()
//                self.nodeShapes.removeValue(forKey: tag)
//            }
//        }
//
//    }
    
    func mergeUnusedTranslationNodes(){
        
        if self.stackOfTransformationNodes.count > 2 {
            for child in self.stackOfTransformationNodes.dropFirst().dropLast() {
                if child.childNodes.count == 1 {
                    child.childNodes.first!.position.add(child.position)
                    child.childNodes.first!.eulerAngles.add(child.eulerAngles)
                    child.parent?.addChildNode(child.childNodes.first!)
                    child.removeFromParentNode()
                    // Not sure if this works
                    self.stackOfTransformationNodes = self.stackOfTransformationNodes.filter(){$0 != child}
                }
            }
            
        }
    }
    
    func updateNodes(){
        
        for node in lastFrameTransformationNodes {
            node.removeUnusedTransitionNnodes()
        }
//        print(nodeShapes.count)
//        print(currentNodes.count)
        print(lastFrameTransformationNodes.count)
//        print(allNodes.count)
        print(stackOfTransformationNodes.count)
        print(lastFrameTransformationNodes.count)
//        print(mapParents.count)
        
//        removeUnusedNodes()
//
//        mergeUnusedTranslationNodes()
        
        
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
        self.geometry = nil
    }
}

class TransitionSCNNode: SCNNode {
    
    var parentTransitionNodeTag: String = ""
    var tag: String = ""
    var availabletransitionNodes: [TransitionSCNNode] = []
    var currentShapes: [SCNNode] = []
    var availableShapeNodes: [String : [SCNNode]] = [:]
    
    func hasNoShapeNodes() -> Bool {
        return self.currentShapes.count == 0
    }
    
    func hasAvailableTransitionNodes() -> Bool {
        return self.availabletransitionNodes.count > 0
    }
    
    func getNextAvailableTransitionNode() -> TransitionSCNNode {
        return self.availabletransitionNodes.popLast()!
    }
    
    func removeUnusedTransitionNnodes() {
        for node in self.availabletransitionNodes {
            node.removeFromParentNode()
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
    
    func addShapeNode(_ node: SCNNode) {
        self.addChildNode(node)
        self.currentShapes.append(node)
    }
        
    func removeShapeNodes() {
//        var c = currentShapes.count
//        while currentShapes.count > 0 {
//            currentShapes.popLast()?.removeFromParentNode()
//        }
        for shapes in currentShapes {
            shapes.cleanup()
            shapes.removeFromParentNode()
            
        }
        currentShapes = []
    }
}
