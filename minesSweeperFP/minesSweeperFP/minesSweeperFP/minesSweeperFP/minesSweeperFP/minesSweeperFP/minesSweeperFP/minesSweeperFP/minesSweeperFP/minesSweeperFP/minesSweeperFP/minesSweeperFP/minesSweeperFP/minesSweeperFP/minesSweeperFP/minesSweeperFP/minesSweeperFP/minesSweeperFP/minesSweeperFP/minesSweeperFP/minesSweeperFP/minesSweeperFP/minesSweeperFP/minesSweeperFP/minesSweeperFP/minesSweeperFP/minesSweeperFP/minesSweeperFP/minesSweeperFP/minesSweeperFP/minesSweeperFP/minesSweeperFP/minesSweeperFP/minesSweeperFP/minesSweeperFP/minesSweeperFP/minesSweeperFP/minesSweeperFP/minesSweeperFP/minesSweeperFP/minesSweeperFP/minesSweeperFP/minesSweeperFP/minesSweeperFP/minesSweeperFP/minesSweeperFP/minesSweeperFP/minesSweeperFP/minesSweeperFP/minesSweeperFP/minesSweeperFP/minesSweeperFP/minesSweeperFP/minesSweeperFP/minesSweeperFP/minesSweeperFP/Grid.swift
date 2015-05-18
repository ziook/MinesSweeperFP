//
//  Grid.swift
//  minesSweeperFP
//
//  Created by Victor ALIBERT on 14/05/2015.
//  Copyright (c) 2015 Victor ALIBERT. All rights reserved.
//

import Foundation

class Grid {
    
    let size:Int
    var boxes:[[Box]] = []
    
    init(size:Int) {
        self.size = size
        
        for row in 0 ..< size {
            var boxRow:[Box] = []
            for col in 0 ..< size {
                let box = Box(row: row, col: col)
                boxRow.append(box)
            }
            boxes.append(boxRow)
        }
    }
    
    func resetGrid() {
        // assign mines
        for row in 0 ..< size {
            for col in 0 ..< size {
                boxes[row][col].isRevealed = false
                self.calculateIsMineLocationForBox(boxes[row][col])
            }
        }
        
        // count number of neighboring box
        for row in 0 ..< size {
            for col in 0 ..< size {
                self.calculateNumNeighborMinesForBox(boxes[row][col])
            }
        }
    }
    
    func calculateIsMineLocationForBox(box: Box) {
        // 1-in-10 chance that there is a Mine
        box.isMine = ((arc4random()%10) == 0)
    }
    
    func calculateNumNeighborMinesForBox(box : Box) {
        // first get a list of adjacent squares
        let neighbors = getNeighboringBoxes(box)
        var numNeighboringMines = 0
        
        // for each neighbor with a mine, add 1 to this square's count
        for neighborSquare in neighbors {
            if neighborSquare.isMine {
                numNeighboringMines++
            }
        }
        box.neighboringMines = numNeighboringMines
    }
    
    func getNeighboringBoxes(box : Box) -> [Box] {
        var neighbors:[Box] = []
        
        // all the direction for neighboring boxes
        let adjacentOffsets =
        [(-1,-1),(0,-1),(1,-1),
            (-1,0),(1,0),
            (-1,1),(0,1),(1,1)]
        
        for (rowOffset,colOffset) in adjacentOffsets {
            // getTileAtLocation might return a Square, or it might return nil, so use the optional datatype "?"
            let optionalNeighbor:Box? = getTileAtLocation(box.row+rowOffset, col: box.col+colOffset)
            // only evaluates true if the optional tile isn't nil
            if let neighbor = optionalNeighbor {
                neighbors.append(neighbor)
            }
        }
        return neighbors
    }
    
    func getTileAtLocation(row : Int, col : Int) -> Box? {
        if row >= 0 && row < self.size && col >= 0 && col < self.size {
            return boxes[row][col]
        } else {
            return nil
        }
    }
    
    
}