//
//  ExplodingCircleSketch.swift
//  
//
//  Created by Jonathan Kaufman on 6/11/21.
//

import Foundation


@available(iOS 15.0, *)
class ExplodingCircleSketch: SketchUI, SketchDelegateUI {
    func setup() {
        
    }
    
    var bombs: [Bomb] = []
    func draw() {
        for touch in touches {
            bombs.append(Bomb(x: touch.x, y: touch.y))
        }
        
        for bomb in bombs {
            bomb.update()
            fill(red: bomb.red, green: bomb.green, blue: bomb.blue)
            circle(x: bomb.x, y: bomb.y, size: bomb.size)
        }
        if bombs.count > 1500 {
            bombs.remove(at: 0)
        }
    }
}

class Bomb {
    var x: Double
    var y: Double
    var size: Double = 0
    var speed: Double
    
    var red: Double
    var green: Double
    var blue: Double
    
    init (x: Double, y: Double) {
        self.x = x
        self.y = y
        self.speed = Double.random(in: 1...3)
        self.red = Double.random(in: 1...255)
        self.blue = Double.random(in: 1...255)
        self.green = Double.random(in: 1...255)
    }
    
    func update() {
        if size < 1500 {
            size += speed
        }
    }
}
