/*:
 # Porting from Processing to SwiftProcessing
 
 This is a document that will help you understand the basic differences between Processing/Java and SwiftProcessing/Swift. Understanding these differences will help you to leverage the existing (and very large) community of Processing developers when developing code for SwiftProcessing.
 
 This document is inspired by [Processing Transition](https://github.com/processing/p5.js/wiki/Processing-transition), a document that helps programmers migrate from Processing to p5.js.
 
 ## Basic Differences Between Java and Swift Syntax
 
 ### No Semicolons
 
 Swift does not use semicolons. When porting code, remove the semicolons at the end of each line.
 
 ### Conditionals Do Not Need Parenentheses
 
 Swift does not need parentheses in its if statements or its switches. You can remove them. For loops also remove the parentheses. See *For Loops* section.
 
 ### Declare Variables with the var Keyword, Constants with let
 
 Java requires that you declare variables by telling it what type it is up front. For example, to declare a `int` called `num` and assign `4` to it you would type: `int num = 4`.

 Swift does not require this. Swift has what's called *type inference* which means it will try to guess what the type is by what you assign it. In Swift we use the `var` keyword to assign variables and the `let` keyword for constants. The above code would look like this: `var num = 4` or if it's a constant `let num = 4`. Swift knows that 4 doesn't have a decimal point, so it's an integer. It will use the appropriate data type under the hood.
 
 #### Type Inference Can Cause Confusion
 
 Because of the way type inference works, it's possible to make mistakes that affect your code when a type is ambiguous. If you want to leverage type inference, always remember to **put a decimal point on any variable assignment where you need floating point precision** or declare your variable with an **explicit type**.
 
 **Processing/Java:**
 ```
 int num = 4;
 ```
 
 **SwiftProcessing/Swift:**
 ```
 // Using type inference
 var num = 4
 // Declaring type explicitly
 var num: Int = 4
 ```

 ### Swift Uses Double Instead of Floats by Default
 
 In Processing, it's customary to use floats as the main floating point data type. You'll see floats in most Processing examples online.
 
 While `Floats` (all types are capitalized in Swift) exist in Swift, it's more common to use the `Double` type for floating point math. `Double`s are similar to `Float`s, but they have more precision and take up more memory. Computers today are designed to handle `Double`s, so Swift gives priority to `Double`s in its type inference system.
 
 For example if you were to declare a variable with a decimal point without explicitely telling Swift what type it was, it would be a `Double` under the hood:
 
 ```
 // Swift automatically infers that this is a double.
 var num = 4.5
 ```
 
 ### For Loops
 
 In Swift for loops have been given a major overhaul. C-style for loops you may be familiar with no longer work in Swift. There are several approaches to for loops that will be important to familiarize yourself with. A simple for loop that incremements by 1 is far simpler in Swift and uses the range syntax to specify ranges.
 
 **Note:** Because Swift is more strictly typed than Java, all variables in the first line of your for loop need to be consistent.
 
 Processing/Java:
 ```
 // 1
 for (int i = 0; i < 100; i++) {
    println(i);
 }
 
 // 2
 for (int i = 0; i < width; i++) {
    println(i);
 }
 
 // 3
 for (int i = 0; i <= 25; i++) {
    println(i);
 }
 ```
 
 SwiftProcessing/Swift:
 ```
 // 1
 for i in 0..<100 {
    print(i)
 }
 
 // 2 - Note: width is a Double in SwiftProcessing, so we convert it to an Int.
 for i in 0..<Int(width) {
    print(i)
 }
 
 // 3
 for i in 0...25 {
    print(i)
 }
 ```
 
 If you need to *decrement by 1*, the syntax is slightly different and there are a couple of different ways of approaching it.
 
 Processing/Java:
 ```
 // 1
 for (int i = 100; i > 0; i--) {
    println(i);
 }
 
 // 2
 for (int i = 100; i >= 0; i--) {
 
 }
 ```
 
 SwiftProcessing/Swift:
 ```
 // 1
 for i in (1...100).reversed() {
    print(i)
 }
 
 // 2
 for i in (0...100).reversed() {
    print(i)
 }
 
 // Alternative method for 1
 for i in stride(from: 100, to: 0, by: -1) {
     print(i)
 }
 
 // Alternative method for 2
 for i in stride(from: 100, through: 0, by: -1) {
     print(i)
 }
 ```
 
 As you saw in the above example, Swift gives us the `stride()` function for use with for loops to use any increment we'd like.
 
 Processing/Java:
 ```
 // 1
 for (int i = 0; i < 400; i+=5) {
 
 }
 
 // 2
 for (int i = 0; i <= 400; i+=5) {
 
 }
 ```
 
 SwiftProcessing/Swift:
 ```
 // 1
 for i in stride(from: 0, to: 400, by: 5) {
     print(i)
 }
 
 // 2
 for i in stride(from: 0, through: 400, by: 5) {
     print(i)
 }
 ```
 ## Differences Between Processing and SwiftProcessing
 
 ### There is No size() Function
 
 Because all SwiftProcessing projects are designed to work in full-screen mode, there is no `size()` function in SwiftProcessing. In most cases you can safely omit this from code without altering major components of the examples you are bringing in.
 
 ### Mouse Interaction is Now Touch Interaction
 
 In SwiftProcessing any reference to `mouseX` should be replaced with `touchX`.
 
 ### Fonts
 
 SwiftProcessing changes the way fonts are handled. Unlike Processing with Java, iOS doesn't handle fonts by using file names. It uses the *internal* name of the font, which can be different from the font file name.
 
 To use a font in SwiftProcessing:
 
 1. Drag the font file into Xcode's project navigator on the left side of the window.
 1. Open the info.plists file and click the + button on the last entry to add a new entry. Choose 'Fonts provided by application.'
 1. Click the expand arrow next to the item.
 1. Where it says 'Item 0' type the file name of the font you've added to your project.
 
 Now that the font is included with your project, you'll need to check to find the name the system refers to. You can use the following code in `setup()` to do this:
 
 ```
 for family in UIFont.familyNames.sorted() {
     let names = UIFont.fontNames(forFamilyName: family)
     print("Family: \(family) Font names: \(names)")
 }
 ```
 
 This will list all of your fonts that are installed. The font you are looking for should be in this list with the correct name.
 
 ## Playgrounds
 
 If you are bringing example code into a Playground, you should be aware that by default they may run quite slowly.
 
 In the Playgrounds included with SwiftProcessing you may see lines of code wrapped in parentheses or `()`. This is really only needed in Playgrounds and the parentheses can be omitted in regular sketches that are meant to be used on devices or in the Simulator.
 
 The `()` or `(,)` syntax enables Playgrounds to bypass Xcode Playgrounds' counter feature. The counter is meant to give a clear representation to new learners of what is happening in the code. A negative side effect of the counter is that it slows down code.
 */
