//
//  WhackSlot.swift
//  Project14
//
//  Created by othman shahrouri on 9/11/21.
//

//SKNode is base class doesn't draw images like sprites or hold text like labels; it just sits in our scene at a position, holding other nodes as children.

import SpriteKit
import UIKit

class WhackSlot: SKNode {
    //if you created a custom initializer you get roped into creating others because of Swift's required init rules
    //Since we don't have any non-optional properties swift will use parent init()
    func configure (at position: CGPoint) {
        self.position = position
        
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
    }
     

}
