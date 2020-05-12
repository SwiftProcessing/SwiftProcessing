//
//  Button.swift
//  
//
//  Created by Jonathan Kaufman on 4/9/20.
//

import Foundation
import UIKit

open class Button: UIKitControlElement {
    var image: Image!
    
    init(_ view: Sketch, _ title: String) {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.sizeToFit()
        super.init(view, button)
    }
    
    open func image(_ i: Image){
        (self.element as! UIButton).setImage(i.uiImage[0], for: .normal)
    }
    
}

extension Sketch{
    open func createButton(_ t: String = "") -> Button{
        let b = Button(self, t)
        viewRefs[b.id] = b
        return b
    }
}
