//: [Previous](@previous)
/*:
 # Synthesis—A Game Using Classes
 ### by Masood Kamandy for GSoC 2021
 
 ## Introduction
 
 While it wasn't the first video game, Pong is widely regarded as the video game which started the home video game industry in the 70s. It was a relatively simple game based on tennis where two paddles were used to hit a ball back and forth. Whenever a player missed the ball, the other player would get a point. Whoever gets ten points first wins.

 Pong was released by Atari in 1972, first in the arcades and then as a home unit that connected to TVs. It was ultimately made available for the Atari 2600.

 Creating a tennis-like game like Pong is a great way of thinking through the idea of object oriented programming. It allows us to use physical metaphors to organize code in a logical, and consistent way for humans to understand.
 
 ## Some questions to think about
 
 Object oriented programming gives us the opportunity to divide all of the objects in our program up and program them separately. Here are some questions you should think about:
 
 1. In the game of Pong, what are the objects drawn to the screen?
 1. How are these objects controlled?
 1. What kinds of data (information) does each of these objects need to work properly? Make a list for each object.
 
 ## What are the objects?
 
 In programming there's never just one approach, but in a digital tennis game like Pong, the objects that can be programmed separately might be the following:
 
 1. The ball
 1. The paddle
 1. The score
 1. The field
 
 ## What other systems will be required?
 
 In physics-based gaming one of the most important concepts you'll ever learn is **collision detection**. A simple collision detection system is how we can tell whether the ball is hitting the paddle, the walls, or if a goal happens.
  
 ## Let's play some tennis!
 
 */
import SwiftProcessing
import PlaygroundSupport
import UIKit

class MySketch: Sketch, SketchDelegate {
    
    var ball: Ball!
    var paddle: Paddle!
    
    func setup() {
        ball = Ball(sketch: self)
        paddle = Paddle(sketch: self)
    }
    
    func draw() {
        background(0)
        ball.display()
        paddle.display()
        if collision(ball: ball, paddle: paddle) {
            ball.reverseY()
        }
    }
    
    func touchStarted() {
        paddle.moveTo(target: touchX)
    }
    
    func touchMoved() {
        paddle.moveTo(target: touchX)
    }
    
    func collision(ball: Ball, paddle: Paddle) -> Bool {
        return
            ((ball.x + ball.size/2 > paddle.x - paddle.width/2) &&
                (ball.x - ball.size/2 < paddle.x + paddle.width/2) &&
                (ball.y + ball.size/2 > paddle.y - paddle.height/2))
        
    }
 }

class Ball {
    var sketch: Sketch
    
    var size = 25
    var minSpeed = 1
    var maxSpeed = 10
    
    
    var x: Double
    var y: Double
    var speed: Sketch.Vector
    
    init(sketch: Sketch) {
        self.sketch = sketch
        
        self.x = sketch.random(size/2, sketch.width-size/2)
        self.y = sketch.random(size/2, sketch.height-size/2)
        
        self.speed = sketch.createVector(sketch.random(minSpeed, maxSpeed), sketch.random(minSpeed, maxSpeed))
        
        
    }
    
    func display() {
        sketch.fill(255)
        sketch.noStroke()
        sketch.circle(x, y, size)
        move()
        checkForWalls()
    }
    
    func move() {
        x += speed.x
        y += speed.y
    }
    
    func reverseY() {
        speed.y *= -1
    }
    
    func checkForWalls() {
        if x > sketch.width - size/2 || x < size/2 {
            speed.x *= -1
        }
        
        if y > sketch.height - size/2 || y < size/2 {
            speed.y *= -1
        }
    }
    
}

class Paddle {
    
    var sketch: Sketch
    
    var lerpAmount = 0.25
    
    var x: Double
    var y: Double
    var targetX: Double
    
    var width = 150
    var height = 30
    
    init(sketch: Sketch) {
        self.sketch = sketch
        self.x = sketch.width/2
        self.y = sketch.height - 60
        self.targetX = sketch.width/2
    }
    
    func display() {
        x = sketch.constrain(sketch.lerp(x, targetX, lerpAmount), width/2, sketch.width - width/2)
        sketch.fill(127)
        sketch.noStroke()
        sketch.rectMode(.center)
        sketch.rect(x,y, width, height)
    }
    
    func moveTo(target: Double) {
        self.targetX = target
    }
    
}
//: ## Challenge: Make this game your own! Add a score system and create a challenge. Multiple balls? Will the balls speed up as you play longer? One way might be to add some bricks to break or obstacles. Did you notice how the ball goes into the walls and the paddle a bit? How could you fix that?
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MySketch())
//: [Next](@next)
