
//
//  Button.swift
//  minesSweeperFP
//
//  Created by Victor ALIBERT on 14/05/2015.
//  Copyright (c) 2015 Victor ALIBERT. All rights reserved.
//

import UIKit

class Button : UIButton {
    let boxSize:CGFloat
    var box:Box
    
    init(box:Box, boxSize:CGFloat) {
        self.box = box
        self.boxSize = boxSize
        
        let x = CGFloat(self.box.col) * boxSize
        let y = CGFloat(self.box.row) * boxSize
        let boxFrame = CGRectMake(x, y, boxSize, boxSize)
        
        super.init(frame: boxFrame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getLabelText() -> String {
        // check the isMine and NeighboringMines to determine what to display
        if !self.box.isMine {
            if self.box.neighboringMines == 0 {
                // case 1: no mine and 0 neighboring mine
                return "o"
            }else {
                // case 2:  no mine and neighboring mines
                return "\(self.box.neighboringMines)"
            }
        }
        // case 3: a mine
        return "*"
    }
    
}

