/*
 * SwiftProcessing: Sketch Extension
 *
 * SwiftProcessing needs to be able to take in file names
 * with extensions so that it can behave appropriately.
 * This is helpful with media such as animated gifs, with
 * videos, and with sounds.
 *
 * */

import Foundation

extension String {

    func fileName() -> String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }

    func fileExtension() -> String {
        return URL(fileURLWithPath: self).pathExtension
    }
}
