import Foundation
import UIKit

open class TextField: UIKitControlElement {
    init(_ view: UIView, _ title: String) {
        let textField = UITextField()
        textField.placeholder = title
        textField.sizeToFit()
        super.init(view, textField)
    }
}

extension Sketch{
    open func createTextField(_ t: String = "") -> TextField{
        let t = TextField(self, t)
        viewRefs[t.id] = t
        return t
    }
}
