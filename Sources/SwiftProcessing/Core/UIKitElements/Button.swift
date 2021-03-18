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
    
    open func textFont(_ name: String){
        (self.element as! UIButton).titleLabel?.font = UIFont(name: name, size: ((self.element as! UIButton).titleLabel?.font.pointSize)!)
    }
    
    open func textSize(_ size: CGFloat){
        (self.element as! UIButton).titleLabel?.font = UIFont(name: ((self.element as! UIButton).titleLabel?.font.fontName)!, size: size)
    }
    
    open func textColor(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 255){
        (self.element as! UIButton).setTitleColor(UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a / 255), for: .normal)
    }
    
}

extension Sketch {
    open func createButton(_ t: String = "") -> Button{
        let b = Button(self, t)
        viewRefs[b.id] = b
        return b
    }
    
    open func createButton(_ t: String = "", _ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) -> Button {
        let b = Button(self, t)
        b.position(x, y)
        b.size(w, h)
        viewRefs[b.id] = b
        return b
    }
}
