//
//  Grid.swift
//  Gameoflife
//
//  Created by Irina Korneeva on 18/07/16.
//  Copyright © 2016 Irina. All rights reserved.
//

import UIKit
import SpriteKit

class Grid: SKSpriteNode {
    let rows = 8
    let columns = 10
    
    var cellWidth = 0
    var cellHeight = 0
    
    var population = 0
    var generation = 0
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent? ) {
        for touch in touches {
            let location = touch.locationInNode(self)
            let xGrid = Int(location.x)/cellWidth
            let yGrid = Int(location.y)/cellHeight
            let creature = grid[xGrid][yGrid]
            creature.isAlive = !creature.isAlive
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        userInteractionEnabled = true
        
        cellWidth = Int(size.width) / columns
        cellHeight = Int(size.height) / rows
        populateGrid()
    }
    var grid = [[Criature]]()
    
    func populateGrid() {
        
        for xGrid in 0..<columns {
            grid.append([])
            for yGrid in 0..<rows {
                addCreatureAtGrid(xGrid, y: yGrid)
            }
        }
    }
    func addCreatureAtGrid(x: Int, y: Int) {
        let creature = Criature()
        
        let position = CGPoint(x: x * cellWidth + 1, y: y * cellHeight + 1)
        creature.position = position
        creature.isAlive = false
        addChild(creature)
        grid[x].append(creature)
        
        
    }
    func countNeighbors() {
        for xGrid in 0..<columns {
            for yGrid in 0..<rows {
                let creature = grid[xGrid][yGrid]
                creature.neighborCount = 0
                for innerGridX in (xGrid - 1) ... (xGrid + 1) {
                    if(innerGridX < 0 || innerGridX >= columns) {continue}
                    for innerGridY in (yGrid - 1) ... (yGrid + 1) {
                        
                        if(innerGridY < 0 || innerGridY >= rows) {continue}
                        if(innerGridY == yGrid && innerGridX == xGrid) {continue}
                        
                        let other: Criature = grid[innerGridX][innerGridY]
                        if other.isAlive {
                            creature.neighborCount += 1
                        }
                        
                    }
                }
            }
        }
        
    }
    func updateCreatures() {
        population = 0
        for xGrid in 0..<columns {
            for yGrid in 0..<rows {
                let cur = grid[xGrid][yGrid]
                switch cur.neighborCount{
                case 3:
                    cur.isAlive = true
                    break
                case 0...1, 4...8:
                    cur.isAlive = false
                    break
                default:
                    break
                }
                if cur.isAlive {population += 1}
            }
        }
        
    }
    func evolve() {
        /* Updated the grid to the next state in the game of life */
        
        /* Update all creature neighbor counts */
        countNeighbors()
        
        /* Calculate all creatures alive or dead */
        updateCreatures()
        
        /* Increment generation counter */
        generation += 1
    }

}
