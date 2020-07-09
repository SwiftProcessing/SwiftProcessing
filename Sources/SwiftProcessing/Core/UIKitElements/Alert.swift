import Foundation
import UIKit

open class Alert {
    
    var alert: UIAlertController
    
    init(_ title: String, _ message: String, _ preferredStyle: UIAlertController.Style? = UIAlertController.Style.alert) {
        self.alert = UIAlertController(title: title,message: message, preferredStyle: preferredStyle!)
    }
    
    init(_ error: NSError) {
        self.alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        self.addAction("Ok")
    }
    
    public func show() {
        DispatchQueue.main.async {
            UIApplication.topViewController?.present(self.alert, animated: true, completion: nil)
        }
    }
    
    public func addAction(_ title: String, _ style: UIAlertAction.Style = UIAlertAction.Style.default, handler: ((UIAlertAction) -> Void)?) {
        self.alert.addAction(UIAlertAction(title: title, style: style, handler: handler))
    }
    
    public func addAction(_ title: String, _ style: UIAlertAction.Style = UIAlertAction.Style.default, handler: (() -> Void)? = nil) {
        self.alert.addAction(UIAlertAction(title: title, style: style, handler: {
            action in
            handler?()
        }))
    }
    
}

public extension Sketch {
    func createAlert(_ title: String, _ message: String) -> Alert{
        return Alert(title, message)
    }
}
