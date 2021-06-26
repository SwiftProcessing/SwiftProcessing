//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 6/26/21.
//

import Foundation
@available(iOS 15.0, *)
public extension SketchUI {
    
    func storeItem(_ key: String, _ value: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    func storeItem(_ key: String, _ value: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    func storeItem(_ key: String, _ value: Double) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    func storeItem(_ key: String, _ value: Float) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    func storeItem(_ key: String, _ value: Int) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    func getItem(_ key: String) -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: key)
    }
    
    func getItem(_ key: String) -> Bool? {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: key)
    }
    
    func getItem(_ key: String) -> Double? {
        let defaults = UserDefaults.standard
        return defaults.double(forKey: key)
    }
    
    func getItem(_ key: String) -> Float? {
        let defaults = UserDefaults.standard
        return defaults.float(forKey: key)
    }
    
    func getItem(_ key: String) -> Int? {
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: key)
    }
    
    func clearStorage() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
    
    func removeItem(_ key: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
    }
}
