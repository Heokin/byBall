//
//  GameScene.swift
//  byBall
//
//  Created by Stas Dashkevich on 8/29/20.
//  Copyright © 2020 Stas Dashkevich. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var isTap: Bool = false
    
    func touchBegan() {
        isTap = true
    }
    
    func touchEnded() {
        isTap = false
    }
    
    // init
    var levelsGameBackground: SKSpriteNode?
    var mainPlatform: SKSpriteNode!
    var mainBalls: SKSpriteNode!
    var mainhole: SKSpriteNode!
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
        self.view?.addGestureRecognizer(gesture)
    }
    
    @objc func longTap(sender: Any) {
        print()
    }
    
    override func didMove(to view: SKView) {
        
        // gradient
        let context = CIContext(options: nil)
        var filter = CIFilter(name: "CILinearGradient")
        let startVector = CIVector(x: size.width * 0.5, y: 0)
        let endVector = CIVector(x: size.width * 0.5, y: size.height)
        let color1 = CIColor(red: 70/255, green: 120/255, blue: 30/255, alpha: 1)
        let color2 = CIColor(red: 20/255, green: 40/255, blue: 60/255, alpha: 1)

        //Here I would change all rgb values by +- 0.2 - 0.5
        filter?.setDefaults()

        filter?.setValue(startVector, forKey: "inputPoint0")
        filter?.setValue(endVector, forKey: "inputPoint1")
        filter?.setValue(color1, forKey: "inputColor0")
        filter?.setValue(color2, forKey: "inputColor1")

        guard let outputImage = filter?.outputImage else { return }
        let image = context.createCGImage(outputImage, from: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let texture = SKTexture(image: UIImage(cgImage: image!))
        levelsGameBackground?.texture = texture
        
        
        
//        levelsGameBackground = SKSpriteNode(imageNamed: "back")
        mainPlatform = SKSpriteNode(imageNamed: "platform")
        mainBalls = SKSpriteNode(imageNamed: "ball")
        mainhole = SKSpriteNode(imageNamed: "hole")
        mainhole.isHidden = true
        // ph ball
        mainBalls.physicsBody = SKPhysicsBody(texture: mainBalls.texture!, size: mainBalls.size)
        mainPlatform.physicsBody = SKPhysicsBody(texture: mainPlatform.texture!, size: mainPlatform.size)
        mainPlatform.physicsBody?.isDynamic = false
        // Scale
        mainPlatform.xScale = 0.7
        mainPlatform.position = CGPoint(x: frame.size.width / mainPlatform.frame.size.width, y: -470)
        mainBalls.position = CGPoint(x: 100, y: -400)
        // addChild
//        addChild(levelsGameBackground)
        addChild(mainPlatform)
        addChild(mainBalls)
        addChild(mainhole)
        // zPosition
//        levelsGameBackground.zPosition = 0
        mainPlatform.zPosition = 1
        mainBalls.zPosition = 2
        
//        let moveBackGround = SKAction.move(by: CGVector(dx: 0, dy: 500), duration: 1)
//        levelsGameBackground.run(moveBackGround)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch")
        for touch_1 in touches{
            let location = touch_1.location(in: self)
            if location.x < UIScreen.main.bounds.midX{
                
                //        let touch = touches.first
                //        let touchesLocation = touch?.location(in: self)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.leftHandRun(isFirstTap: true)
                }
                
//                let rotatePlatform = SKAction.rotate(byAngle: 0.09, duration: 1)
//                mainPlatform.run(rotatePlatform)
            } else if location.x > UIScreen.main.bounds.midX{
                let rotatePlatform = SKAction.rotate(byAngle: -0.09, duration: 1)
                mainPlatform.run(rotatePlatform)
            }
        }
    }
    
    func leftHandRun(isFirstTap: Bool) {
        let duration: TimeInterval = 0.1
        let rotatePlatform = SKAction.rotate(byAngle: 0.009, duration: duration)
        mainPlatform.run(rotatePlatform)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            print(self.isTap)
            guard isFirstTap || self.isTap else { return }
            self.leftHandRun(isFirstTap: false)
        }
    }
//    func holeGeneration() -> SKSpriteNode{
//        let hole = SKSpriteNode(imageNamed: "hole")
//        hole.position.x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound:6))
//        hole.position.y = frame.size.height + hole.size.height
//
//        hole.physicsBody = SKPhysicsBody(texture: hole.texture!, size: hole.size)
//        return hole
//    }
//
//    override func update(_ currentTime: TimeInterval) {
//        let hole = holeGeneration()
//        addChild(hole)
//    }
}

