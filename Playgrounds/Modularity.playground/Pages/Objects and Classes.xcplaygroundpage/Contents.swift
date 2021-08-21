//: [Previous](@previous)
/*:
 # Objects and Classes
 ### by Masood Kamandy for GSoC 2021
 
 ## Introduction
 
 In Swift, you may not have noticed it, but we've been working with objects from the very first lesson. The creators of programming languages in the late 1970s and 80s envisioned a way of engaging with coding that mimicked real life interactions. They called this Object oriented programming, or OOP for short.
 
 Object oriented programming allows us to create objects that have certain capabilities and can store certain types of information. The image above will be your introduction to this concept.
 
 A car has certain properties, methods, and events. These three things ensure that our object behaves appropriately in certain situations.
 
 You can think of objects as functions with an added layer of data.
 
 ## How to Write a Class
 
 When you create a new class you can either do it within the playground you are working in, or it is also possible to create a new Swift file for your project. For now we'll create a class inside of our Sketch so we have access to SwiftProcessing.

 Classes are capitalized. If there are multiple words in your class name, then use **Pascal-case**, which means you capitalize the first letter of every word (i.e. ItLooksLikeThis).

 Here is a basic class declaration that creates a Person. It might seem complicated, but we will unpack each portion of this for you to fully understand.

 The properties are `color`, `isOn`, and `isFlying`. There is an **initializer**, which is the first thing that runs and helps **create** and **set up** a `Firefly` with the right initial data. There are two methods to `display()` the firefly, to `move()` it, and to count how many have been created total:
 
 ```
 class Firefly {
     static var howMany = 0
 
     var location: Vector
 
     var color: Color
     var isOn = true
     var isMoving = true
     
     init(color: Color, location: Vector, sketch: Sketch) {
         self.color = color
         self.location = location
         
         Firefly.howMany += 1
     }
     
     func display() {
         // Drawing Code
     }
 
     func move() {
         // Movement Code
     }
     
     static func count() -> String {
         return "You've created \(Firefly.howMany) fireflies."
     }
 }
 ```
 
 ### Properties: The Object's Data
 
 Properties are **the data that is stored in each instance of an object.** In general, when starting out, each of these is specific to a single instance of a class.

 You can create a property that is **static** as well. This means that all instances of objects in this class have access to the same property. So if one instance changes it, it changes for every instance. In the example above, we use this strategy to count how many `Firefly` instances we've created.
 
 ### Dot Operator: Accessing Data
 
 Properties are, by default, accessible from outside of the class using the dot operator. This means if I create an instance of a person named "Joe Potts," I can switch isAProgrammer from being false to true whenever I'd like.

 To do this, I use the dot operator like this:
 `myFirefly.isOn = false`
 
 You can also make properties **private**, so that they are inaccessible from outside of the class using the keyword `private` before you declare the property inside the class. For example, if we wanted to lock down that property in our class, we would change the following line from:
 
 `var isOn: Bool`
 
 to:
 
 `private var isOn: Bool`
 
 ### Methods: Functions Inside an Object
 
 You can think of methods as the functions hidden within each object. These are actions that you can create inside of a class. Creating them is essentially the same as writing a function anywhere else, although you do have access to all of the properties that you build into an object.
 
 ### Initializers: Where Your Object Starts
 
 Every class requires an initializer called `init()`. This piece of code runs once and prepares our code for use. In the case of our Firefly class the first line of our `init()` looks like this:
 
 `init(color: String, location: Vector) {`
 
 The `init()` fills several purposes:
 1. It tells programmers who use your Firefly class what data is required to initialize an instance of your class. That's what `color: String` and `location: Vector` means and Xcode will automatically tell coders that Firefly requires these pieces of information to be created.
 1. It's a place to assign the passed in information from the initializer to the instance's properties. We do this by referring to the outer properties with the prefix `self`. For example, the line: `self.color = color` assigns the passed in color to the Firefly instance's color property. This is a point of confusion for many, but just remember that when the object is created it needs to have values placed in its properties. The `init()` is where you do that.
 1. It does any other work that you'd like to happen at the "birth" of your class instance. This is a good place to put print statements for verification that the object is successfully being created when debugging.
 
 You can also deinitialize an instance of a class with `deinit()` if you need to do do some cleanup when an object is deallocated from memory.
 
 ### Static Properties and Methods
 
 You might have noticed that one property and one method have the keyword `static` before they are declared. A static is a property or method that operates for the whole class, as opposed to individual instances of the class.

 In the case of our Firefly class, we've used it to create a global count of how many fireflies have been created. This can be extremely useful if you start creating a lot of instances of objects.

 Notice that accessing a static looks slightly different than accessing an instance's property. To access a static property, we have to refer to the overall class (`Firefly` as opposed to the individual object's name) like this:

 `print(Firefly.count())`
 
 ## Let's create some fireflies using a class and watch them fly around!
 
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit

class MySketch: Sketch, SketchDelegate {
    
    var numFlies = 10
    var fireflies = [Firefly]()
    
    func setup() {
        for _ in 0..<numFlies {
            (fireflies.append(
                Firefly(
                color: Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)),
                location: Vector(random(width), random(height)),
                sketch: self)))
        }
    }
    
    func draw() {
        (background(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)))
        for fly in fireflies {
            (fly.display())
        }
    }
    
    func touchStarted() {
        for fly in fireflies {
            (fly.isOn = !fly.isOn)
            (fly.isMoving = !fly.isMoving)
        }
        print(Firefly.count())
    }
 }

open class Firefly {
    var sketch: Sketch
    
    public static var howMany = 0
    
    public var location: Sketch.Vector
    
    public var color: Sketch.Color
    public var isOn = true
    public var isMoving = true
    public var rotation: Double
    
    public var walkSpeed = 4
    
    public init(color: Sketch.Color, location: Sketch.Vector, sketch: Sketch) {
        self.color = color
        self.location = location
        self.sketch = sketch
        
        self.rotation = sketch.random(Sketch.Math.two_pi)
        
        Firefly.howMany += 1
    }
    
    public func display() {
        if (isMoving) {
            (move())
        }
       
        (sketch.pushMatrix())
        
        (sketch.translate(location.x, location.y))
        (sketch.rotate(rotation))
        
        
        if isOn {
            (sketch.fill(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 0.3032388245)),
             sketch.noStroke(),
             sketch.circle(0, 0, 150))
        }
        
        (sketch.strokeWeight(30))
        
        if isOn {
            (sketch.stroke(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)),
            sketch.line(0, 20, 0, -20),
            sketch.stroke(#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)),
            sketch.line(0, 0, 0, -20))
        } else {
            (sketch.stroke(#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)),
            sketch.line(0, 20, 0, -20))
        }
        
        (sketch.noStroke(),
        sketch.fill(#colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 0.5)),
        sketch.arc(0, 0, 100, 100, 0+0.1, Sketch.Math.pi/4),
        sketch.arc(0, 0, 100, 100, Sketch.Math.pi/4 * 3, Sketch.Math.pi-0.1),
        sketch.arc(0, 0, 100, 100, Sketch.Math.pi+0.1, Sketch.Math.pi/4*5),
        sketch.arc(0, 0, 100, 100, Sketch.Math.pi/4 * 7, -0.1),
        
        sketch.popMatrix())
    }
    
    public func move() {
        // X random walk
        location.x += sketch.random(-walkSpeed, walkSpeed)
        if location.x > sketch.width + 75 { location.x = 0 }
        if location.x < -75{ location.x = sketch.width }
        
        // Y random walk
        location.y += sketch.random(-walkSpeed, walkSpeed)
        if location.y > sketch.height + 75 { location.y = 0 }
        if location.y < -75 { location.y = sketch.height }
        
        // rotation random walk
        rotation += sketch.random(-0.25, 0.25)
        if rotation > Sketch.Math.two_pi { (rotation = 0) }
        if rotation < 0 { (rotation = Sketch.Math.two_pi) }
    }
    
    public static func count() -> String {
        return "You've created \(Firefly.howMany) fireflies."
    }
}
//: ## Try clicking on the screen to see what happens!
//: ##What kinds of objects can you make?
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
