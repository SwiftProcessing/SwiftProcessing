import UIKit
import SceneKit

public extension Sketch {

    func shapeCreate(_ tag: String, _ geometry: SCNGeometry,_ type: String) {

        var colorTag =  "r" + self.settings.fill.red.description + "g" + self.settings.fill.green.description + "b" + self.settings.fill.blue.description + "a" + self.settings.fill.alpha.description

        var materialTag =  String(UInt(bitPattern: ObjectIdentifier(self.scnmat)))

        var newtag = tag + colorTag + materialTag

        if var shapeNode = self.currentTransformationNode.getAvailableShape(newtag) {

        } else {
            geometry.firstMaterial?.diffuse.contents = UIColor(red: CGFloat(self.settings.fill.red/255.0), green: CGFloat(self.settings.fill.green/255.0), blue: CGFloat(self.settings.fill.blue/255.0), alpha: CGFloat(self.settings.fill.alpha))

            if self.texture != nil && self.textureEnabled {
                geometry.firstMaterial?.diffuse.contents = self.texture!.currentFrame()
                newtag = newtag + self.textureID

            }

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

}
