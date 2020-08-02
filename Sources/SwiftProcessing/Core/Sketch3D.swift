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
        self.lightNode.position = SCNVector3(x: 0, y: 0, z: 50)
        
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
        
        let newtag = tag + "r" + self.settings.fill.red.description + "g" + self.settings.fill.green.description + "b" + self.settings.fill.blue.description + "a" + self.settings.fill.alpha.description
        
        if var shapeNode = self.currentTransformationNode.getAvailableShape(newtag) {
            
    
        } else {
            
            geometry.firstMaterial?.diffuse.contents = UIColor(red: self.settings.fill.red/255.0, green: self.settings.fill.green/255.0, blue: self.settings.fill.blue/255.0, alpha: self.settings.fill.alpha)
            
            let node = SCNNode(geometry: geometry)
            node.position = SCNVector3(x: 0, y: 0, z: 0)
                        
            let constraint = SCNLookAtConstraint(target: node)
            constraint.isGimbalLockEnabled = true
            node.constraints = [constraint]
            
            self.currentTransformationNode.addShapeNode(node,newtag)
            
        }
            
    }
    
    func sphere(_ radius: CGFloat){
        
        let tag: String = "Sphere" + radius.description
        
        let sphereGeometry = SCNSphere(radius: (radius))
        
        sphereGeometry.isGeodesic = true
        sphereGeometry.segmentCount = 20
        
        shapeCreate(tag, sphereGeometry, "Sphere")
    }
    
    func cylinder(_ width: CGFloat, _ height: CGFloat){
        
        let tag: String = "Cylinder" + "w" + width.description + "h" + height.description
        
        let cylinderGeometry = SCNCylinder(radius: width,height: height)
        
        
        shapeCreate(tag, cylinderGeometry, "Cylinder")
        
    }
    
    func cone(_ topRadius: CGFloat, _ bottomRadius: CGFloat, _ height: CGFloat){
        
        let tag: String = "Cone" + "r" + topRadius.description + "r" + bottomRadius.description + "h" + height.description
        
        let coneGeometry = SCNCone(topRadius: topRadius,bottomRadius: bottomRadius, height: height)
        
        shapeCreate(tag, coneGeometry, "Cone")
        
    }
    
    func pyramid(_ width: CGFloat, _ height: CGFloat, _ length: CGFloat){
        
        let tag: String = "Pyramid" + "w" + width.description + "h" + height.description + "l" + length.description
        
        let pyramidGeometry = SCNPyramid(width: width,height: height,length: length)
        
        shapeCreate(tag, pyramidGeometry, "Pyramid")
        
    }
    
    func capsule(_ radius: CGFloat, _ height: CGFloat, _ length: CGFloat) {
        
        let tag: String = "Capsule" + "r" + radius.description + "h" + height.description
        
        let capsuleGeomtry = SCNPyramid(width: radius,height: height, length: length)
        
        shapeCreate(tag, capsuleGeomtry, "Capsule")
        
    }
    
    func torus(_ ringRadius: CGFloat, _ pipeRadius: CGFloat) {
        
        let tag: String = "Torus" + "rr" + ringRadius.description + "pr" + pipeRadius.description
        
        let torusGeomtry = SCNTorus(ringRadius: ringRadius,pipeRadius: pipeRadius)
        
        shapeCreate(tag, torusGeomtry, "Torus")
        
    }
    
    func plane(_ width: CGFloat, _ height: CGFloat){
        
        let tag: String = "Plane" + "w" + width.description + "h" + height.description
        
        let planeGeometry = SCNPlane(width: width,height: height)
        
        shapeCreate(tag, planeGeometry, "Plane")
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
            node.addTransitionNodes()
            node.removeShapeNodes()
        }
        
        self.drawFramePosition = self.globalPosition
        
    }
    
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
        self.geometry = nil
    }
}

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
}
