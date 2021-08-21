//: [Previous](@previous)
/*:
 # Sliders
 ### by Masood Kamandy for GSoC 2021
 
 ## Introduction

 Sliders can be an important part of any touch-based interface. They enable users to control attributes interactively.
 
 For the creative coder, a slider means you can tweak aspects of your work without needing to change code. It can save time and allow for more fine-grained control of your artworks.
 
 ## Sliders
 
SwiftProcessing comes with a built in slider class that enables quick and easy set up of sliders. To create a slider you'll need to first initialize it.
 
 You might be asking what a *class* is. We'll get there in a future lesson. For now, just know
 
 Sliders have their own attributes to access with a **dot modifier**. The sliders attributes are:
 
 * `x` - x position of the upper left-hand corner of the slider.
 * `y` - y position of the upper left-hand corner of the slider.
 * `width` - width of the slider
 * `height` - height of the slider
 * `value` - the current value of the slider
 
 The dot modifier works like this: when you declare an object, you have access to all of its properties. If you type a `.` at the end of your variable name you can access and modify any of these.
 
 ## Let's try out using sliders on a face! How many different faces can you make with these sliders?
 
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit

class MySketch: Sketch, SketchDelegate {

    var eyeSize = 100.0
    var pupilSize = 25.0
    var mouthWidth = 200.0
    var mouthHeight = 50.0
    var toothSize = 10.0

//:  When variables are created that aren't initialized with a value you have to tell Swift what data type it is. In this case we're saying that these variables are of type Slider with the : symbol. The ! tells Swift that it may be empty at run time and that it's OK. More on that soon. But we'll make sure to initialize the sliders in setup().
    // Declare sliders
    var eyeSizeSlider: Slider!
    var pupilSizeSlider: Slider!
    var mouthWidthSlider: Slider!
    var mouthHeightSlider: Slider!
    var toothSizeSlider: Slider!
    
    func setup() {
        // For spacing sliders
        var xOffset = 85.0
        let spacer = 125.0
        
        // Initialize Sliders
        eyeSizeSlider = createSlider(60.0, 300.0, eyeSize)
        eyeSizeSlider.x = xOffset
        eyeSizeSlider.label.text("Eye Size")
        eyeSizeSlider.label.fontSize(14)
        eyeSizeSlider.label.textAlignment(.center)
        eyeSizeSlider.label.textColor(255, 255, 255)
        xOffset += spacer
        
        pupilSizeSlider = createSlider(10.0, 100.0, pupilSize)
        pupilSizeSlider.x = xOffset
        pupilSizeSlider.label.text("Pupil Size")
        pupilSizeSlider.label.fontSize(14)
        pupilSizeSlider.label.textAlignment(.center)
        pupilSizeSlider.label.textColor(255, 255, 255)
        
        xOffset += spacer
        mouthWidthSlider = createSlider(50, width, mouthWidth)
        mouthWidthSlider.x = xOffset
        mouthWidthSlider.label.text("Mouth Width")
        mouthWidthSlider.label.fontSize(14)
        mouthWidthSlider.label.textAlignment(.center)
        mouthWidthSlider.label.textColor(255, 255, 255)
        
        xOffset += spacer
        mouthHeightSlider = createSlider(25, 800, mouthHeight)
        mouthHeightSlider.x = xOffset
        mouthHeightSlider.label.text("Mouth Height")
        mouthHeightSlider.label.fontSize(14)
        mouthHeightSlider.label.textAlignment(.center)
        mouthHeightSlider.label.textColor(255, 255, 255)
        
        xOffset += spacer
        toothSizeSlider = createSlider(0.0, 100.0, toothSize)
        toothSizeSlider.label.text("Tooth Size")
        toothSizeSlider.label.fontSize(14)
        toothSizeSlider.label.textAlignment(.center)
        toothSizeSlider.label.textColor(255, 255, 255)
        toothSizeSlider.x = xOffset
    }
    
    func draw() {
        background(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        stroke(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        
        noStroke()
        
        // Whites of eyes
        fill(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        circle(width/3, height/3, eyeSizeSlider.value()) // Left Eye
        circle(width/3 * 2, height/3, eyeSizeSlider.value()) // Right Eye

        
        // Pupils
        fill(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        circle(width/3, height/3 + 25, pupilSizeSlider.value()) // Left Eye
        circle(width/3 * 2, height/3 + 25, pupilSizeSlider.value()) // Right Eye
        
        // Mouth
        fill(#colorLiteral(red: 0.7707275748, green: 0, blue: 0, alpha: 1))
        arc(width/2, height/2 + 50.0, mouthWidthSlider.value(), mouthHeightSlider.value(), 0.0, -Math.pi)
        
        // Tooth
        fill(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        rect(width/2, height/2 + 50.0, toothSizeSlider.value(), toothSizeSlider.value())
    }
}
//: ## Can you create your own face with variables you change with the sliders? Maybe create a hairdo or change the colors around. Or maybe some eyebrows can be used to express emotion!
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
