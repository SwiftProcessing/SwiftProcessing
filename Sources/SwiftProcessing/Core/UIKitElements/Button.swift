//
//  Button.swift
//  
//
//  Created by Jonathan Kaufman on 4/9/20.
//

import Foundation
import UIKit

open class Button: UIKitControlElement {
    init(_ view: UIView, _ title: String) {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.sizeToFit()
        super.init(view, button)
    }
}

extension Sketch{
    open func createButton(_ t: String = "") -> Button{
       let b = Button(self, t)
        refs.append(b)
        return b
    }
}
