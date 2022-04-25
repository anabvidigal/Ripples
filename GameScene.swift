//
//  GameScene.swift
//  Ripples
//
//  Created by Bittenco on 22/04/22.
//

import SwiftUI
import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    var audioManager = AudioManager()
    var status: PlaygroundStatus = .intro
    
    // Intro
    let introImage = SKSpriteNode(imageNamed: "Consolidated-Clear")
    let introQuoteImage = SKSpriteNode(imageNamed: "introQuote-transp")

    // First chapter
    let mainCircle = SKShapeNode(circleOfRadius: 10)
    let firstCircle = SKShapeNode(circleOfRadius: 10)
    let firstPhrase = SKSpriteNode(imageNamed: "text-a")
    
    
    // DIDMOVE
    override func didMove(to view: SKView) {
        playIntro()
        setupMainCircle()
        setupFirstCircle()
        setupMusic()
    }
    
    // Intro functions
    func playIntro() {
        introImage.size = CGSize(width: frame.width/1.1, height: frame.height/1.1)
        introImage.position = CGPoint(x: frame.height/2, y: frame.width/2)
        addChild(introImage)
        animateIntro()
    }
    
    func animateIntro() {
        let opacityDown = SKAction.fadeAlpha(to: 0.3, duration: 3)
        let opacityUp = SKAction.fadeAlpha(to: 1, duration: 3)
        let sequence = SKAction.sequence([opacityDown, opacityUp])
        let repeatForever = SKAction.repeat(sequence, count: 10)
        repeatForever.timingMode = SKActionTimingMode.easeInEaseOut
        introImage.run(repeatForever)
    }
    
    func fadeOutIntro() {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let remove = SKAction.run({ introImage.removeFromParent }())
        let sequence = SKAction.sequence([fadeOut, remove])
        introImage.run(sequence)
    }
    
    func setupIntroQuote() {
        introQuoteImage.size = CGSize(width: frame.width/1.8, height: frame.height/1.8)
        introQuoteImage.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        introQuoteImage.alpha = 0
        addChild(introQuoteImage)
    }
    
    func setupFirstPhrase() {
        firstPhrase.size = CGSize(width: frame.width/2.2, height: frame.height/2.2)
        firstPhrase.position = CGPoint(x: self.frame.midX, y: self.frame.midY-300)
        firstPhrase.alpha = 0
        addChild(firstPhrase)
    }
    
    // Fade-ins and Fade-outs
    func fadeInIntroQuote() {
        let fadeIn = SKAction.fadeIn(withDuration: 3)
        fadeIn.timingMode = SKActionTimingMode.easeIn
        introQuoteImage.run(fadeIn)
    }
    
    func fadeOutIntroQuote() {
        let fadeOut = SKAction.fadeOut(withDuration: 2)
        fadeOut.timingMode = SKActionTimingMode.easeOut
        introQuoteImage.run(fadeOut)
    }
    
    func fadeInFirstPhrase() {
        
        let wait = SKAction.wait(forDuration: 2)
        let fadeIn = SKAction.fadeIn(withDuration: 3)
        fadeIn.timingMode = SKActionTimingMode.easeIn
        let sequence = SKAction.sequence([wait, fadeIn])
        firstPhrase.run(sequence)
    }
    
    func fadeOutFirstPhrase() {
        let fadeOut = SKAction.fadeOut(withDuration: 2)
        fadeOut.timingMode = SKActionTimingMode.easeOut
        firstPhrase.run(fadeOut)
    }
    
    // Spatial Audio Test
//    func playAudioNodeTest() {
//        let music = SKAudioNode(fileNamed: "csharp.wav")
//        addChild(music)
//
//        music.isPositional = true
//        music.position = CGPoint(x: otherCircle.position.x, y: otherCircle.position.y)
        
//        let moveForward = SKAction.moveTo(x: 1024, duration: 2)
//            let moveBack = SKAction.moveTo(x: -1024, duration: 2)
//            let sequence = SKAction.sequence([moveForward, moveBack])
//            let repeatForever = SKAction.repeatForever(sequence)
//
//            music.run(repeatForever)
//    }
    
    // UPDATE
    override func update(_ currentTime: TimeInterval) {
        updateFirstCircleVolume()
    }
    
    // Controlling volume with distance
    func updateFirstCircleVolume() {
        let distance = firstCircle.distance(to: mainCircle)
        let maxDistance = sqrt(pow(frame.height / 2, 2) + pow(frame.width / 2, 2))
        let currentVolume = 1 - (distance / maxDistance)
        
        // Why is this crashing?
        audioManager.updateVolume(volume: Float(currentVolume), player: audioManager.playerB!)
        
    }
        
        // Code for touch on specific node
//        if let touch = touches.first {
//            let location = touch.location(in: self)
//            let touchedNodes = self.nodes(at: location)
//            for node in touchedNodes.reversed() {
//
//                if node.name == "otherCircle" {
//                    self.currentNode = node
//                }
//            }
//        }
    
    // Circles
    
    func setupMainCircle() {
        mainCircle.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        mainCircle.alpha = 0
        mainCircle.glowWidth = 1.0
        mainCircle.fillColor = .clear
        mainCircle.name = "mainCircle"
    }
    
    func fadeInMainCircle() {
        self.addChild(mainCircle)
        let animation = SKAction.sequence([
            .wait(forDuration: 2),
            .fadeIn(withDuration: 3)
        ])
        mainCircle.run(animation)
    }
    
    func setupFirstCircle() {
        firstCircle.position = CGPoint(x: (mainCircle.position.x)-900, y: (mainCircle.position.y)-900)
        firstCircle.glowWidth = 1.0
        firstCircle.fillColor = .clear
        firstCircle.name = "firstCircle"
    }
    
    func runFirstCircle() {
        
        self.addChild(firstCircle)

        let approach = SKAction.move(to: CGPoint(x: (mainCircle.position.x)-30, y: (mainCircle.position.y)-30), duration: 4)
        let wait = SKAction.wait(forDuration: 3)
        let stepBack = SKAction.move(to: CGPoint(x: (mainCircle.position.x)+210, y: (mainCircle.position.y)+120), duration: 4)
        
        approach.timingMode = SKActionTimingMode.easeInEaseOut
        stepBack.timingMode = SKActionTimingMode.easeInEaseOut
        
        let sequence = SKAction.sequence([approach, wait, stepBack])
        firstCircle.run(sequence)
    
    }
    
    
    // Music
    func setupMusic() {
        audioManager.playMusicA(forResource: "ChapA-1")
        audioManager.playMusicB(forResource: "ChapA-2")
    }
    
    func fadeInMainCircleMusic() {
        audioManager.fadeIn(player: audioManager.playerA!)
    }
    
    func fadeInFirstCircleMusic() {
        audioManager.fadeIn(player: audioManager.playerB!)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        switch status {
        case .intro:
            status = .chapterA
            fadeOutIntro()
            setupIntroQuote()
            fadeInIntroQuote()
            fadeInMainCircleMusic()
            
        case .chapterA:
            status = .chapterB
            fadeOutIntroQuote()
            fadeInMainCircle()
            fadeInFirstPhrase()
            setupFirstPhrase()
            
            // from the very first days of our lives,
            // we are surrounded by people that care for us
            
            // Include first circle after delay
            // Include second circle after delay
            // Include other circles
            // Include other circles sounds
            
            // along with them, we learn and grow
            
            // Keep main sound slightly changed (fade out and fade in)
            // Include touch icon
            
        case .chapterB:
            status = .chapterC
            // Bring up after delay
            runFirstCircle()
            fadeInFirstCircleMusic()
            
            // Fade out touch icon
            // Move out circles that stayed from previous
            // Fade in other groups of circles
            // Fade their sounds in (with different tones)
            
            // some of them stay close,
            // while others grow apart from us
            
            // Move circles
            
            // Fade in main sound slightly transformed
            // Include touch icon
            
        case .chapterC:
            status = .chapterD
            print("chapter C clicked")
            
            // we learn to love,
            // and learn what it is to be loved
            
            // Move out most, but one circle
            // Fade in new text
            // Make movements of circling
            
            // sometimes, life leads us to different paths
            
            // Move circle away
            
            // but we carry on
            // transform sound
            // with new marks
            
            // Include touch icon
            
        case .chapterD:
            status = .chapterE
            print("chapter D clicked")
            
            // Bring some circles again
            // Bring up their volume
            // Bring most of the circles opacity down
            // One circle stays
            // Main circle beep-beeps
            // Other circle beeps back and steps back
            // Main circle repeats beep
            // Other circle goes further away
            // Main circle changes beep melody
            // Other circle comes back closer
            // Bring in texts
            
            
        case .chapterE:
            print("chapter E clicked")

        }
        
    }
    
}


extension SKNode {
    func distance(to other: SKNode) -> CGFloat {
        sqrt(pow(position.x - other.position.x ,2) + pow(position.y - other.position.y, 2))
    }
}

enum PlaygroundStatus {
    case intro
    case chapterA
    case chapterB
    case chapterC
    case chapterD
    case chapterE
}
