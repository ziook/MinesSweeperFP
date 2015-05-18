
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
        // check the isMineLocation and numNeighboringMines properties to determine the text to display
        if !self.box.isMine {
            if self.box.neighboringMines == 0 {
                // case 1: there's no mine and no neighboring mines
                return "o"
            }else {
                // case 2: there's no mine but there are neighboring mines
                return "\(self.box.neighboringMines)"
            }
        }
        // case 3: there's a mine
        return "*"
    }
    
}

