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
        
     
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func createSlot (at position: CGPoint) {
        let slot = WhackSlot()
        slot.configure(at: position)
        addChild(slot)
        slots.append(slot)
    }
}
