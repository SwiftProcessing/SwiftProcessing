//: [Previous](@previous)
/*:
 # Variables, Constants, and Data
 ### by Masood Kamandy for GSoC 2021
 
 ## Introduction
 
 On this playground you're going to learn about how we can ***store data*** when writing Swift code. Being able to store data allows us to change things later on. Think about the character of a video game. The game needs to know where the character is on screen. That's data that's stored that gets changed by the game player when they move.
 
 ## Variables and Constants
 
 Variables and constants are like little buckets that we can store data in and if you're familiar with algebra, you might be familiar with using x and y variables in math. The concept is the same in programming. Once you create a variable, you can use it anywhere you might use a number.
 
 A ***variable can change***, but a ***constant can't change***. We use the keyword `var` for variables and `let` for constants.
 
 ### Let's Create a Variable!
 
 Before we create a variable, we'll need a name. Variable names can be any initials or names as long as they start with a letter and don't have spaces. Some examples might be:
 
 `x`\
 `myVariable`\
 `position`\
 `positionX`\
 `myColor`\
 `myColor1`

 Notice how the first letter is lower case and the first letter of each word after that is capitalized? That's called ***camel casing*** and it helps us make code easier to read.
 
 The goal with variable names is to make them as clear and readable as possible so you don't confuse yourself or others who might read your code. If they refer to something, name them appropriately. For example if you're variable stores the skin color of your character, then it would be a good idea to call your variable `skinColor`.
 
 
 To create a variable called `characterHeight` and store 50.0 in it, I would type:
 
 `var characterHeight = 50.0`
 
 `var` tells the computer that we're creating a variable.
 
 ### Constants
 
 Constants are similar to variables but unlike variables they can never change. We use constants when we're storing a number that we know will never be different. For example, if you wanted to store the number Pi as a constant, you would do it like this:
 
 `let pi = 3.1415`
 
 ### Scope
 
 When you declare a variable it is only available within its scope. What does scope mean? In Swift and many other languages scope is whatever is betwen the `{` and `}`. If you declare a variable inside of braces, it's only available inside the braces. If you want to declare something in a *broader* scope, then move outside the current set of braces as long as you're still inside of the Sketch class.
 
 ## Data Types
 
 We can store a lot of different types of data in a variable or constant. We're going to explore 4 different data types.
 
 ### Booleans
 
 Booleans can either be `true` or `false`. They're the simplest data type and come in handy later on when we start testing whether things are true or false. They're also sometimes called **flags**. It's common practice to name booleans as if we're asking a quesiton.
 
 `var hasStarted = true`
 
 ### Integers
 
 Integers are numbers that do not have decimal points. One of the most important things to learn about programming early on is that computers store decimal and non-decimal numbers differently. In Swift integer numbers are called `Int`'s.
 
 `var numberOfApples = 15`
 
 ### Doubles
 
 In SwiftProcessing, you'll be using Doubles for most of the work you do with numbers. Doubles are numbers with a decimal point. Here's an example:
 
 `var rectangleWidth = 150.0`

 Swift guesses what kind of variable you have based on what is on the right side of the `=` sign. If it sees quotes, it'll know it's a string. If it sees a decimal point, it will assume it's a Double. In Swift, Doubles are called `Double`'s.
 
 ### Strings
 
 Strings are words or sentences. You could the name of a city in a string. For example:
 
 `var city = "Mexico City"`
 
 Notice that the string is always surrounded by quotation marks. This tells the computer that it's a string and it also marks the beginning and the end of the string. In Swift, strings are called, you guessed it, `String`'s.
 
 There are other data types too! But for now those two types are the most important for getting started with SwiftProcessing.
 
 ### Declaring a Variable With Its Type
 
 There are going to be some situations where you will want to declare a variable and tell the Swift compiler what type it is. Usually this is done when we declare a variable, but don't initialize it with any values. We do that with the `:` operator. Here's what that looks like:
 
 `var age: Int!`
 
 The ! indicates that the variable is an **Optional**. We'll go over this in more detail later, but it basically means there *may or may not be a value stored in this variable* and it's required in Swift if you want to separate declaring and inializing a variable. It tells the compiler that it's OK if this is empty.
 
 ## Capitalization
 
 Capitalization will help you write clean code that others can understand and use. There are two types of capitalization that we'll use in programming:
 1. **Camel Casing**— when we create **variables** or **functions** don't capitalize the first letter. For example: `myVariable`, `drawRectangle`, or `createGradient`.
 1. **Pascal Casing**— This style is reserved for creating **classes** which we'll get into later. In this style we capitalize the first letter and all letters at the beginning of words. For example: `Firefly`, `SmileyFace`, or `SpaceShip`.
 You haven't learned how to create functions or objects, but you'll be using a lot of them so be on the look out for these different styles of capitalization! You'll learn how to make your own functions and classes soon!
 
## Let's play with some variables!
 
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit

class MySketch: Sketch, SketchDelegate {
    
    // One of the benefits of variables is that we can change
    // a lot of code at once. Try changing these variable values
    // to change all of the rectangle widths or heights!
    
    var rectangleWidth = 100.0
    var rectangleHeight = 500.0
    
    func setup() {
        background(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        fill(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
        strokeWeight(10.0)
        stroke(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))
        rect(25.0, 300.0, rectangleWidth, rectangleHeight)
        
        fill(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        strokeWeight(5.0)
        stroke(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
        rect(200.0, 25.0, rectangleWidth, rectangleHeight)
        
        fill(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1))
        strokeWeight(20.0)
        stroke(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
        rect(400.0, 150.0, rectangleWidth, rectangleHeight)
        
        fill(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        strokeWeight(1.0)
        stroke(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
        rect(600.0, 50.0, rectangleWidth, rectangleHeight)
    }
    
    func draw() {
    }
}
//: ## Can you make your own drawing using variables?
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
