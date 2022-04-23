//
//  ContentView.swift
//  Ripples
//
//  Created by Bittenco on 22/04/22.
//

import SwiftUI
import SpriteKit
import AVFoundation

struct ContentView: View {
        
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 1000, height: 1000)
        scene.scaleMode = .aspectFill
        return scene
    }
    
    var body: some View {
            SpriteView(scene: scene)
            .scaledToFill()
        
        .background(Color.pink)
    }
    
}
