import Foundation

extension Notification.Name{
    static let sketchEvent = Notification.Name("sketchEvent")
}

public extension Sketch{
    func initNotifications(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(genericSelector(_:)),
            name: .sketchEvent,
            object: nil)
    }
    
    func broadcast(_ eventName: String, _ data: [AnyHashable : Any]? = [:]){
        var newData = data
        newData!["eventName"] = eventName
        NotificationCenter.default.post(name: .sketchEvent, object: nil, userInfo: newData)
    }
    
    func listen(_ eventName: String, _ action: @escaping (_ data: [AnyHashable : Any]) -> Void){
        self.notificationActionsWithData[eventName] = action
    }
    
    func listen(_ eventName: String, _ action: @escaping () -> Void){
        self.notificationActions[eventName] = action
    }
    
    @objc func genericSelector(_ notification: Notification){
        if let eventName = notification.userInfo?["eventName"] as? String{
            self.notificationActionsWithData[eventName]?(notification.userInfo ?? [:])
            self.notificationActions[eventName]?()
        }
    }
    
}
