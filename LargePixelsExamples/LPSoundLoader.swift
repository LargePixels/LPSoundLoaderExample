//
//  SoundLoader.swift
//  Heavy Metal Samurais
//
//  Created by john on 1/11/16.
//  Copyright © 2016 Large Pixels. All rights reserved.
//

import Foundation
import AVFoundation
import SpriteKit

//Global variable available to all objects
let SharedLPSoundLoader = LPSoundLoader.sharedInstance

/**
 This object can be used to preload sounds and rapidly play them 
*/
class LPSoundLoader {
    
    static let sharedInstance = LPSoundLoader()
    
    private init() {
        soundDictionary.setValue(SKAction.playSoundFileNamed("slash1.m4a", waitForCompletion: false), forKey: "slash1.m4a")
        soundDictionary.setValue(SKAction.playSoundFileNamed("slash2.m4a", waitForCompletion: false), forKey: "slash2.m4a")
        soundDictionary.setValue(SKAction.playSoundFileNamed("slash3.m4a", waitForCompletion: false), forKey: "slash3.m4a")
        soundDictionary.setValue(SKAction.playSoundFileNamed("slash4.m4a", waitForCompletion: false), forKey: "slash4.m4a")
        soundDictionary.setValue(SKAction.playSoundFileNamed("swoosh1.m4a", waitForCompletion: false), forKey: "swoosh1.m4a")
        soundDictionary.setValue(SKAction.playSoundFileNamed("swoosh2.m4a", waitForCompletion: false), forKey: "swoosh2.m4a")
        soundDictionary.setValue(SKAction.playSoundFileNamed("swoosh3.m4a", waitForCompletion: false), forKey: "swoosh3.m4a")
        soundDictionary.setValue(SKAction.playSoundFileNamed("swoosh4.m4a", waitForCompletion: false), forKey: "swoosh4.m4a")
        //soundDictionary.setValue(SKAction.playSoundFileNamed("land1.m4a", waitForCompletion: false), forKey: "land1.m4a")
        //soundDictionary.setValue(SKAction.playSoundFileNamed("land2.m4a", waitForCompletion: false), forKey: "land2.m4a")
        //soundDictionary.setValue(SKAction.playSoundFileNamed("ouch1.m4a", waitForCompletion: false), forKey: "ouch1.m4a")
        //soundDictionary.setValue(SKAction.playSoundFileNamed("ouch2.m4a", waitForCompletion: false), forKey: "ouch2.m4a")
        //soundDictionary.setValue(SKAction.playSoundFileNamed("ouch3.m4a", waitForCompletion: false), forKey: "ouch3.m4a")
        //soundDictionary.setValue(SKAction.playSoundFileNamed("ouch4.m4a", waitForCompletion: false), forKey: "ouch4.m4a")
        //soundDictionary.setValue(SKAction.playSoundFileNamed("ouch5.m4a", waitForCompletion: false), forKey: "ouch5.m4a")
        //soundDictionary.setValue(SKAction.playSoundFileNamed("death_groan1.m4a", waitForCompletion: false), forKey: "death_groan1.m4a")
        //soundDictionary.setValue(SKAction.playSoundFileNamed("death_groan2.m4a", waitForCompletion: false), forKey: "death_groan2.m4a")
        //soundDictionary.setValue(SKAction.playSoundFileNamed("death_groan3.m4a", waitForCompletion: false), forKey: "death_groan3.m4a")
        //soundDictionary.setValue(SKAction.playSoundFileNamed("death_groan4.m4a", waitForCompletion: false), forKey: "death_groan4.m4a")
        //soundDictionary.setValue(SKAction.playSoundFileNamed("death_groan5.m4a", waitForCompletion: false), forKey: "death_groan5.m4a")
        //soundDictionary.setValue(SKAction.playSoundFileNamed("death_groan6.m4a", waitForCompletion: false), forKey: "death_groan6.m4a")
        //soundDictionary.setValue(SKAction.playSoundFileNamed("power_up.m4a", waitForCompletion: false), forKey: "power_up.m4a")
    }
    
    //MARK: Sfx Player
    
    let soundDictionary = NSMutableDictionary()
    
    //should always use this so we don't play sounds it it's disabled
    func playRandomSfx(sfxPrefix: String, onWhat: SKNode) {
        if (!SharedLPOptionsLoader.playSfx) {
            return
        }
        
        switch sfxPrefix {
        case "slash":
            onWhat.runAction(getRandomSlashSoundAction())
        case "land":
            onWhat.runAction(getRandomLandSoundAction())
        case "swoosh":
            onWhat.runAction(getRandomSwooshSoundAction())
        case "ouch":
            onWhat.runAction(getRandomOuchSoundAction())
        case "death_groan":
            onWhat.runAction(getRandomDeathGroanSoundAction())
        default:
            print("tried playing a sound type we don't have")
        }
    }
    
    //play sounds not part of a collection
    func playSfx(sfxName: String, onWhat: SKNode) {
        if (!SharedLPOptionsLoader.playSfx) {
            return
        }
        
        onWhat.runAction(soundDictionary.objectForKey(sfxName) as! SKAction)
    }
    
    private func getRandomSlashSoundAction() -> SKAction {
        let randomInt = Int.random(1, max: 4)
        return soundDictionary.objectForKey("slash\(randomInt).m4a") as! SKAction
    }
    
    private func getRandomLandSoundAction() -> SKAction {
        let randomInt = Int.random(1, max: 2)
        return soundDictionary.objectForKey("land\(randomInt).m4a") as! SKAction
    }
    
    private func getRandomSwooshSoundAction() -> SKAction {
        let randomInt = Int.random(1, max: 4)
        return soundDictionary.objectForKey("swoosh\(randomInt).m4a") as! SKAction
    }
    
    private func getRandomOuchSoundAction() -> SKAction {
        let randomInt = Int.random(1, max: 5)
        return soundDictionary.objectForKey("ouch\(randomInt).m4a") as! SKAction
    }
    
    private func getRandomDeathGroanSoundAction() -> SKAction {
        let randomInt = Int.random(1, max: 6)
        return soundDictionary.objectForKey("death_groan\(randomInt).m4a") as! SKAction
    }
    
    //MARK: Background Music
    
    var backgroundMusicPlayer: AVAudioPlayer?
    var lastSetVolume = Float(0.0)
    
    func playBackgroundMusic(filename: String) {
        playBackgroundMusic(filename, loops: -1)
    }
    
    func playBackgroundMusic(filename: String, loops: Int) {
        playBackgroundMusic(filename, loops: loops, volume: 1.0)
    }
    
    func playBackgroundMusic(filename: String, loops: Int, volume: Float) {
        
        lastSetVolume = volume
        
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        if (url == nil) {
            print("Could not find file: \(filename)")
            return
        }
        
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: url!)
            if let player = backgroundMusicPlayer {
                player.volume = SharedLPOptionsLoader.playMusic ? lastSetVolume : 0.0
                player.numberOfLoops = loops
                player.prepareToPlay()
                player.play()
            }
        }
        catch {
            print("Could not create audio player")
        }
    }
    
    func setVolumeBackToLastSet() {
        backgroundMusicPlayer?.volume = lastSetVolume
    }
    
    
    func setVolumeToZero() {
        backgroundMusicPlayer?.volume = 0.0
    }
    
    func pauseBackgroundMusic() {
        if let player = backgroundMusicPlayer {
            if player.playing {
                player.pause()
            }
        }
    }
    
    func resumeBackgroundMusic() {
        if let player = backgroundMusicPlayer {
            if !player.playing {
                player.play()
            }
        }
    }
    
}