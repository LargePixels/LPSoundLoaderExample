//
//  OptionsLoader.swift
//  Heavy Metal Samurais
//
//  Created by john on 1/16/16.
//  Copyright © 2016 Large Pixels. All rights reserved.
//

import Foundation

let SharedLPOptionsLoader = LPOptionsLoader.sharedInstance

class LPOptionsLoader {
    
    static let sharedInstance = LPOptionsLoader()
    
    var playSfx: Bool {
        get {
            return NSUserDefaults.standardUserDefaults().boolForKey("playSfx")
        }
        set {
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "playSfx")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var playMusic: Bool {
        get {
            return NSUserDefaults.standardUserDefaults().boolForKey("playMusic")
        }
        set {
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "playMusic")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    private init() {
        if ( NSUserDefaults.standardUserDefaults().objectForKey("playSfx") == nil ) {
            playSfx = true
        }
        
        if ( NSUserDefaults.standardUserDefaults().objectForKey("playMusic") == nil ) {
            playMusic = true
        }

        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
}
