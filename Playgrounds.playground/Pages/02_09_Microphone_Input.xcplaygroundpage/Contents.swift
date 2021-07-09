//: [Previous](@previous)
/*:
 # Microphone Input
 ### by Masood Kamandy for GSoC 2021
 
 ## Introduction
 
 When it comes to computing there are many input devices we can use to control our sketches. So far we've worked with touch and sliders, but now it's time to try something different: your microphone!
 
 ## TK
 
 sdlkfjsd
 
 ## TK
 
 ### TK
 
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit
import AVFoundation

class MySketch: Sketch, SketchDelegate {

    func setup() {
        AudioIn.shared.start()
    }

    func draw() {
        AudioIn.shared.update()

        circle(width/2, height/2, 25 + AudioIn.shared.getLevel())
    }
}
//: ## Question?
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
