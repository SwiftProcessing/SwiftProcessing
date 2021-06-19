//
//  SketchDelegateUI.swift
//  
//
//  Created by Jonathan Kaufman on 6/10/21.
//

import Foundation

@available(iOS 15.0, *)
public protocol SketchDelegateUI: SketchUI {
    func setup()
    func draw()
}
