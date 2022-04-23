//
//  AudioManager.swift
//  Ripples
//
//  Created by Bittenco on 22/04/22.
//

import Foundation
import AVFoundation
import SpriteKit

class AudioManager {
    
    var playerA: AVAudioPlayer?
    var playerB: AVAudioPlayer?
    
    var gameScene: GameScene?
    
    func playMusicA(forResource: String) {
        let soundURL = Bundle.main.url(forResource: forResource, withExtension: "mp3")
        
        
        do {
        try playerA = AVAudioPlayer(contentsOf: soundURL!)
        } catch {
            print(error)
        }
        
        playerA?.setVolume(1, fadeDuration: 1)
        playerA?.numberOfLoops = -1
        playerA?.play()
    }
    
    func playMusicB(forResource: String) {
        let soundURL = Bundle.main.url(forResource: forResource, withExtension: "mp3")
        
        do {
        try playerB = AVAudioPlayer(contentsOf: soundURL!)
        } catch {
            print(error)
        }
        
        playerB?.setVolume(0, fadeDuration: 1)
        playerB?.numberOfLoops = -1
        playerB?.play()
    }
    
    func fadeIn(player: AVAudioPlayer) {
        let player = player
        player.setVolume(0.5, fadeDuration: 2)
    }
    
    func updateVolume(volume: Float, player: AVAudioPlayer) {
                
        let player = player
        
        player.volume = volume
        
        if volume >= 0.5 {
            player.volume = 0.49
        }
        
//        if volume < 0 {
//            player.setVolume(0, fadeDuration: 0)
//        }; if volume < 0.3 {
//            player.setVolume(0.1, fadeDuration: 0)
//        }; if volume < 0.6 {
//            player.setVolume(0.3, fadeDuration: 0)
//        }; if volume > 0.6 {
//            player.setVolume(0.5, fadeDuration: 0)
//        }
        
    }
    
//    func raiseVolume() {
//        player?.setVolume(1, fadeDuration: 0)
//    }
    
}

