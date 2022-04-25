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
    let secondCircle = SKShapeNode(circleOfRadius: 10)
    
    let circleA = SKShapeNode(circleOfRadius: 10)
    let circleB = SKShapeNode(circleOfRadius: 10)
    let circleC = SKShapeNode(circleOfRadius: 10)
    let circleD = SKShapeNode(circleOfRadius: 10)
    let circleE = SKShapeNode(circleOfRadius: 10)
    let circleF = SKShapeNode(circleOfRadius: 10)
    
    let circleG = SKShapeNode(circleOfRadius: 10)
    let circleH = SKShapeNode(circleOfRadius: 10)
    let circleI = SKShapeNode(circleOfRadius: 10)
    let circleJ = SKShapeNode(circleOfRadius: 10)
    let circleK = SKShapeNode(circleOfRadius: 10)
    let circleL = SKShapeNode(circleOfRadius: 10)



    let firstPhrase = SKSpriteNode(imageNamed: "text-a")
    let secondPhrase = SKSpriteNode(imageNamed: "text-d")
    
    let pressText = SKSpriteNode(imageNamed: "press")
    
    var canTouch: Bool = true
    
    
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
    
//    let sequence = SKAction.sequence([
//        .wait(forDuration: 2)
//        .run {
//            self.setupMusic()
//        }
//    ])
    
//    let runFunc = SKAction.run {
//        function()
//    }
    
    func setupIntroQuote() {
        introQuoteImage.size = CGSize(width: frame.width/1.8, height: frame.height/1.8)
        introQuoteImage.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        introQuoteImage.alpha = 0
        addChild(introQuoteImage)
    }
    
    func setupPressText() {
        pressText.size = CGSize(width: frame.width/5, height: frame.height/5)
        pressText.position = CGPoint(x: self.frame.midX, y: (self.frame.midY)-400)
        pressText.alpha = 0
        addChild(pressText)
    }
    
    func setupFirstPhrase() {
        firstPhrase.size = CGSize(width: frame.width/2.2, height: frame.height/2.2)
        firstPhrase.position = CGPoint(x: self.frame.midX, y: self.frame.midY-300)
        firstPhrase.alpha = 0
        addChild(firstPhrase)
    }
    
    func setupSecondPhrase() {
        secondPhrase.size = CGSize(width: frame.width/2.2, height: frame.height/2.2)
        secondPhrase.position = CGPoint(x: self.frame.midX, y: self.frame.midY-300)
        secondPhrase.alpha = 0
        addChild(secondPhrase)
    }
    
    // >>>>>>>
    // >>>>>>> FADE-IN AND FADE-OUTS
    // >>>>>>>
    
    func fadeInIntroQuote() {
        let fadeIn = SKAction.fadeIn(withDuration: 3)
        let touchFunc = SKAction.run {
            self.canTouch = true
        }
        let sequence = SKAction.sequence([fadeIn, touchFunc])
        fadeIn.timingMode = SKActionTimingMode.easeIn
        introQuoteImage.run(sequence)
    }
    
    func fadeInImage(spritenode: SKSpriteNode, duration: TimeInterval) {
        let fadeIn = SKAction.fadeIn(withDuration: duration)
        fadeIn.timingMode = SKActionTimingMode.easeInEaseOut
        spritenode.run(fadeIn)
    }
    
    func fadeOutImage(spritenode: SKSpriteNode, duration: TimeInterval) {
        let fadeOut = SKAction.fadeOut(withDuration: duration)
        fadeOut.timingMode = SKActionTimingMode.easeInEaseOut
        spritenode.run(fadeOut)
    }
        
    func fadeOutIntroQuote() {
        let fadeOut = SKAction.fadeOut(withDuration: 2)
        fadeOut.timingMode = SKActionTimingMode.easeOut
        introQuoteImage.run(fadeOut)
    }
    
    func showPressText(spritenode: SKSpriteNode, delay: TimeInterval, fadeIn: TimeInterval) {
        let wait = SKAction.wait(forDuration: delay)
        let fadeIn = SKAction.fadeIn(withDuration: fadeIn)
        fadeIn.timingMode = SKActionTimingMode.easeInEaseOut
        let sequence = SKAction.sequence([wait, fadeIn])
        spritenode.run(sequence)
    }
    
    func fadeInFirstPhrase() {
        let wait = SKAction.wait(forDuration: 2)
        let fadeIn = SKAction.fadeIn(withDuration: 3)
        let wait2 = SKAction.wait(forDuration: 6)
        let transform1 = SKAction.setTexture(SKTexture(imageNamed: "text-c"))
        let transform2 = SKAction.setTexture(SKTexture(imageNamed: "text-b"))
        
        fadeIn.timingMode = SKActionTimingMode.easeIn
        transform1.timingMode = SKActionTimingMode.easeInEaseOut
        transform2.timingMode = SKActionTimingMode.easeInEaseOut
        
        let sequence = SKAction.sequence([wait, fadeIn, wait2, transform1, wait2, transform2])
        firstPhrase.run(sequence)
    }
    
    func fadeInSecondPhrase() {
        let wait = SKAction.wait(forDuration: 10)
        let fadeIn = SKAction.fadeIn(withDuration: 3)
        let wait2 = SKAction.wait(forDuration: 4)
        let transform = SKAction.setTexture(SKTexture(imageNamed: "text-e"))
        let wait3 = SKAction.wait(forDuration: 4)
        let transform2 = SKAction.setTexture(SKTexture(imageNamed: "text-f"))
        
        fadeIn.timingMode = SKActionTimingMode.easeIn
        transform.timingMode = SKActionTimingMode.easeInEaseOut
        
        let sequence = SKAction.sequence([wait, fadeIn, wait2, transform, wait3, transform2])
        secondPhrase.run(sequence)
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
    
    
    // >>>>>>>
    // >>>>>>> UPDATE
    // >>>>>>>
    
    override func update(_ currentTime: TimeInterval) {
        updateFirstCircleVolume()
        updateSecondCircleVolume()
    }
    
    // >>>>>>>
    // >>>>>>> SOUND
    // >>>>>>>
    
    // Controlling volume with distance
    func updateFirstCircleVolume() {
        let distance = firstCircle.distance(to: mainCircle)
        let maxDistance = sqrt(pow(frame.height / 2, 2) + pow(frame.width / 2, 2))
        let currentVolume = 1 - (distance / maxDistance)
        print("first circle: \(currentVolume)")
        
        modulateAudio(input: currentVolume, player: audioManager.playerB!)
    }
    
    func updateSecondCircleVolume() {
        let distance = secondCircle.distance(to: mainCircle)
        let maxDistance = sqrt(pow(frame.height / 2, 2) + pow(frame.width / 2, 2))
        let currentVolume = 1 - (distance / maxDistance)
        print("second circle: \(currentVolume)")
        
        modulateAudio(input: currentVolume, player: audioManager.playerC!)
    }
    
    func modulateAudio(input: CGFloat, player: AVAudioPlayer) {
        if input < 0 {
            audioManager.updateVolume(volume: 0, player: player)
        }
        ; if input >= 0.3 {
            audioManager.updateVolume(volume: 0.1, player: player)
        }
        ; if input >= 0.5 {
            audioManager.updateVolume(volume: 0.2, player: player)
        }
        ; if input >= 0.7 {
            audioManager.updateVolume(volume: 0.3, player: player)
        }
        ; if input >= 0.8 {
            audioManager.updateVolume(volume: 0.4, player: player)
        }
        ; if input >= 0.9 {
            audioManager.updateVolume(volume: 0.5, player: player)
        }
    }
    
    func setupMusic() {
        audioManager.playMusicA(forResource: "ChapA-1")
        audioManager.playMusicB(forResource: "ChapA-2")
        audioManager.playMusicC(forResource: "ChapA-3")
    }
    
    func fadeInMainCircleMusic() {
        audioManager.fadeIn(player: audioManager.playerA!)
    }
    
    func fadeInFirstCircleMusic() {
        audioManager.fadeInLong(player: audioManager.playerB!)
    }
    
    func fadeInSecondCircleMusic() {
        audioManager.fadeInLonger(player: audioManager.playerC!)
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
    
    
    // >>>>>>>
    // >>>>>>> CIRCLES
    // >>>>>>>
    
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
        firstCircle.position = CGPoint(x: (mainCircle.position.x)-1200, y: (mainCircle.position.y)-1200)
        firstCircle.glowWidth = 1.0
        firstCircle.fillColor = .clear
        firstCircle.name = "firstCircle"
    }
    
    func runFirstCircle() {
        
        self.addChild(firstCircle)
        
        let wait1 = SKAction.wait(forDuration: 2.5)
        let approach = SKAction.move(to: CGPoint(x: (mainCircle.position.x)-30, y: (mainCircle.position.y)-30), duration: 5)
        let wait2 = SKAction.wait(forDuration: 3)
        let stepBack = SKAction.move(to: CGPoint(x: (mainCircle.position.x)+210, y: (mainCircle.position.y)-30), duration: 4)
        
        approach.timingMode = SKActionTimingMode.easeInEaseOut
        stepBack.timingMode = SKActionTimingMode.easeInEaseOut
        
        let sequence = SKAction.sequence([wait1, approach, wait2, stepBack])
        firstCircle.run(sequence)
        
    }
    
    func setupSecondCircle() {
        secondCircle.position = CGPoint(x: (mainCircle.position.x)+1200, y: (mainCircle.position.y)+1200)
        secondCircle.glowWidth = 1.0
        secondCircle.fillColor = .clear
        secondCircle.name = "secondCircle"
    }
    
    func runSecondCircle() {
        
        self.addChild(secondCircle)
        
        let wait1 = SKAction.wait(forDuration: 2)
        let approach = SKAction.move(to: CGPoint(x: (mainCircle.position.x)+30, y: (mainCircle.position.y)+30), duration: 5)
        let wait2 = SKAction.wait(forDuration: 3)
        let moveAside = SKAction.move(by: CGVector(dx: -10, dy: 10), duration: 3)
        
        approach.timingMode = SKActionTimingMode.easeInEaseOut
        moveAside.timingMode = SKActionTimingMode.easeInEaseOut
        
        let sequence = SKAction.sequence([wait1, approach, wait2, moveAside])
        secondCircle.run(sequence)
    }
    
    func setupSideCircles(name: SKShapeNode, posX: CGFloat, posY: CGFloat) {
        name.position = CGPoint(x: posX, y: posY)
        name.glowWidth = 1.0
        name.fillColor = .clear
        addChild(name)
    }
    
    func addSideCircles() {
        setupSideCircles(name: circleA, posX: -1400, posY: -800)
        setupSideCircles(name: circleB, posX: -1400, posY: -600)
        setupSideCircles(name: circleC, posX: -1400, posY: -400)
        setupSideCircles(name: circleD, posX: +1400, posY: +800)
        setupSideCircles(name: circleE, posX: +1400, posY: +600)
        setupSideCircles(name: circleF, posX: +1400, posY: +400)
    }
    
    func setupSideCirclesMovement(name: SKShapeNode, posX: CGFloat, posY: CGFloat, moveX: CGFloat, moveY: CGFloat) {
        let wait = SKAction.wait(forDuration: 14)
        let approach = SKAction.move(to: CGPoint(x: (mainCircle.position.x)+posX, y: (mainCircle.position.y)+posY), duration: 5)
        let wait2 = SKAction.wait(forDuration: 1)
        let stepBack = SKAction.move(by: CGVector(dx: moveX, dy: moveY), duration: 2)
        
        approach.timingMode = SKActionTimingMode.easeOut
        stepBack.timingMode = SKActionTimingMode.easeInEaseOut
        
        let sequence = SKAction.sequence([wait, approach, wait2, stepBack])
        
        name.run(sequence)
    }
    
    func runSideCircles() {
        setupSideCirclesMovement(name: circleA, posX: -135, posY: -70, moveX: -20, moveY: -20)
        setupSideCirclesMovement(name: circleB, posX: -130, posY: -100, moveX: -20, moveY: -20)
        setupSideCirclesMovement(name: circleC, posX: -110, posY: -120, moveX: -20, moveY: -20)
        setupSideCirclesMovement(name: circleD, posX: +135, posY: +70, moveX: 20, moveY: 20)
        setupSideCirclesMovement(name: circleE, posX: +130, posY: +100, moveX: 20, moveY: 20)
        setupSideCirclesMovement(name: circleF, posX: +110, posY: +120, moveX: 20, moveY: 20)
    }
    
    func setupSideCirclesRemoval(name: SKShapeNode, posX: CGFloat, posY: CGFloat) {
        let moveOut = SKAction.move(by: CGVector(dx: posX, dy: posY), duration: 3)
        moveOut.timingMode = SKActionTimingMode.easeInEaseOut
        name.run(moveOut)
    }
    
    func removeSideCircles() {
        setupSideCirclesRemoval(name: circleA, posX: -300, posY: -300)
        setupSideCirclesRemoval(name: circleB, posX: -300, posY: -300)
        setupSideCirclesRemoval(name: circleC, posX: -300, posY: -300)
        setupSideCirclesRemoval(name: circleD, posX: +300, posY: +300)
        setupSideCirclesRemoval(name: circleE, posX: +300, posY: +300)
        setupSideCirclesRemoval(name: circleF, posX: +300, posY: +300)
    }
    
    func removeMainCircles() {
        setupSideCirclesRemoval(name: firstCircle, posX: mainCircle.position.x-1200, posY: mainCircle.position.y-1200)
        setupSideCirclesRemoval(name: secondCircle, posX: mainCircle.position.x+1200, posY: mainCircle.position.y+1200)
    }
    
    // >>>>>>>
    // >>>>>>> CHAPTER TWO
    // >>>>>>>
    
    func setupChapBCircles(name: SKShapeNode, posX: CGFloat, posY: CGFloat) {
        name.position = CGPoint(x: posX, y: posY)
        name.glowWidth = 1.0
        name.fillColor = .clear
        addChild(name)
    }
    
    func addChapBCircles() {
        setupChapBCircles(name: circleG, posX: 1400, posY: 800)
        setupChapBCircles(name: circleH, posX: 1400, posY: 600)
        setupChapBCircles(name: circleI, posX: 1400, posY: 500)
        setupChapBCircles(name: circleJ, posX: -1400, posY: -800)
        setupChapBCircles(name: circleK, posX: -1400, posY: -600)
        setupChapBCircles(name: circleL, posX: -1400, posY: -500)
    }
    
    func setupMoveCirclesIn(name: SKShapeNode, posX: CGFloat, posY: CGFloat, moveX: CGFloat, moveY: CGFloat) {
        let approach = SKAction.move(to: CGPoint(x: (mainCircle.position.x)+posX, y: (mainCircle.position.y)+posY), duration: 4)
        let wait2 = SKAction.wait(forDuration: 1)
        let stepBack = SKAction.move(by: CGVector(dx: moveX, dy: moveY), duration: 2)
        
        approach.timingMode = SKActionTimingMode.easeOut
        stepBack.timingMode = SKActionTimingMode.easeInEaseOut
        
        let sequence = SKAction.sequence([approach, wait2, stepBack])
        
        name.run(sequence)
    }
    
    func runChapBCircles() {
        setupMoveCirclesIn(name: circleG, posX: -135, posY: -100, moveX: 50, moveY: 40)
        setupMoveCirclesIn(name: circleH, posX: 150, posY: 100, moveX: -20, moveY: -10)
        setupMoveCirclesIn(name: circleI, posX: -90, posY: -120, moveX: -20, moveY: -20)
        setupMoveCirclesIn(name: circleJ, posX: +135, posY: +70, moveX: 10, moveY: 30)
        setupMoveCirclesIn(name: circleK, posX: +200, posY: +100, moveX: 40, moveY: 50)
        setupMoveCirclesIn(name: circleL, posX: -90, posY: +120, moveX: 10, moveY: 30)
    }
    
    func setupSideCirclesChapBRemoval(name: SKShapeNode, posX: CGFloat, posY: CGFloat) {
        let wait = SKAction.wait(forDuration: 10)
        let moveOut = SKAction.move(by: CGVector(dx: posX, dy: posY), duration: 3)
        moveOut.timingMode = SKActionTimingMode.easeInEaseOut
        
        let sequence = SKAction.sequence([wait, moveOut])
        name.run(sequence)
    }
    
    func chapBCirclesLeave() {
        setupSideCirclesChapBRemoval(name: circleH, posX: -900, posY: -900)
        setupSideCirclesChapBRemoval(name: circleI, posX: -900, posY: -900)
        setupSideCirclesChapBRemoval(name: circleJ, posX: -900, posY: -900)
        setupSideCirclesChapBRemoval(name: circleK, posX: 900, posY: 900)
        setupSideCirclesChapBRemoval(name: circleL, posX: 900, posY: 900)
    }
    
    func remainingCircleApproaches() {
        let wait = SKAction.wait(forDuration: 10)
        let moveIn = SKAction.move(by: CGVector(dx: 40, dy: 30), duration: 2)
        
        moveIn.timingMode = SKActionTimingMode.easeInEaseOut
        let sequence = SKAction.sequence([wait, moveIn])
        
        circleG.run(sequence)
    }
    
    func remainingCircleLeaves() {
        let wait = SKAction.wait(forDuration: 16)
        let moveOut = SKAction.move(by: CGVector(dx: -800, dy: -800), duration: 4)
        
        moveOut.timingMode = SKActionTimingMode.easeInEaseOut
        let sequence = SKAction.sequence([wait, moveOut])
        
        circleG.run(sequence)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if canTouch == false {
            return
        }
        
        switch status {
        case .intro:
            status = .chapterA
            fadeOutIntro()
            setupIntroQuote()
            fadeInIntroQuote()
            setupPressText()
            fadeInImage(spritenode: pressText, duration: 4)
            fadeInMainCircleMusic()
            
        case .chapterA:
            status = .chapterB
            fadeOutIntroQuote()
            fadeOutImage(spritenode: pressText, duration: 2)
            fadeInMainCircle()
            
            // from the very first days of our lives,
            // we are surrounded by people that care for us
            setupFirstPhrase()
            fadeInFirstPhrase()
            
            runFirstCircle()
            updateFirstCircleVolume()
            
            setupSecondCircle()
            runSecondCircle()
            updateSecondCircleVolume()
            
            // Include other circles
            addSideCircles()
            runSideCircles()
            
            showPressText(spritenode: pressText, delay: 20, fadeIn: 4)
            
            // Include other circles sounds (?)
            
            // along with them, we learn and grow
                        
        case .chapterB:
            status = .chapterC
            setupSecondPhrase()
            fadeOutImage(spritenode: pressText, duration: 2)
            // Move out circles that stayed from previous
            removeSideCircles()
            removeMainCircles()
            
            fadeOutImage(spritenode: firstPhrase, duration: 2)
            
            /// keep sound slightly changed
            
            addChapBCircles()
            runChapBCircles()
            chapBCirclesLeave()
            
            remainingCircleApproaches()
            
            fadeInSecondPhrase()
            
            remainingCircleLeaves()
            
            // bring main in
            
            /// Fade their sounds in (with different tones)
                        
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
            
            // now, more aware
            
            // Main circle changes beep melody
            // Other circle comes back closer
            
            // that other people
            // carry their marks too
            
            // touch prompt
            
            
        case .chapterE:
            print("chapter E clicked")
            
            // bring in other circles
            // fade them out
            
            // like droplets in a pond
            // their love created ripples
            // that are still resonating
            
            // bring other circles opacity a tiny bit up
            
            // with us today
            
            // touch prompt
            
            
        case .ending:
            print("ending clicked")
            
            // fade outs from before
            // keep a sound playing
            // thank you
            // end of the experience
            
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
    case ending
}
