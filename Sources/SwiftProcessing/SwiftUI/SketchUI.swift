//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 6/10/21.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
open class SketchUI {
    public var width: Double = 0
    public var height: Double = 0
    public var deltaTime: Double = 0
    
    var context: GraphicsContext?
    var sketchDelegate: SketchDelegateUI?
    var fillColor: Color = Color.primary
    var prev: TimeInterval = Date().timeIntervalSinceReferenceDate
    
    public init() {
        self.sketchDelegate = self as? SketchDelegateUI
    }
    
    func updateContext(_ context: GraphicsContext, _ size: CGSize, _ time: TimeInterval) {
        self.context = context
        self.width = size.width
        self.height = size.height
        self.deltaTime = time - prev
        self.prev = time
    }
    
    func display() {
        sketchDelegate?.draw()
    }
}
