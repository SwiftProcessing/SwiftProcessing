//
//  Touch.swift
//  
//
//  Created by Jonathan Kaufman on 6/11/21.
//

import Foundation
import UIKit
import SwiftUI

@available(iOS 15.0, *)
extension SketchUI {
    func updateTouches(touches: [CGPoint]) {
        self.touches = touches
        // TODO touchX and touchY are equivalent to mouseX mouseY in P5. Two easy ways to easily jump into touch input without knowledge of arrays. Need to consider whether it always makes sense to use index 0 in multitouch case (vs last index)
        if let first = touches.first {
            touchX = first.x
            touchY = first.y
        }
    }
}

struct TouchListener: UIViewRepresentable {
    var touchesCallback: (([CGPoint]) -> Void)
    
    func makeUIView(context: UIViewRepresentableContext<TouchListener>) -> UIView {
        let v = TouchListenerUIView(frame: .zero)
        // TODO expose this as something that can be configured in Sketch
        v.isMultipleTouchEnabled = true
        v.touchCallback = { touchesCallback($0) }
        return v
    }
    
    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<TouchListener>) {
    }
    
}

class TouchListenerUIView: UIView {
    var touchCallback: ([CGPoint]) -> Void = { _ in }
    var touches: Set<UITouch> = []
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        touches.forEach {
            self.touches.insert($0)
        }
        touchCallback(self.touches.map { $0.location(in: self) })
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach {
            self.touches.remove($0)
            self.touches.insert($0)
        }
        touchCallback(self.touches.map { $0.location(in: self) })
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach {
            self.touches.remove($0)
        }
        touchCallback(self.touches.map { $0.location(in: self) })
    }
}
