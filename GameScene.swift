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
        
    var status: PlaygroundStatus = .intro
    
    private var currentNode: SKNode?
    
    var audioManager = AudioManager()
    
    // First chapter
    let mainCircle = SKShapeNode(circleOfRadius: 10)
    let otherCircle = SKShapeNode(circleOfRadius: 10)
    
    let introImage = SKSpriteNode(imageNamed: "Consolidated-Clear")
        
    override func didMove(to view: SKView) {
        
        setupIntro()
        
    }
    
    func setupIntro() {
        introImage.size = CGSize(width: 800, height: 800)
        introImage.position = CGPoint(x: frame.height/2, y: frame.width/2)
        addChild(introImage)
        
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
    
    override func update(_ currentTime: TimeInterval) {
        updateVolume()
    }
    
    func updateVolume() {
        let distance = otherCircle.distance(to: mainCircle)
        let maxDistance = sqrt(pow(frame.height / 2, 2) + pow(frame.width / 2, 2))
        let currentVolume = 1 - (distance / maxDistance)
        
//        audioManager.updateVolume(volume: Float(currentVolume), player: audioManager.playerB!)
        
//        print(audioManager.playerB?.volume)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        switch status {
        case .intro:
            introTouched()
        case .introTransition:
            fadeOutIntro()
        case .chapterOne:
            chapterOneInit()
        }
        
        func introTouched() {
            status = .chapterOne
            fadeOutIntro()
            
        }
        
        func chapterOneInit() {
//            playAudioNodeTest()
            
    //      First chapter
            setupMainCircle()
//            audioManager.playerB!.volume = 0
        }
        
        setupOtherCircle()
        
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
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    
    // First chapter
    func setupMainCircle() {
        audioManager.playMusicA(forResource: "csharp")
        audioManager.playMusicB(forResource: "accents")
        
        mainCircle.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        mainCircle.glowWidth = 1.0
        mainCircle.fillColor = .clear
        mainCircle.name = "mainCircle"
        self.addChild(mainCircle)
    }
    
    func setupOtherCircle() {
        
//        setupOtherCircleMusic()
        
        let animation = SKAction.sequence([
            .move(to: CGPoint(x: (mainCircle.position.x)-30, y: (mainCircle.position.y)-30), duration: 2),
            .wait(forDuration: 3),
            .move(to: CGPoint(x: (mainCircle.position.x)+210, y: (mainCircle.position.y)+120), duration: 2)
        ])
        
        animation.timingMode = SKActionTimingMode.easeInEaseOut
        
        otherCircle.position = CGPoint(x: -90, y: -90)
        otherCircle.glowWidth = 1.0
        otherCircle.fillColor = .clear
        otherCircle.name = "otherCircle"
        self.addChild(otherCircle)
        
        otherCircle.run(animation)
    }
    
//    func setupOtherCircleMusic() {
//        audioManager.fadeIn(player: audioManager.playerB!)
//    }
    
}

extension SKNode {
    func distance(to other: SKNode) -> CGFloat {
        sqrt(pow(position.x - other.position.x ,2) + pow(position.y - other.position.y, 2))
    }
}

enum PlaygroundStatus {
    case intro
    case introTransition
    case chapterOne
}
