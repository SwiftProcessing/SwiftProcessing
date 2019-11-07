//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 11/7/19.
//

import Foundation
import UIKit

public extension Sketch{
    func random(_ start: CGFloat = 0, _ end: CGFloat = 1) -> CGFloat{
        return CGFloat.random(in: start...end)
    }
}
