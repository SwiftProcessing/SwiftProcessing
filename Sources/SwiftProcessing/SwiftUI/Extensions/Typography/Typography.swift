//
//  Typography.swift
//  
//
//  Created by Jonathan Kaufman on 6/10/21.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
extension SketchUI {
    struct TextCachable: Identifiable, Hashable {
        var id: String {
            "\(content) \(textSize) \(fillColor)"
        }
        var text: Text
        var content: String
        var textSize: CGFloat
        var fillColor: Color
        var operation: Int
        var includeInSymbols = true
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(fillColor)
            hasher.combine(textSize)
            hasher.combine(content)
        }
        
        init(content: String, fillColor: Color, textSize: CGFloat, operation: Int) {
            self.content = content
            self.fillColor = fillColor
            self.textSize = textSize
            self.operation = operation
            text = Text(content)
                .foregroundColor(fillColor)
                .font(.system(size: textSize))
        }
    }
    
    public func text(content: String, x: Double, y: Double) {
        let text = TextCachable(
            content: content,
            fillColor: settings.color.fillColor,
            textSize: settings.typography.textSize,
            operation: operations.count
        )
        
        loadedText.append(
            text
        )
        
        operations.append({ context in
            if let resolvedText = context.resolveSymbol(id: text.id) {
                context.draw(
                    resolvedText,
                    at: CGPoint(x: x, y: y),
                    anchor: .topLeading
                )
            } else {
                context.draw(
                    text.text,
                    at: CGPoint(x: x, y: y),
                    anchor: .topLeading
                )
            }
        })
    }
}
