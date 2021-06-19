//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 6/19/21.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
extension SketchUI {
    public struct Image: Identifiable {
        public var id = UUID()
        var view: AnyView
        init(view: SwiftUI.Image) {
            self.view = AnyView(view.tag(id))
        }
    }
    public func loadImage(name: String) -> Image {
        let img = Image(view: SwiftUI.Image(name))
        loadedImages.append(img)
        return img
    }
    
    public func image(image: SwiftUI.Image, x: Double, y: Double, width: Double, height: Double) {
        operations.append(
            { context in
            context.draw(image, in: CGRect(x: x, y: y, width: width, height: height))
        }
        )
    }
    public func image(image: Image, x: Double, y: Double, width: Double, height: Double) {
        operations.append(
            { context in
            if let resolvedImage = context.resolveSymbol(id: image.id) {
                context.draw(resolvedImage, in: CGRect(x: x, y: y, width: width, height: height))
            }
        }
        )
    }
}


