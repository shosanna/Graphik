//
//  MenuScene.swift
//  graphik
//
//  Created by Dostalova, Zuzana on 08/03/15.
//  Copyright (c) 2015 zuzana.dostalova. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    override func didMoveToView(view: SKView) {
        let bg: SKSpriteNode = SKSpriteNode(imageNamed: "stardust")
        bg.anchorPoint = CGPointMake(0.5, 0.5)
        bg.size.height = self.size.height
        bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        
        self.addChild(bg)
        
        let bfsLabel = SKLabelNode(fontNamed: "Avenir")
        bfsLabel.text = "BFS"
        bfsLabel.fontSize = 40
        bfsLabel.fontColor = SKColor.whiteColor()
        bfsLabel.name = "BFS"
        
        let width = view.bounds.width / 2
        let height = view.bounds.height / 2
        bfsLabel.position = CGPoint(x: width, y: height)
        addChild(bfsLabel)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if let touch = touches.anyObject() as? UITouch {
            
            if let label = nodeAtPoint(touch.locationInNode(self)) as? SKLabelNode {
                if label.name == "BFS" {
                    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1.0)
                    
                    let scene = GameScene(size: self.scene!.size)
                    scene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene!.view!.presentScene(scene, transition: transition)
                }
            }
        }
    }
}