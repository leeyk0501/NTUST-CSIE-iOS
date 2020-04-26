//
//  HelloScene.swift
//  Myspritekit
//
//  Created by B10615013 on 2020/4/1.
//  Copyright © 2020 B10615013. All rights reserved.
//

import UIKit
import SpriteKit

class HelloScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        createScene()
    }
    
    func createScene() {
        
        //set background
        let bgd = SKSpriteNode(imageNamed: "hellobgd.jpg")
        bgd.size.width = self.size.width
        bgd.size.height = self.size.height
        bgd.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        bgd.zPosition = -1
        
        //set spaceLabel
        let spaceLabel = SKLabelNode(text: "Space")
        spaceLabel.name = "spaceLabel"
        spaceLabel.position = CGPoint(x: self.frame.midX-90, y: self.frame.maxY+5)
        spaceLabel.fontName = "Avenir-Oblique"
        spaceLabel.fontSize = 30
        
        //set emojiLabel
        let emojiLabel = SKLabelNode(text: " 🚀 ")
        emojiLabel.name = "emojiLabel"
        emojiLabel.position = CGPoint(x: self.frame.midX-20, y: self.frame.midY)
        emojiLabel.fontName = "Avenir-Oblique"
        emojiLabel.fontSize = 30
        
        //set adventureLabel
        let adventureLabel = SKLabelNode(text: "Adventure")
        adventureLabel.name = "adventureLabel"
        adventureLabel.position = CGPoint(x: self.frame.midX+70, y: -30)
        adventureLabel.fontName = "Avenir-Oblique"
        adventureLabel.fontSize = 30
        
        self.addChild(bgd)
        self.addChild(spaceLabel)
        self.addChild(emojiLabel)
        self.addChild(adventureLabel)
        
        //run spaceLabel & adventureLabel
        let spaceLabelNode = self.childNode(withName: "spaceLabel")
        let adventureLabelNode = self.childNode(withName: "adventureLabel")
        let movedown = SKAction.moveBy(x: 0, y:self.frame.midY-(spaceLabelNode?.position.y ?? 0), duration: 1)
        let moveup = SKAction.moveBy(x: 0, y:-(adventureLabelNode?.position.y ?? 0)+self.frame.midY, duration: 1)
        let movesequece1 = SKAction.sequence([movedown])
        let movesequece2 = SKAction.sequence([moveup])
        spaceLabelNode?.run(movesequece1)
        adventureLabelNode?.run(movesequece2)
        //adventureLabelNode?.run(movesequece)
        
        //run emojiLabel (fadein & fadeout repeat)
        let emojiLabelNode = self.childNode(withName: "emojiLabel")
        let fadIn = SKAction.fadeIn(withDuration: 0.5)
        let fadOut = SKAction.fadeOut(withDuration: 0.5)
        let list = SKAction.sequence([fadIn, fadOut])
        let repeatA = SKAction.repeatForever(list)
        emojiLabelNode?.run(repeatA)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let labelNode = self.childNode(withName: "emojiLabel")
        let zoomin = SKAction.scale(to: 3.0, duration: 1)
        let pause = SKAction.wait(forDuration: 0.5)
        let zoomout = SKAction.scale(by: 0.5, duration: 0.25)
        
        let remove = SKAction.removeFromParent()
        let movesequece = SKAction.sequence([zoomin, pause, zoomout, pause, remove])
        
        labelNode?.run(movesequece, completion: {
            let mainScene = MainScene(size: self.size)
            let doors = SKTransition.doorsOpenVertical(withDuration: 0.5)
            self.view?.presentScene(mainScene, transition: doors)
        })
    }
}
