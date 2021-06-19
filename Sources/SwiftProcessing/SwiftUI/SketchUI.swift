//
//  SketchUI.swift
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
    
    public var touches: [CGPoint] = []
    public var touchX: Double = 0
    public var touchY: Double = 0
    
    var context: GraphicsContext?
    var sketchDelegate: SketchDelegateUI?
    var fillColor: Color = Color.primary
    var prev: TimeInterval = Date().timeIntervalSinceReferenceDate
    
    var operations: [(GraphicsContext) -> Void] = []
    
    var flattenImage: SwiftUI.Image?
    var isFlattening = false
    let flattenTreshhold = 500
    
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
        // if operations already exceeds a threshnold N, flatten into a single image operation
        if !isFlattening && operations.count > flattenTreshhold {
            flatten()
        } else if let i = flattenImage {
            let w = self.width
            let h = self.height
            operations.replaceSubrange(0..<flattenTreshhold, with: [
                { context in
                        context.draw(i, in: CGRect(x: 0, y: 0, width: w, height: h))
                }
            ])
            flattenImage = nil
            isFlattening = false
        }
        sketchDelegate?.draw()
    }
    
    func flatten() {
        isFlattening = true
        let threshold = flattenTreshhold
        let c = Canvas { context, size in
            self.operations[0..<threshold].forEach { $0(context) }
        }
        .frame(width: self.width, height: self.height)
        .ignoresSafeArea()
        
        DispatchQueue.main.async { [weak self] in
            self?.flattenImage = SwiftUI.Image(uiImage: c.snapshot())
        }
    }
}

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
        let view = controller.view
        let size = controller.view.intrinsicContentSize
        
        view?.bounds = CGRect(origin: .zero, size: size)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: size)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
