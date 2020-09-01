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
    // init
    var levelsGameBackground: SKSpriteNode!
    var mainPlatform: SKSpriteNode!
    var mainBalls: SKSpriteNode!
    var mainhole: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        levelsGameBackground = SKSpriteNode(imageNamed: "back")
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
        addChild(levelsGameBackground)
        addChild(mainPlatform)
        addChild(mainBalls)
        addChild(mainhole)
        // zPosition
        levelsGameBackground.zPosition = 0
        mainPlatform.zPosition = 1
        mainBalls.zPosition = 2
        
        let moveBackGround = SKAction.move(by: CGVector(dx: 0, dy: 500), duration: 1)
        levelsGameBackground.run(moveBackGround)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch_1 in touches{
            let location = touch_1.location(in: self)
            if location.x<UIScreen.main.bounds.midX{
        
//        let touch = touches.first
//        let touchesLocation = touch?.location(in: self)

            let rotatePlatform = SKAction.rotate(byAngle: 0.09, duration: 1)
            mainPlatform.run(rotatePlatform)
            } else if location.x > UIScreen.main.bounds.midX{
                let rotatePlatform = SKAction.rotate(byAngle: -0.09, duration: 1)
                mainPlatform.run(rotatePlatform)
            }
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

