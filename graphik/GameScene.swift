//
//  GameScene.swift
//  graphik
//
//  Created by Zuzana Dostálová on 06/03/15.
//  Copyright (c) 2015 zuzana.dostalova. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
     
        let totalWidth = UIScreen.mainScreen().bounds.width
        
        NSLog("%@", totalWidth)
        
        let rows = 20
        let cols = 10
        let offset = 35
        let size: CGFloat = 30
        
        for var i = 0; i < rows; i = i + 1 {
            for var j = 0; j < cols; j++ {
                let position = CGPoint(x: offset*j, y: offset*i)
                
                var color = SKColor.redColor()
                if ((i + j) % 2 == 1) {
                    color = SKColor.purpleColor()
                }
                let square = generateSquare(position, size: size, color: color)
                
                self.addChild(square)
            }
        }
    }
    
    func generateSquare(position: CGPoint, size: CGFloat, color: SKColor) -> SKShapeNode {
        var square = SKShapeNode(rectOfSize: CGSize(width: size, height: size))
        square.name = "square"
        square.fillColor = color
        square.position = position
        return square
    }
}
