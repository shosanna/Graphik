//
//  GameViewController.swift
//  graphik
//
//  Created by Zuzana Dostálová on 06/03/15.
//  Copyright (c) 2015 zuzana.dostalova. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = MenuScene(size: view.bounds.size)
        let skView = view as SKView
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .AspectFill
        skView.presentScene(scene)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
