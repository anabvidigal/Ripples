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
    let otherCircle = SKShapeNode(circleOfRadius: 10)
    var chapterAText: SKLabelNode!
    
    // DIDMOVE
    override func didMove(to view: SKView) {
        playIntro()
        setupMainCircle()
        setupOtherCircle()
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
        introQuoteImage.position = CGPoint(x: frame.height/2, y: frame.width/2)
        introQuoteImage.alpha = 0
        addChild(introQuoteImage)
    }
    
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
        updateVolume()
    }
    
    // Controlling volume with distance
    func updateVolume() {
        let distance = otherCircle.distance(to: mainCircle)
        let maxDistance = sqrt(pow(frame.height / 2, 2) + pow(frame.width / 2, 2))
        let currentVolume = 1 - (distance / maxDistance)
        
        // Why is this crashing?
        audioManager.updateVolume(volume: Float(currentVolume), player: audioManager.playerB!)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        switch status {
        case .intro:
            startIntroQuote()
        case .introTransition:
            chapterAInit()
        case .chapterA1:
            chapterARun()
        case .chapterA2:
            print("chapter A2 clicked")
        }
        
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
    
    // First click
    func startIntroQuote() {
        status = .introTransition
        fadeOutIntro()
        setupIntroQuote()
        fadeInIntroQuote()
        fadeInMainCircleMusic()
    }
    
    func chapterAInit() {
        fadeOutIntroQuote()
        fadeInMainCircle()
    }
    
    func chapterARun() {
        addOtherCircle()
        fadeInOtherCircleMusic()
    }
    
    
    // First chapter
    func setupMainCircle() {
        mainCircle.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        mainCircle.alpha = 0
//        mainCircle.position = CGPoint(x: frame.height/2, y: frame.width/2)
        mainCircle.glowWidth = 1.0
        mainCircle.fillColor = .clear
        mainCircle.name = "mainCircle"
    }
    
    func fadeInMainCircle() {
        self.addChild(mainCircle)
//        let wait = SKAction.wait(forDuration: 2)
//        let fadeIn = SKAction.fadeIn(withDuration: 3)
        let animation = SKAction.sequence([
            .wait(forDuration: 2),
            .fadeIn(withDuration: 3)
        ])
        mainCircle.run(animation)
    }
    
    func setupOtherCircle() {
        otherCircle.position = CGPoint(x: (mainCircle.position.x)-900, y: (mainCircle.position.y)-900)
        otherCircle.glowWidth = 1.0
        otherCircle.fillColor = .clear
        otherCircle.name = "otherCircle"
    }
    
    func addOtherCircle() {
        
        self.addChild(otherCircle)

        let animation = SKAction.sequence([
            .move(to: CGPoint(x: (mainCircle.position.x)-30, y: (mainCircle.position.y)-30), duration: 2),
            .wait(forDuration: 3),
            .move(to: CGPoint(x: (mainCircle.position.x)+210, y: (mainCircle.position.y)+120), duration: 2)
        ])
        animation.timingMode = SKActionTimingMode.easeInEaseOut
        otherCircle.run(animation)
    }
    
    // Texts
//    func setupChapterAText() {
//        chapterAText = SKLabelNode(fontNamed: "New York")
//        chapterAText.text = "From the very first days of our lives, we are surrounded by people who care for us"
//
//    }
    
    
    // Music
    func setupMusic() {
        audioManager.playMusicA(forResource: "ChapA-1")
        audioManager.playMusicB(forResource: "ChapA-2")
    }
    
    func fadeInMainCircleMusic() {
        audioManager.fadeIn(player: audioManager.playerA!)
    }
    
    func fadeInOtherCircleMusic() {
        audioManager.fadeIn(player: audioManager.playerB!)
    }
    
}

extension SKNode {
    func distance(to other: SKNode) -> CGFloat {
        sqrt(pow(position.x - other.position.x ,2) + pow(position.y - other.position.y, 2))
    }
}

enum PlaygroundStatus {
    case intro
    case introTransition
    case chapterA1
    case chapterA2
}
