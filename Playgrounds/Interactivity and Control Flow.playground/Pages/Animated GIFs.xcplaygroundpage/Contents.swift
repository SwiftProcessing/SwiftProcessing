//: [Previous](@previous)
/*:
 # Animated GIFs
 ### by Masood Kamandy for GSoC 2021
 
 ## Introduction
 
 Whether you pronounce them "jifs" or "gifs" these files make animations fun. SwiftProcessing allows you to add GIFs to your projects like any other images and has some useful methods to help you control their animation.
 
 ## Gifs Work Like Regular Images
 
 The great thing about GIFs in SwiftProcessing is that they work like images but with a few added features.
 
 ### Playing and Pausing Images
 
 The most important options for GIFs is going to be getting them to start and stop. GIFs **automatically start** by themselves unless you set them to be paused after you load them.
 
 Images can be played or paused by calling the two functions that share their names `.play()` and `.pause()`. These are image object *methods* so they have to be called on the individual images themselves. This gives you some control.
 
 ## Let's take a look at a dance. Try clicking the screen to see what happens.
 
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit

class MySketch: Sketch, SketchDelegate {
    
    var playing = true
    
    var dance01, dance02: Image!
    
    var bgHue = 0
    
    func setup() {
        
        // Load the images in setup()
        dance01 = loadImage("dansa_serpentina_1")
        dance02 = loadImage("dansa_serpentina_2")
        
        imageMode(.center) // Draws images from their center point.
        
        colorMode(.hsb)
    }
    
    func draw() {
        if playing {
            background(bgHue, 50, 75)
        } else {
            background(bgHue, 50, 50)
        }
        
        image(dance01, width/3, height/3)
        image(dance02, width/3 * 2, height/3*2)
        
        if playing {
            bgHue = (bgHue + 1) % 360
        }
    }
    
    func touchStarted() {
        if playing {
            dance01.pause()
            dance02.pause()
            playing = false
        } else {
            dance01.play()
            dance02.play()
            playing = true
        }
    }
}

//: ## Can you incorporate your own animated GIFs and make them move? How about using colors from the GIF to change your background color or the color of shapes?
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
//:  ### Credit for image used in Tutorial
//: Source: [Dansa Serpentina, Gaumont (1900)](https://solarsystem.nasa.gov/resources/795/the-rich-color-variations-of-pluto/?category=planets/dwarf-planets_pluto)
//: [Next](@next)
