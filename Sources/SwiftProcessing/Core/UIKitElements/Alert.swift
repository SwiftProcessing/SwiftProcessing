import Foundation
import UIKit

open class Alert {
    
    var alert: UIAlertController
    
    init(_ title: String, _ message: String, _ preferredStyle: UIAlertController.Style? = UIAlertController.Style.alert) {
        self.alert = UIAlertController(title: title,message: message, preferredStyle: preferredStyle!)
    }
    
    init(_ error: NSError) {
        self.alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        self.addAction(title: "Ok", style: .cancel, handler: nil )
    }
    
    public  func show() {
        DispatchQueue.main.async {
            UIApplication.topViewController?.present(self.alert, animated: true, completion: nil)
        }
    }
    
    public func addAction(title: String, style: UIAlertAction.Style = UIAlertAction.Style.default, handler: ((UIAlertAction) -> Void)?) {
        self.alert.addAction(UIAlertAction(title: title, style: style, handler: handler))
    }
    
}

