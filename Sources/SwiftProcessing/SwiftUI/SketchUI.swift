//
//  SketchUI.swift
//  
//
//  Created by Jonathan Kaufman on 6/10/21.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
open class SketchUI: ObservableObject{
    @Published
    var isPaused: Bool = false
    
    // TODO init to refresh rate of screen to better support iPad Pro / future iPhones
    @Published
    var targetFrameRate: Double = 1 / 60
    
    var loadedImages: [Image] = []
    
    var loadedText: [TextCachable] = []
    
    public var width: Double = 0
    public var height: Double = 0
    public var deltaTime: Double = 0
    
    public var touches: [CGPoint] = []
    public var touchX: Double = 0
    public var touchY: Double = 0
    
    var context: GraphicsContext?
    var sketchDelegate: SketchDelegateUI?
    var prev: TimeInterval = Date().timeIntervalSinceReferenceDate
    var frameCount: Int = 0
    
    // Organize into seperate struct
    var fillColor: Color = Color.primary
    var textSize: Double = 20
    
    // Organize into seperate struct
    var operations: [(GraphicsContext) -> Void] = []
    var flattenImage: SwiftUI.Image?
    var isFlattening = false
    // TODO what is the best flatten threshhold... should it even be static?
    let flattenTreshhold = 25
    
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
        if frameCount == 0 {
            sketchDelegate?.setup()
        }
        // if operations already exceeds a threshnold N, flatten into a single image operation
        if !isFlattening && operations.count > flattenTreshhold {
            flatten()
        } else if let i = flattenImage {
            let w = self.width
            let h = self.height
            operations.replaceSubrange(
                0..<flattenTreshhold,
                with: [
                    { context in
                            context.draw(i, in: CGRect(x: 0, y: 0, width: w, height: h))
                    }
                ]
            )
            flattenImage = nil
            isFlattening = false

        }
        sketchDelegate?.draw()
        frameCount += 1
    }
    
    func flatten() {
        isFlattening = true
        let threshold = flattenTreshhold
        let c = Canvas(renderer: { context, size in
            self.operations[0..<threshold].forEach { $0(context) }
        }, symbols: {
            ForEach(self.loadedImages) { image in
                image.view
            }
            ForEach(Array(self.loadedText)) { text in
                text.text.tag(text.id)
            }
        })
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
