//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 11/2/19.
//
import UIKit

public extension Sketch{
    
    func frameRate() -> CGFloat{
        return fps
    }
    
    func frameRate(fps: CGFloat){
        self.fps = fps
    }
}
