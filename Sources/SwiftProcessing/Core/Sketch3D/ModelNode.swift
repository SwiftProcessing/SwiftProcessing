import UIKit
import SceneKit
import Foundation
import SceneKit.ModelIO

public class ModelNode: MDLObject{
    var tag: String = ""
    var mdlOject: MDLObject
    
    init(tag: String, mdlObject: MDLObject){
        self.mdlOject = mdlObject
        self.tag = tag
    }
}
