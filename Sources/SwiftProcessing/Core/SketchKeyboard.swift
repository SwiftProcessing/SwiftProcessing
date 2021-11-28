/*
 * Swift Processing Keyboard
 *
 * An interface for keyboard interaction
 *
 */

import Foundation
import UIKit

// =======================================================================
// MARK: - STRING EXTENSION
// =======================================================================

// A good explanation of why subscripting of String is unavailable in Swift by default.
// Source: https://github.com/apple/swift/blob/274c1097bbf01678a708cf7c8804a4089c7430ae/stdlib/public/core/UnavailableStringAPIs.swift.gyb#L13-L52
// Source: https://stackoverflow.com/a/24144365/4245343
// Code implemented here: https://stackoverflow.com/a/38215613/4245343

extension StringProtocol {
    subscript(_ offset: Int) -> Element {
        self[index(startIndex, offsetBy: offset)]
    }
    
    subscript(_ range: Range<Int>) -> SubSequence {
        prefix(range.lowerBound+range.count).suffix(range.count)
    }
    
    subscript(_ range: ClosedRange<Int>) -> SubSequence {
        prefix(range.lowerBound+range.count).suffix(range.count)
    }
    
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence {
        prefix(range.upperBound.advanced(by: 1))
    }
    
    subscript(_ range: PartialRangeUpTo<Int>) -> SubSequence {
        prefix(range.upperBound)
    }
    
    subscript(_ range: PartialRangeFrom<Int>) -> SubSequence {
        suffix(Swift.max(0, count-range.lowerBound))
    }
}

// =======================================================================
// MARK: - KEYBOARD PROTOCOL
// =======================================================================

public protocol Keyboard: Sketch {
}

// =======================================================================
// MARK: - KEYBOARD EXTENSION
// =======================================================================

extension Sketch: Keyboard {
    
    // Source: https://developer.apple.com/videos/play/wwdc2020/10109/
    open override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {

        if #available(iOS 13.4, *) {
            keyPressed = true
        } else {
            print("Keyboard functionality requires iOS 13.4 or later.")
        }
        
        for press in presses {
            guard let pressKey = press.key else { continue }
            
            if #available(iOS 13.4, *) {
                self.keyCode = convertModifierKey(key: pressKey)
                self.key = pressKey.charactersIgnoringModifiers.isEmpty ? "\0"
                 : pressKey.characters[0]
                if self.keyCode == KeyCode.none {
                    sketchDelegate?.keyTyped?()
                }
                sketchDelegate?.keyPressed?()
            } else {
            }
        }
    }
    
    open override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {

        if #available(iOS 13.4, *) {
            keyPressed = false
        }
        
        for press in presses {
            if #available(iOS 13.4, *) {
                sketchDelegate?.keyReleased?()
            } else {
            }
        }
    }
    
    @available(iOS 13.4, *)
    private func convertModifierKey(key: UIKey) -> KeyCode {
        switch key.keyCode {
        case .keyboardLeftArrow:
            return KeyCode.left
        case .keyboardRightArrow:
            return KeyCode.right
        case .keyboardUpArrow:
            return KeyCode.up
        case .keyboardDownArrow:
            return KeyCode.down
        case .keyboardLeftAlt:
            return KeyCode.option
        case .keyboardRightAlt:
            return KeyCode.option
        case .keyboardLeftGUI:
            return KeyCode.command
        case .keyboardRightGUI:
            return KeyCode.command
        case .keyboardLeftControl:
            return KeyCode.control
        case .keyboardRightControl:
            return KeyCode.control
        case .keyboardTab:
            return KeyCode.tab
        case .keyboardEscape:
            return KeyCode.esc
        case .keyboardDeleteOrBackspace:
            return KeyCode.backspace
        default:
            return KeyCode.none
        }
    }
}
