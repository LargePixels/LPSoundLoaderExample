//
//  GameScene.swift
//  LargePixelsExamples
//
//  Created by john on 1/22/16.
//  Copyright (c) 2016 Large Pixels. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(myLabel)
    }
    
    var count = 0
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        for touch in touches {
            let location = touch.locationInNode(self)
            addSprite(location)
            
            SharedLPSoundLoader.playRandomSfx("slash", onWhat: self)
            
            if (count == 5) {
                SharedLPSoundLoader.playBackgroundMusic("rock2.m4a")
                SharedLPOptionsLoader.playSfx = false
            }
            
            if (count == 10) {
                SharedLPSoundLoader.pauseBackgroundMusic()
                SharedLPOptionsLoader.playSfx = true
            }
            
            if (count == 13) {
                SharedLPOptionsLoader.playSfx = true
            }
            
            count++
        }
    }

    func addSprite(location: CGPoint) {
        let sprite = SKSpriteNode(imageNamed:"Spaceship")
        
        sprite.xScale = 0.5
        sprite.yScale = 0.5
        sprite.position = location
        
        let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
        
        sprite.runAction(SKAction.repeatActionForever(action))
        
        self.addChild(sprite)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
