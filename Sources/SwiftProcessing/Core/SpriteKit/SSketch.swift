//
//  File.swift
//  
//
//  Created by Jonathan Kaufman on 4/7/20.
//

import Foundation



import UIKit
import SceneKit
import SpriteKit

public protocol SSketchDelegate: SSketch {
    func setup()
    func draw()
}

@IBDesignable open class SSketch: SKScene {
    //Processing Constants
    public let HALF_PI = CGFloat.pi / 2
    public let PI = CGFloat.pi
    public let QUARTER_PI = CGFloat.pi / 4
    public let TWO_PI = CGFloat.pi * 2
    public let TAU = CGFloat.pi * 2

    public let DEGREES = "degrees"
    public let RADIANS = "radians"

    public let RADIUS = "radius"
    public let CORNER = "corner"
    public let CORNERS = "corners"
    public let CENTER = "center"

    public let CLOSE = "close"
    public let NORMAL_VERTEX = "normal"
    public let CURVE_VERTEX = "curve"
    public let BEZIER_VERTEX = "bezier"
    
    public static let PIXELLATE = "pixellate"
    public let PIXELLATE = "pixellate"
    public static let HUE_ROTATE = "hue_rotate"
    public let HUE_ROTATE = "hue_rotate"
    public static let SEPIA_TONE = "sepia_tone"
    public let SEPIA_TONE = "sepia_tone"
    public static let TONAL = "tonal"
    public let TONAL = "tonal"
    public static let MONOCHROME = "monochrome"
    public let MONOCHROME = "monochrome"
    
    public let LEFT = "left"
    public let RIGHT = "right"
    public let TOP = "top"
    public let BOTTOM = "bottom"
    public let BASELINE = "baseline"

    public weak var sketchDelegate: SSketchDelegate?
    public var rect: CGRect = CGRect()
    public var width: CGFloat = 0
    public var height: CGFloat = 0
    public var isFaceMode: Bool = false
    public var isFaceFill: Bool = true

    public var frameCount: CGFloat = 0
    public var deltaTime: CGFloat = 1/60
    private var lastTime: CGFloat = CGFloat(CACurrentMediaTime())
    var fps: CGFloat = 60
    var fpsTimer: Timer?

    var strokeWeight: CGFloat = 1
    var isFill: Bool = true
    var isStroke: Bool = true
    var isErase: Bool = false

    var settingsStack: SketchSettingsStack = SketchSettingsStack()
    var settings: SketchSettings = SketchSettings()

    var vertexMode: String = "normal"
    var isContourStarted: Bool = false
    var contourPoints: [CGPoint] = []
    var shapePoints: [CGPoint] = []

    open var pixels: [UInt8] = []

    open var context: CGContext?
    open var root: SKSpriteNode?
    open var lastFrame: SKTexture?
//    public init() {
//        super.init(frame: CGRect())
//        sketchDelegate = self as? SSketchDelegate
//        sketchDelegate?.setup()
////        loop()
//    }
//
//    required public init(coder: NSCoder) {
//        super.init(coder: coder)!
//        sketchDelegate = self as? SSketchDelegate
//        sketchDelegate?.setup()
////        loop()
//    }
    open override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0,y: 1)
        sketchDelegate = self as? SSketchDelegate
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.root = SKSpriteNode()
//        self.root?.size = self.view!.frame.size
        self.addChild(self.root!)
        
        
        sketchDelegate?.draw()
    }
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    func touchDown(atPoint pos : CGPoint) {
        circle(pos.x, pos.y * -1, 10)
    }
    open override func update(_ currentTime: TimeInterval) {
        root?.removeFromParent()
        if let texture = self.view!.texture(from: root!) {
            let sprite = SKSpriteNode(texture:texture)
           
            root = sprite
        }
        addChild(root!)
        sketchDelegate?.draw()
    }
    
    

//    override public func draw(_ rect: CGRect) {
//        self.context = UIGraphicsGetCurrentContext()
//
//        if self.context == nil {
//            return
//        }
//
//        updateTimes()
//        self.width = rect.width
//        self.height = rect.height
//        self.rect = rect
//        sketchDelegate?.draw()
//    }

    private func updateTimes() {
        frameCount =  frameCount + 1
        let newTime = CGFloat(CACurrentMediaTime())
        deltaTime = newTime - lastTime
        lastTime = newTime
    }

    open func push() {
        context?.saveGState()
        settingsStack.push(settings: settings)
    }

    open func pop() {
        context?.restoreGState()
        settings = settingsStack.pop()!
//        settings.restore(sketch: self)
    }
}
public extension SSketch {

    func circle(_ x: CGFloat, _ y: CGFloat, _ d: CGFloat) {
       
            var n = SKShapeNode.init(rectOf: CGSize(width: d, height: d), cornerRadius: d)
            n.position = CGPoint(x: x, y: -y)
            root?.addChild(n)
            
        
    }

    
}
