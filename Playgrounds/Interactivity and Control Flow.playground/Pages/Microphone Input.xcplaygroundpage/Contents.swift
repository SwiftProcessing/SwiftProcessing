//: [Previous](@previous)
/*:
 # Microphone Input
 ### by Masood Kamandy for GSoC 2021
 
 ## Before we start
 
 This section does not currently work with Xcode Playgrounds. This is an ongoing issue and anyone who has experience with Playgrounds is welcome to fix the issue! The workaround is to copy and paste the example code into a regular SwiftProcessing project.
 
 ## Introduction
 
 When it comes to computing there are many input devices we can use to control our sketches. So far we've worked with touch and sliders, but now it's time to try something different: your microphone! In SwiftProcessing we have an audio input that gives you access to the level of your microphone.
 
 ## The SwiftProcessing AudioIn Class

 SwiftProcessing's AudioIn class makes it easy to access the microphone. It provides basic access to the microphone level coming into the phone.
 
 The AudioIn class is a *singleton* meaning there can only one instance of it. The reason for this is simple: you generally only have one microphone. It also simplifies accessing it's properties a lot. Because of this, we interface with the class directly and we don't need to create an instance of it. That means that all calls to the class will begin with `AudioIn.`. More on that below.
 
 ### Before We Start: A Note on Permissions
 
 When using any hardware that has privacy implications, iOS requires that you use a special procedure to notify users that their microphone will be used. It also requires you to explain why to your users.
 
 In order to set this up, you'll need to modify the `Info.plist` file within your Xcode project. This file is automatically created when you create a new Xcode project. To add microphone functionality:
 
 1. Click on `Info.plist`
 1. Go down to the last key and click the `+` sign to add a new key below it.
 1. Scroll through the list and select `Privacy - Microphone Usage Description`
 1. Add a string to explain why you're using the microhone. This string will appear in the pop up to your app users when your app requests access to the microphone.
 
 ![An image of the Info.plists tile table. At the bottom there is a row highlighted. The row has a key and a value. The key is 'Privacy - Microphone Usage Description' and the value is a user definable string. The string currently says 'SwiftProcessing needs access to the microphone to allow you to use it in your sketches.'](infoplist.png)
 
 ### Starting the Microphone
 
 In order to start the microphone using the `AudioIn` class, you'll need to call `AudioIn.start()`. This function **should only be called one in `setup()`**.
 
 ### Updating the Microphone
 
 Sampling the microphones happens as often as you'd lke it to happen using the `AudioIn.update()` function. If you'd like this to happen every frame, simply put this at the beginning of `draw()`. There may be other situations where you don't need or want to sample it so often, so this function gives you the option of adding logic to determine when you want to sample the mic.
 
 ### Getting the Microphone Level
 
 The current level of he microphone is retrieved with the `AudioIn.getLevel()` function. This function returns a double.
 
 ### Example Code
 
 In order to use this code, copy and paste it into a regular SwiftProcessing Template.
 
 ```
 import UIKit
 import SwiftProcessing

 class MySketch: Sketch, SketchDelegate {
     
     var positions = [Vector]()
     let numCircles = 25
     var circleColors = [Color]()
     var startingSizes = [Double]()
     
     func setup() {
         for _ in 0..<numCircles {
             positions.append(Vector(random(50, width-50), random(150, height-150)))
             circleColors.append(color(random(255), random(255), random(255), random(50,150)))
             startingSizes.append(random(250))
         }
         
         AudioIn.multiplier = 4.0
         AudioIn.start()
     }
     
     func draw() {
         background(0)
         noStroke()
         AudioIn.update()
         
         for i in 0..<numCircles{
             fill(circleColors[i])
             circle(positions[i].x, positions[i].y, startingSizes[i] + AudioIn.getLevel())
         }
     }
 }
 ```
 
 */

//: ## Can you use SwiftProcessing's AudioIn class to control your sketch with sound?
//: [Next](@next)
//: ## Congratulations! You've completed the Interactivity and Control Flow chapter. Move on to the next section for more!
