//
//  GameScene.swift
//  Project14
//
//  Created by othman shahrouri on 9/11/21.
//

//Notes:

//game scene is = 1024x768 which is perfect for most ipads,except ipad pro 11 is special
// we can ask SpriteKit to gently stretch our scene so that it fits the device dimensions no matter what aspect ratio

//To do that in GameViewController change scene.scaleMode to = .fill
//-----------------------------------------------------------------------------------------

//We want each hole to do as much work itself as possible, so rather than clutter our game scene with code we're going to create a subclass of SKNode that will encapsulate all hole related functionality

//-----------------------------------------------------------------------------------------

//SKCropNode is a special kind of SKNode subclass that uses an image as a cropping mask: anything in the colored part will be visible, anything in the transparent part will be invisible
//By default, nodes don't crop..we need crop node to hide penguins

// have a crop mask shaped like the hole that makes the penguin invisible when it moves outside the mask.

import SpriteKit


class GameScene: SKScene {
    var gameScore: SKLabelNode!
    var slots = [WhackSlot]()
    
    var score = 0 {
        didSet{
            gameScore.text = "Score: \(score)"
        }
    }
    
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        
        //Placing slots 5 4 5 4
        for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 410)) }
        for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 320)) }
        for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 230)) }
        for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 140)) }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func createSlot (at position: CGPoint) {
        let slot = WhackSlot()
        slot.configure(at: position)
        //adds the slot to our scene
        addChild(slot)
        slots.append(slot)
    }
}
