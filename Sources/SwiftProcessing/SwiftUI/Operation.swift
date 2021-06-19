//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 6/19/21.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
struct Operation {
    var name: OperationType
    var execute: (GraphicsContext) -> Void
}

enum OperationType {
    case circle
    case fill
}
