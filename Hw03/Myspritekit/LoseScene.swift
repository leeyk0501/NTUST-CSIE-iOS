//
//  LoseScene.swift
//  Myspritekit
//
//  Created by B10615013 on 2020/4/23.
//  Copyright © 2020 B10615013. All rights reserved.
//

import UIKit
import SpriteKit

class LoseScene: SKScene {
    var score = 0
    
    override func didMove(to view: SKView) {
        loseScene()
    }
    
    func loseScene() {
        let bgd = SKSpriteNode(imageNamed: "losespace.jpg")
        bgd.size.width = self.size.width
        bgd.size.height = self.size.height
        bgd.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        bgd.zPosition = -1
        
        let loselabel = SKLabelNode(text: "You lose!")
        loselabel.name = "label"
        loselabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
        loselabel.fontName = "Avenir-Oblique"
        loselabel.fontSize = 45
        loselabel.color = SKColor.yellow
        
        self.addChild(bgd)
        self.addChild(loselabel)
        
        
        //show score
        _ = MainScene(size: self.size)
        let alertController = UIAlertController(title: "You lose!", message: "Score: \(self.score)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Again", style: .default) { (_) in
            let mainScene = MainScene(size: self.size)
            let doors = SKTransition.doorsOpenVertical(withDuration: 0.5)
            self.view?.presentScene(mainScene, transition: doors)
        }
        alertController.addAction(okAction)
        view?.window?.rootViewController?.present(alertController, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let mainScene = MainScene(size: self.size)
        let doors = SKTransition.doorsOpenVertical(withDuration: 0.5)
        self.view?.presentScene(mainScene, transition: doors)
    }
    
}
