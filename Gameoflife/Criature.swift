//
//  Criature.swift
//  Gameoflife
//
//  Created by Irina Korneeva on 18/07/16.
//  Copyright © 2016 Irina. All rights reserved.
//

import UIKit
import SpriteKit

class Criature: SKSpriteNode {
    var isAlive: Bool = false {
        didSet{
            hidden = !isAlive
        }
    }
    
    var neighborCount = 0
    init() {
        let texture = SKTexture(imageNamed: "bubble")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        zPosition = 1
        anchorPoint = CGPoint(x: 0, y: 0)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
