//
//  GameViewController.swift
//  byBall
//
//  Created by Stas Dashkevich on 8/29/20.
//  Copyright © 2020 Stas Dashkevich. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

protocol LongTapDelegate {
    func touchBegan()
    func touchEnded()
}

class GameViewController: UIViewController {
    
    @objc func longTap(sender: Any) {
        print(1)
        guard let long = sender as? UILongPressGestureRecognizer else { return }
        print(2)
        if long.state == .began {
            scene?.touchBegan()
        } else {
            scene?.touchEnded()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    lazy var scene: GameScene? = { SKScene(fileNamed: "GameScene") as? GameScene }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
        gesture.allowableMovement = 1000
        self.view?.addGestureRecognizer(gesture)
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = scene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
