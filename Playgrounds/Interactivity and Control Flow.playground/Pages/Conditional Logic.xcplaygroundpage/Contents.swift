//: [Previous](@previous)
/*:
 # Conditional Logic
 ### by Masood Kamandy for GSoC 2021
 
 ## Introduction
 
 Conditional logic in coding helps us create branches in code. Basically it helps us say "If this happens, then do that!" It's essential to use conditional logic when creating rich experiences that always keep us guessing. These are called **branch statements**.
 
 In this playground we're going to combine randomness and conditional logic to create a dice program!
 
 ## If Statements
 
 The simplest form of branching statement branches your code logic in two directions. That's the if statement! Here's the syntax of an if statement in Swift:
 
 ```
 if condition {
    statements
 }
 ```
 The code where `statements` is above only runs if the `condition` is true. But what happens if the `condition` is false? There's a statement for that too! We can use an **else clause**.
 
 ```
 if condition {
    statements to execute if condition is true
 } else {
    statements to execute if condition is false
 }
 ```
 If you have multiple conditions you can use the pattern `if`, `else if`, `else` and you can have as many `else if`'s as you need.
 
 ```
 if condition 1 {
    statements to execute if condition 1 is true
 } else if condition 2 {
    statements to execute if condition 2 is true
 } else {
    statements to execute if both conditions are false
 }
 ```
 **NOTE:** It's possible to ***nest*** if statements. That means putting an if statement inside of an if statement. You'll see that we did that below in a simple way. It can lead to code that's difficult to read, so make sure you can follow the logic of your program when doing this.
 
 **XCODE TIP:** A good way to keep things clear is to properly indent your code. Xcode can automatically do this by going to Edit -> Select All and then Editor -> Structure -> Re-Indent. Or you can press command-a and then control-i.
 
 ## Relational and Logical Operators
 
 Any time we need to **test conditions** using numbers in coding we use what are called ***relational operators*** to create a ***boolean expression***.
 
 This is a concise way of saying, **“Let’s compare a with b and test if my statement is true or false.”**
 
 ### Relational Operators
 
 Relational operators help us compare two values. It's like a "truth test" to see if a boolean expression is true or false.
 
 ![Table with 6 rows.
 Row 1:  ==  means  "is equal to" and here's an example—   if x == 4 {}.
 Row 2:  !=  means  "is not equal to"  and here's an example—    if key != "y" {}.
 Row 3:  >  means  "greater than"  and here's an example—  if x > 255 {}.
 Row 4:  <  means  "less than"  and here's an example—  if x < 0 {}.
 Row 5:  >=  means  "greater than or equal to"  and here's an example—  if x >= 100 {}.
 Row 6:  <=  means  "less than or equal to"  and here's an example—  if x <= 0 {}](relational_operators.jpg)
 
 ### Logical Operators
 
 A logical operator is a way of seeing if more than one test is true.
 
 A good example in pseudocode is “If x = 1 AND y > 3 then print YES.”
 
 **NOTE:** Pseudocode is a fancy term that means you’re writing code in plain English. Sometimes it’s an easier way of understanding what you want to do before diving in and coding.
 
 ![Table with 3 rows.
 Row 1:  &&  means  AND  and here's an example—  if x == 4 && y > 0 {}
 Row 2:  ||  means  OR  and here's an example—  if key == "y" || key == "Y" {}
 Row 3:  !  means  NOT  and here's an example—  if !(x<0) {}](logical_operators.jpg)
 
 ## Switch Statements
 
 Another useful strategy if you know there are going to be multiple branches is to use a **switch statement**.
 
 ```
switch control expression {
case pattern 1:
    statements
case pattern 2:
    statements
case pattern 3:
    statements
default:
    statements
}
 
 ```
 The `control expression` is usually a variable that holds an integer, but it can be other types also.
 
 ## Let's use if statements and a switch to change the background depending on the dice roll! Hit play and tap the screen.
 */

import SwiftProcessing
import PlaygroundSupport
import UIKit

class MySketch: Sketch, SketchDelegate {
    
    // A dice roll should be an integer because we don't need decimals.
    var diceRoll: Int!
    
    // Change this to false if you want to see the switch statement instead of if.
    var useIf = true
    
    func setup() {
        diceRoll = 0
    }
    
    func draw() {
        noStroke()
        
        if useIf {
            
            // First let's try the approach with an if statement.
            if diceRoll == 0 {
                background(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
            } else if diceRoll == 1 {
                background(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
                circle(width/2, height/2, 100)
            } else if diceRoll == 2 {
                background(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
                circle(width/2 + 100, height/2 - 100, 100)
                circle(width/2 - 100, height/2 + 100, 100)
            } else if diceRoll == 3 {
                background(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
                circle(width/2 + 100, height/2 - 100, 100)
                circle(width/2, height/2, 100)
                circle(width/2 - 100, height/2 + 100, 100)
            } else if diceRoll == 4 {
                background(#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1))
                circle(width/2 + 100, height/2 - 100, 100)
                circle(width/2 - 100, height/2 - 100, 100)
                circle(width/2 - 100, height/2 + 100, 100)
                circle(width/2 + 100, height/2 + 100, 100)
            } else if diceRoll == 5 {
                background(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
                circle(width/2 + 100, height/2 - 100, 100)
                circle(width/2 - 100, height/2 - 100, 100)
                circle(width/2, height/2, 100)
                circle(width/2 - 100, height/2 + 100, 100)
                circle(width/2 + 100, height/2 + 100, 100)
            } else { // 6 is the only other possibility, so we use else.
                background(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
                circle(width/2 - 100, height/2, 100)
                circle(width/2 + 100, height/2, 100)
                circle(width/2 - 100, height/2 - 125, 100)
                circle(width/2 + 100, height/2 - 125, 100)
                circle(width/2 - 100, height/2 + 125, 100)
                circle(width/2 + 100, height/2 + 125, 100)
            }
            
            
        } else {
            
            // Next let's try it with a switch statement.
            // To use this code, change the boolean useIf to false above.
            
            switch diceRoll {
            case 1:
                background(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
                circle(width/2, height/2, 100)
            case 2:
                background(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
                circle(width/2 + 100, height/2 - 100, 100)
                circle(width/2 - 100, height/2 + 100, 100)
            case 3:
                background(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
                circle(width/2 + 100, height/2 - 100, 100)
                circle(width/2, height/2, 100)
                circle(width/2 - 100, height/2 + 100, 100)
            case 4:
                background(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
                circle(width/2 + 100, height/2 - 100, 100)
                circle(width/2 - 100, height/2 - 100, 100)
                circle(width/2 - 100, height/2 + 100, 100)
                circle(width/2 + 100, height/2 + 100, 100)
            case 5:
                background(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1))
                circle(width/2 + 100, height/2 - 100, 100)
                circle(width/2 - 100, height/2 - 100, 100)
                circle(width/2, height/2, 100)
                circle(width/2 - 100, height/2 + 100, 100)
                circle(width/2 + 100, height/2 + 100, 100)
            case 6:
                background(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
                circle(width/2 - 100, height/2, 100)
                circle(width/2 + 100, height/2, 100)
                circle(width/2 - 100, height/2 - 125, 100)
                circle(width/2 + 100, height/2 - 125, 100)
                circle(width/2 - 100, height/2 + 125, 100)
                circle(width/2 + 100, height/2 + 125, 100)
            default:
                background(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
            }
        }
    }
    
    func touchStarted() {
        // The Int() function converts numbers to an integer by
        // 'truncating' or chopping off the decimal portion.
        // We use it here because random() returns a Double.
        diceRoll = Int(random(6.0)) + 1
        print("Dice rolled and lands on \(diceRoll ?? 0)")
    }
}
//: ## How will you use conditional logic for your programs? Challenge: Try to create a button using a rectangle with conditional logic.
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
