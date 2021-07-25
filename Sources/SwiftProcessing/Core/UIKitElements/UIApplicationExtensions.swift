import Foundation
import UIKit

extension UIApplication {
    
    // keyWindow replacement source: https://stackoverflow.com/questions/57134259/how-to-resolve-keywindow-was-deprecated-in-ios-13-0/57899013
    private class func topViewController(controller: UIViewController? =
                                            UIApplication
                                            .shared
                                            .connectedScenes
                                            .filter({$0.activationState == .foregroundActive})
                                            .map({$0 as? UIWindowScene})
                                            .compactMap({$0})
                                            .first?.windows
                                            .filter({$0.isKeyWindow}).first!
                                            .rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    class var topViewController: UIViewController? { return topViewController() }
    
}
