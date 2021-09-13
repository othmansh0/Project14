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
//--------------------------------------------------------------------------------------

//asyncAfter() is used to schedule a closure to execute after the time has been reached.

import SpriteKit


class GameScene: SKScene {
    var gameScore: SKLabelNode!
    var slots = [WhackSlot]()
    
    var popupTime = 0.85
    
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){ [weak self] in
            self?.createEnemy()
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //find any touch
        guard let touch = touches.first else { return }
        //find where it was tapped
        let location = touch.location(in: self)
        //get a node array of all nodes at that point
        let tappedNodes = nodes(at: location)
        
        for node in tappedNodes {
            // node is spriteNode inside cropNode inside whackSlot which is the one that has ishit and is visible
            //We need to type cast
            guard let whackSlot = node.parent?.parent as? WhackSlot else { continue }
            
            if !whackSlot.isVisible { continue }
            if whackSlot.isHit { continue }
            whackSlot.hit()
            
            if node.name == "charFriend" {

                whackSlot.hide()
                score -= 5
                
                run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion: false))
                
                
            } else  if node.name == "charEnemy" {
                //they should have whacked this one
                //make the size smaller when hit
                whackSlot.charNode.xScale = 0.85
                whackSlot.charNode.yScale = 0.85
                
                score += 1
                run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
            }
        }
        
    }
    
    func createSlot (at position: CGPoint) {
        let slot = WhackSlot()
        slot.configure(at: position)
        //adds the slot to our scene
        addChild(slot)
        slots.append(slot)
    }
    
    func createEnemy() {
        //decreasing it slowly by trial and error to find 0.991
        popupTime *= 0.991
        
        //Pick a slot to show
        slots.shuffle()
        slots[0].show(hideTime: popupTime)
        
        //sometimes show more than one slot
        if Int.random(in: 0...12) > 4 { slots[1].show(hideTime: popupTime) }
        if Int.random(in: 0...12) > 8 { slots[2].show(hideTime: popupTime) }
        if Int.random(in: 0...12) > 10 { slots[3].show(hideTime: popupTime) }
        if Int.random(in: 0...12) > 11 { slots[4].show(hideTime: popupTime) }
        
        //let createEnemy call itself after random period of time

        let minDelay = popupTime / 2.0
        let maxDelay = popupTime * 2
        let delay = Double.random(in: minDelay...maxDelay)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay){ [weak self] in
            self?.createEnemy()
        }
    }
    
}
