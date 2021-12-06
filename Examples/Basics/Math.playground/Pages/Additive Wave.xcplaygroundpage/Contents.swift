/*:
 ## Additive Wave
 
 by Daniel Shiffman

 Create a more complex wave by adding two waves together.
 
 [Source](https://processing.org/examples/additivewave.html)
 */
import SwiftProcessing
import PlaygroundSupport

class MySketch: Sketch, SketchDelegate {
    
    var xspacing = 8   // How far apart should each horizontal location be spaced
    var w: Int!              // Width of entire wave
    var maxwaves = 4   // total # of waves to add var
    
    var theta = 0.0
    var amplitude = [Double]() // Height of wave
    var dx = [Double]()        // Value for incrementing X, to be calculated as a function of period and xspacing
    var yvalues: [Double]!   // Using an array to store height values for the wave (not entirely necessary)
    
    func setup() {
        frameRate(30)
        colorMode(.rgb, 255, 255, 255, 100)
        w = width + 16
        
        for i in 0..<maxwaves {
            amplitude.append(random(10,30))
            let period = random(100,300) // How many pixels before the wave repeats
            dx.append((Math.two_pi / period) * xspacing)
        }
        
        yvalues = [Double](repeating: 0.0, count: w/xspacing)
    }
    
    func draw() {
        (background(0),
        calcWave(),
        renderWave())
    }
    
    func calcWave() {
        // Increment theta (try different values for 'angular velocity' here
        theta += 0.02
        
        // Set all height values to zero
        for i in 0..<yvalues.count {
            yvalues[i] = 0
        }
        
        // Accumulate wave height values
        for j in 0..<maxwaves {
            var x = theta
            for i in 0..<yvalues.count {
                // Every other wave is cosine instead of sine
                if j % 2 == 0 {
                    yvalues[i] += sin(x) * amplitude[j]
                }
                else {
                    yvalues[i] += cos(x) * amplitude[j]
                }
                x += dx[j]
            }
        }
    }
    
    func renderWave() {
        // A simple way to draw the wave with an ellipse at each location
        (noStroke(),
        fill(255,50),
        ellipseMode(.center))
        for x in 0..<yvalues.count {
            (ellipse(x*xspacing,height/2+yvalues[x],16,16))
        }
    }
    
    
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
