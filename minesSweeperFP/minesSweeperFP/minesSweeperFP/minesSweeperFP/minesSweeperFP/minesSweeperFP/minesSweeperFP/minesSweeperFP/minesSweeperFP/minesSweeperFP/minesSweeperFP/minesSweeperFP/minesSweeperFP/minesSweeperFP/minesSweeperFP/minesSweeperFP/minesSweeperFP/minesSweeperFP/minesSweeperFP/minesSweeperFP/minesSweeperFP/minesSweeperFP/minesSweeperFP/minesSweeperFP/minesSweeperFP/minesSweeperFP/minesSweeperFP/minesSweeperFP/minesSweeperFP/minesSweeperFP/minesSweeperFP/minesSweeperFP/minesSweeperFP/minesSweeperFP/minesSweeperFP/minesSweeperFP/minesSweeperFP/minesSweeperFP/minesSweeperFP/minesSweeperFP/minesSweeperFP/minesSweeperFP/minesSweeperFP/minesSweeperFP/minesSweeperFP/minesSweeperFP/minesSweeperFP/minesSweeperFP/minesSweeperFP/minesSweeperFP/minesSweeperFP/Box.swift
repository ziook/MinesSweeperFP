//
//  Round.swift
//  minesSweeperFP
//
//  Created by Victor ALIBERT on 14/05/2015.
//  Copyright (c) 2015 Victor ALIBERT. All rights reserved.
//

import Foundation

class Box {
    
    // position in the grid
    let row:Int
    let col:Int
    
    // default prop
    var neighboringMines = 0
    var isMine = false
    var isRevealed = false
    
    init(row:Int, col:Int) {
        //store the row and column of the square in the grid
        self.row = row
        self.col = col
    }
}