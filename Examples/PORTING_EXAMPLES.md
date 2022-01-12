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

```java
 int num = 4;
```

 **SwiftProcessing/Swift:**

```swift
 // Using type inference
 var num = 4

 // Declaring type explicitly
 var num: Int = 4
```

### Swift Uses Double Instead of Floats by Default

In Processing, it's customary to use floats as the main floating point data type. You'll see floats in most Processing examples online.

While `Floats` (all types are capitalized in Swift) exist in Swift, it's more common to use the `Double` type for floating point math. `Double`s are similar to `Float`s, but they have more precision and take up more memory. Computers today are designed to handle `Double`s, so Swift gives priority to `Double`s in its type inference system.

For example if you were to declare a variable with a decimal point without explicitely telling Swift what type it was, it would be a `Double` under the hood:

```swift
 // Swift automatically infers that this is a double.
 var num = 4.5
```

### For Loops

In Swift for loops have been given a major overhaul. C-style for loops you may be familiar with no longer work in Swift. There are several approaches to for loops that will be important to familiarize yourself with. A simple for loop that incremements by 1 is far simpler in Swift and uses the range syntax to specify ranges.

**Note:** Because Swift is more strictly typed than Java, all variables in the first line of your for loop need to be consistent.

**Processing/Java:**

```java
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

 **SwiftProcessing/Swift:** 

```swift
// 1
 for i in 0..<100 {
  print(i)
 }

 // 2
 for i in 0..<width {
  print(i)
 }

 // 3
 for i in 0...25 {
  print(i)
 }
```

If you need to *decrement by 1*, the syntax is slightly different and there are a couple of different ways of approaching it.

**Processing/Java:**

```java
 // 1
 for (int i = 100; i > 0; i--) {
  println(i);
 }

 // 2
 for (int i = 100; i >= 0; i--) {
 }
```

**SwiftProcessing/Swift:**

```swift
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

**Processing/Java:**

```java
 // 1
 for (int i = 0; i < 400; i+=5) {
 }

 // 2
 for (int i = 0; i <= 400; i+=5) {
 }
```

**SwiftProcessing/Swift:**

```swift
 // 1
 for i in stride(from: 0, to: 400, by: 5) {
   print(i)
 }

 // 2
 for i in stride(from: 0, through: 400, by: 5) {
   print(i)
 }
```

### Arrays with Predetermined Sizes

In Java it's very common to create an instance of an array at a specific size. This is because Java arrays are not mutable, meaning once you create one, you cannot change its size. This is not the case with Swift `Array`s, which dynamically resize depending on how many items you add or remove. If you are familiar with Java, the behavior of a Swift `Array` is similar to Java `ArrayList`s.

If you are looking at some example code from Processing that has an array of a predetermined or calculated size, you do have options in Swift!

First we'll get rid of the fixed size with a 1-dimensional array and simply use Swift's `.append()` function, which allows us to add elements to an existing array:

#### For a 1-Dimensional Array

In **Processing** it might look like this:

```java
color[] colors = new color[numChars];

 for(int i = 0; i < numChars; i++) {

  colors[i] = color(i, numChars, numChars);

 }
```

One correct way to do this in **Swift** would be with the append function:

```swift
var colors = [Color]()

 for i in 0..<numChars {

   colors.append(color(i, numChars, numChars))

 }
```

Be careful with the append function when dealing with very large numbers. It can fail. One example of this is when appending an array for every pixel on the screen. You will likely face a crash.

Next we'll actually create an array of a fixed size and populate it with 0's before we make our calculations. This strategy might be useful for arrays of numbers. In the example below we're using a 2-dimensional array.

#### For a 2-Dimensional Array of a Fixed Size

In **Processing** it might look like this:

```java
 float[][] distances;

 distances = new float[width][height];

 for (int y = 0; y < height; y++) {
  for (int x = 0; x < width; x++) {
   float distance = dist(width/2, height/2, x, y);
   distances[x][y] = distance/maxDistance * 255;
  }
 }
```

One correct way to do this in **Swift** would be:

```swift
var distances = [[Double]](repeating: [Double](repeating: 0, count: Int(height)), count: Int(width))

 for y in 0..<Int(height) {
   for x in 0..<Int(width) {
     let distance = dist(width/2, height/2, x, y)
     distances[x][y] = distance/maxDistance * 255
   }
 }
```

### Unitialized Variables Don't Have Implicit Values in Swift

In many Processing sketch examples you'll see that variables have been left uninitialized and yet the code runs perfectly fine. That's because Java interprets uninitialized numerical values as zeros and unitialized booleans as false.

In general this kind of behavior has been eliminated by Swift because the designers of Swift see it as the source of bugs. In general, you are not allowed to leave variables in Swift unintialized.

Often this kind of problem is simply fixed by assigning 0, 0.0, or false to any uninitialized variables in Processing sketches.

## Differences Between Processing and SwiftProcessing

### There is No size() Function

Because all SwiftProcessing projects are designed to work in full-screen mode, there is no `size()` function in SwiftProcessing. In most cases you can safely omit this from code without altering major components of the examples you are bringing in.

If you want to **center a sketch** that's been designed for a specific size (w, h), the following pattern will work:

```swift
translate((width - w)/2, (height - h)/2)
```

### Mouse Interaction is Now Touch Interaction

In SwiftProcessing any reference to `mouseX` should be replaced with `touchX`. Many sketches depend upon detecting the mouse when it is not clicking. This is not possible in touch-based interfaces, so this functionality has been removed. This will require a rethinking of certain examples you may find.

### Math Constants Are in a Struct Called Math Now

To access math constants, you can first type `Math` and then a `.` and you will get a pull down menu of all available constants. For example, the Processing constant `TWO_PI` has been renamed `Math.two_pi` in SwiftProcessing.

### SwiftProcessing Leverages Enums for Many Constants

For constants that are context dependant, SwiftProcessing leverages enums. This enables new learners to, in most cases, just type a `.` and get a drop down of appropriate choices that are relevant to their current context.

 In **Processing**:

```java
 ellipseMode(CENTER)
```

 In **SwiftProcesing**

```
ellipseMode(.center)
```

### Fonts

SwiftProcessing changes the way fonts are handled. Unlike Processing with Java, iOS doesn't handle fonts by using file names. It uses the *internal* name of the font, which can be different from the font file name.

To use a font in SwiftProcessing:

1. Drag the font file into Xcode's project navigator on the left side of the window.
2. Open the info.plists file and click the + button on the last entry to add a new entry. Choose 'Fonts provided by application.'
3. Click the expand arrow next to the item.
4. Where it says 'Item 0' type the file name of the font you've added to your project.

Now that the font is included with your project, you'll need to check to find the name the system refers to. You can use the following code in `setup()` to do this:

```swift
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