//: [Previous](@previous)
/*:
 # Color and Stroke
 ### by Masood Kamandy for GSoC 2021
 
 ## Color
 
 ### Introduction
 
 Your computer can display millions, if not billions, of colors. You will want to use those colors when writing your own code and there are a few different ways of doing that.
 
 For grayscale images, we only need to pay attention to one color and that's the gray value. We depict gray values from 0.0 to 255.0. Here's what that looks like:
 
 ![An image showing a strip of gray squares from black to white with their corresponding numerical value.](grayscale.jpg)
 
 In computing it is common to depict colors as red, green, and blue values. This is called *additive color*. By mixing different values of these three colors we can make any color we'd like.
 
 ![An image showing 3 intersecting circles. Each circle is labeled R, G, and B respectively. The overlapped areas show what happens when these different colors mix.](rgb.jpg)
 
 Remember that computers read your code in sequence from top to bottom. In Processing, if you want to change the fill color of something you can use the `fill()` function.
 
 ### Color Fill
 
 The `fill()` function can take a variety of different inputs. Here are a few:
 1. ***Color Literals*** - if you want to choose colors directly using a color picker go up to the menubar and choose Editor -> Insert Color Literal. You can see examples in the code example below.
 1. ***Red, Green, Blue, and Alpha (RGBA) values*** - On computers colors can be identified with numbers representing their red, green, blue, and alpha values. Alpha is transparency. This follows this format:\
 `fill(red, green, blue)` or `fill(red, green, blue, alpha)`\
 Colors go up to a maximum of 255, so pure red would be:\
 `fill(255, 0, 0)` or `fill(255, 0, 0, 255)`\
 An alpha of *255.0* means it's *not see-through* or *fully opaque*. An alpha of *0.0* means it's *fully transparent*. Default alpha is 255.
 1. ***Hue, Saturation, Brightness, and Alpha (HSBA) values*** - It can be difficult for humans to think about colors in terms of R, G, and B. Controlling by hue, saturation, and brightness is more natural and offers an alternative. Alpha is transparency. This follows this format:\
 `fill(hue, saturation, brightness)` or `fill(hue, saturation, brightness, alpha)`\
 Hue goes from 0 to 359 and corresponds to the color wheel. Saturation, brightness, and alpha go from 0 to 99. The color wheel starts with red at 0°.
 `fill(0, 100, 100)` or `fill(0, 100, 100, 100)`\
 An alpha of *255.0* means it's *not see-through* or *fully opaque*. An alpha of *0.0* means it's *fully transparent*.
 1. ***Gray values*** - You can also just set a gray and an alpha value by using a single value with a transparency like this:\
 `fill(127.0, 255.0)`\
 or just with a single gray value (which sets the transparency to a default of 255.0):\
 `fill(127.0)`
 
 ## Stroke and Stroke Weight
 
 ### Stroke
 
  In Processing there are two basic ways to set color. We already went over fill for filling shaples. We can also color lines with the `stroke()` function. The `stroke()` function follows the same basic pattern as `fill()`:\
`stroke(colorLiteral)`\
 `stroke(grayValue)`\
 `stroke(grayValue, alpha)`\
 `stroke(red,green,blue)`\
 `stroke(red, green, blue, alpha)`
 `stroke(hue, saturation, brightness)`
 `stroke(hue, saturation, brightness, alpha)`
 
 ### Stroke Weight
 
 You'll also need to change the thickness of your stroke. We do that with the following function:
 `strokeWeight(weight)`\
 `weight` can be any number with a decimal point and is the thickness of the line. 1.0 is 1 pixel thick. 10.0 is 10 pixels thick.
 
 
 ## Import Modules
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit
//: ## SwiftProcessing Sketch Code
class MySketch: Sketch, SketchDelegate {
    
    func setup() {
        stroke(127.0)
        strokeWeight(1.0)  // Default
        line(0, 0, width, height/5)
        
        stroke(127.0, 255.0, 0)
        strokeWeight(4.0)  // Thicker
        line(0, 0, width, height/5 * 2)
        
        stroke(#colorLiteral(red: 0.1720817685, green: 0.4515664577, blue: 1, alpha: 1))
        strokeWeight(10.0)  // Beastly
        line(0, 0, width, height/5 * 3)
        
        stroke(#colorLiteral(red: 1, green: 0.4515664577, blue: 1, alpha: 1))
        strokeWeight(20.0)  // Beastly
        line(0, 0, width, height/5 * 4)
        
        // Notice that the last line drawn in code covers up the lines drawn before it. It's like a painting. Whatever you draw last gets drawn on top.
        
        // Try adding your own lines with different stroke weights and colors.
    }
    
    func draw() {
    }
}

PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
