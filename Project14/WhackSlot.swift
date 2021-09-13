//
//  WhackSlot.swift
//  Project14
//
//  Created by othman shahrouri on 9/11/21.
//

//SKNode is base class doesn't draw images like sprites or hold text like labels; it just sits in our scene at a position, holding other nodes as children.
// crop node only crops nodes that are inside it

//-----------------------------------------------------------------------------------------

//SKTexture, which is to SKSpriteNode sort of what UIImage is to UIImageView – it holds image data, but isn't responsible for showing it

import SpriteKit
import UIKit

class WhackSlot: SKNode {
    var charNode: SKSpriteNode!
    
    var isVisible = false
    var isHit = false
    
    //if you created a custom initializer you get roped into creating others because of Swift's required init rules
    //Since we don't have any non-optional properties swift will use parent init()
    func configure (at position: CGPoint) {
        self.position = position
        
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        // create a new SKCropNode and position it slightly higher than the slot itself
        let cropNode = SKCropNode()
        //number 15 isn't random – it's the exact number of points required to make the crop node line up perfectly with the hole graphics
        cropNode.position = CGPoint(x: 0, y: 15)
        //stops it from appearing behind the whole
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        // placed at -90, which is way below the hole
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        //add charNode to cropNode bec crop node only crops nodes that are inside it
        cropNode.addChild(charNode)
        //add cropNode to slot node
        addChild(cropNode)
    }
    
    func show(hideTime: Double) {
        //already shown
        if isVisible { return }
        //Move charNode up
        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        isVisible = true
        isHit = false
        
        //Decide whether penguin is good or evil
        
        if Int.random(in: 0...2) == 0 {//1/3 will be good pen.
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        }
        else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        //3.5 by trial and error
        DispatchQueue.main.asyncAfter(deadline: .now() + hideTime * 3.5){ [weak self] in
            self?.hide()
            
        }
        
    }
     
    func hide() {
        //already hidden
        if !isVisible { return }
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        isVisible = false
        
    }

}
