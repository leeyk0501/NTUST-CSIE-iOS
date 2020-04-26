//
//  GameViewController.swift
//  Myspritekit
//
//  Created by B10615013 on 2020/4/1.
//  Copyright © 2020 B10615013. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = HelloScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}
