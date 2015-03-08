//
//  GameScene.swift
//  graphik
//
//  Created by Zuzana Dostálová on 06/03/15.
//  Copyright (c) 2015 zuzana.dostalova. All rights reserved.
//

import SpriteKit

class Tile: SKShapeNode {
    var row: Int = 0
    var col: Int = 0
    var visited = false
}

class GameScene: SKScene {
    var matrix = Array<Array<Tile>>()
    
    override func didMoveToView(view: SKView) {
     
        let totalWidth = UIScreen.mainScreen().bounds.width
        
        let rows = 20
        let cols = 10
        let offset = 35
        let size: CGFloat = 30
        
        for var i = 0; i < rows; i = i + 1 {
            var row = Array<Tile>()
            for var j = 0; j < cols; j++ {
                let position = CGPoint(x: offset*j, y: offset*i)
                
                let color = SKColor(red: 0.7, green: 0.45, blue: 0.65, alpha: 1)
                let tile = generateSquare(position, size: size, color: color)
                tile.row = i
                tile.col = j

                if arc4random() % 3 >= 2 {
                    tile.visited = true
                    tile.fillColor = SKColor(red: 0.4, green: 0.7, blue: 0.4, alpha: 1)
                }

                
                self.addChild(tile)
                row.append(tile)
            }
            
            matrix.append(row)
        }
    }
    
    func generateSquare(position: CGPoint, size: CGFloat, color: SKColor) -> Tile {
        var square = Tile(rectOfSize: CGSize(width: size, height: size))
        square.name = "square"
        square.fillColor = color
        // square.fillTexture = SKTexture(imageNamed: "green2")
        square.position = position
        return square
    }
    
    var queue = Array<Tile>()
    
    func bfs(tile: Tile?) {
        if tile != nil {
            queue.append(tile!)
        }
        
        if (queue.count > 0) {
            var tile = queue.removeAtIndex(queue.count - 1)
//            var tile = queue.removeAtIndex(0)
            
            if (!tile.visited) {
                tile.visited = true
                tile.fillColor = SKColor(red: 0.5, green: 0.2, blue: 0.5, alpha: 1)
                
                queue.append(matrix[(tile.row) % matrix.count][(tile.col + 1) % matrix[0].count])
                queue.append(matrix[(tile.row + 1) % matrix.count][(tile.col) % matrix[0].count])
                
                queue.append(matrix[tile.row][max(tile.col - 1, 0)])
                queue.append(matrix[max(tile.row - 1, 0)][tile.col])
                NSLog("visited tile %d %d", tile.row, tile.col)
            }
            
            runAction(SKAction.sequence([
                SKAction.waitForDuration(0.02),
                SKAction.runBlock({
                    self.bfs(nil)
                })
            ]))
        }
    }
    
    var started = false
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if let touch = touches.anyObject() as? UITouch {
            
            if let tile = nodeAtPoint(touch.locationInNode(self)) as? Tile {
                if !started {
                    started = true
                    self.bfs(tile)
                } else {
                    self.bfs(nil)
                }
            }
        }
        
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if let touch = touches.anyObject() as? UITouch {
            let fadeIn = SKAction.fadeInWithDuration(0)
            
            
            if let shapeNode = nodeAtPoint(touch.locationInNode(self)) as? Tile {
                shapeNode.runAction(fadeIn)
            }
        }
    }
}
