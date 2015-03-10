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
        initilizeBackground("stardust")
        initializeMap()
    }
    
    // INITIALIZE the main map with tiles
    func initializeMap() {
        let totalWidth = UIScreen.mainScreen().bounds.width
        
        let rows = 21
        let cols = 13
        let offset = 30
        let size: CGFloat = 30
        
        for var i = 0; i < rows; i = i + 1 {
            var row = Array<Tile>()
            for var j = 0; j < cols; j++ {
                let position = CGPoint(x: offset*j, y: offset*i)
                
                let texture = SKTexture(imageNamed: "green1")
                let tile = generateSquare(position, size: size, texture: texture)
                tile.row = i
                tile.col = j

                if arc4random() % 3 >= 2 {
                    tile.visited = true
                    tile.fillColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1)
                    tile.fillTexture = SKTexture(imageNamed: "wall1")
                }

                
                self.addChild(tile)
                row.append(tile)
            }
            
            matrix.append(row)
        }
    }
    
    // FUNC for generating tiles for the map
    func generateSquare(position: CGPoint, size: CGFloat, texture: SKTexture) -> Tile {
        var square = Tile(rectOfSize: CGSize(width: size, height: size))
        square.name = "square"
        square.fillColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1)
        square.fillTexture = texture
        
        square.position = position
        return square
    }
    
    var queue = Array<Tile>()
    // BFS algorithm
    func bfs(tile: Tile?) {
        if tile != nil {
            queue.append(tile!)
        }
        
        if (queue.count > 0) {
            // var tile = queue.removeAtIndex(queue.count - 1)
            var tile = queue.removeAtIndex(0)
            
            if (!tile.visited) {
                tile.visited = true
                
                tile.fillColor = SKColor(red: 0.4, green: 0.9, blue: 0.4, alpha: 1)
                //tile.fillTexture = SKTexture(imageNamed: "green1")
                
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
    // STARTS the algorithm when user touches any tile
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
    
    // SETS the background image
    func initilizeBackground(bg: String) {
        let bg: SKSpriteNode = SKSpriteNode(imageNamed: bg)
        bg.anchorPoint = CGPointMake(0.5, 0.5)
        bg.size.height = self.size.height
        bg.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        
        self.addChild(bg)
    }
}
