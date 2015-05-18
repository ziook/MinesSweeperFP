//
//  ViewController.swift
//  minesSweeperFP
//
//  Created by Victor ALIBERT on 14/05/2015.
//  Copyright (c) 2015 Victor ALIBERT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var minesNumLabel: UILabel!
    @IBOutlet weak var MSView: UIView!
    @IBOutlet weak var minesDetectionSwitch: UISwitch!
    
    @IBAction func newGameClicked(sender: AnyObject) {
        println("New Game");
        self.startGame()
    }
    
    //other var
    var gridSize:Int = 8
    // box image (round box)
    let image = UIImage(named: "roundBox.png") as UIImage?
    var grid:Grid
    var buttons:[Button] = []
    //contain the buttons that have a mine
    var minesArray:[Button] = []
    var minesNum:Int = 0
    
    required init(coder aDecoder: NSCoder)
    {
        println("\(gridSize)")
        self.grid = Grid(size: gridSize)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize the grid with the size choosen by difficulty
        self.grid = Grid(size: gridSize)
        self.initializeGrid()
        self.startGame()
    }
    
    func initializeGrid() {
        for row in 0 ..< grid.size {
            for col in 0 ..< grid.size {
                
                let box = grid.boxes[row][col]
                
                let boxSize:CGFloat = self.MSView.frame.width / CGFloat(gridSize)
                
                let button = Button(box: box, boxSize: boxSize);
                button.setTitle("", forState: .Normal)
                button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                button.setBackgroundImage(image, forState: .Normal);
                button.addTarget(self, action: "buttonClicked:", forControlEvents: .TouchUpInside)
                self.MSView.addSubview(button)
                
                self.buttons.append(button)
                
            }
        }
        
    }
    
    // reset the grid
    func startGame() {
        self.minesArray = []
        self.minesNum = 0
        self.grid.resetGrid()
        // reset mines number for the new game
        for button in self.buttons {
            button.setTitle("", forState: .Normal)
            // in order to count the number of mines
            if button.box.isMine {
                self.minesArray.append(button)
                self.minesNum = self.minesNum + 1
            }
        }
        self.minesNumLabel.text = "Mines : \(self.minesNum)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func buttonClicked(sender: Button) {
        if minesDetectionSwitch.on {
            sender.setTitle("|>", forState: .Normal)
            self.minesNum = self.minesNum - 1
            self.minesNumLabel.text = "Mines: \(minesNum)"
        }
        else {
            if !sender.box.isRevealed {
                //if sender
                sender.box.isRevealed = true
                sender.setTitle("\(sender.getLabelText())", forState: .Normal)
                // automatic box revelation
                if sender.getLabelText() == "o" {
                    let adjacentOffsets =
                    [(-1,-1),(0,-1),(1,-1),
                        (-1,0),(1,0),
                        (-1,1),(0,1),(1,1)]
                    var nextBoxes:[Box] = []
                    
                    for (rowOffset,colOffset) in adjacentOffsets {
                        nextBoxes.append(Box(row:sender.box.row + rowOffset, col:sender.box.col + colOffset))
                    }
                    for nextBox in nextBoxes {
                        for nextButton in self.buttons {
                            if (nextButton.box.row == nextBox.row && nextButton.box.col == nextBox.col) {
                                buttonClicked(nextButton)
                            }
                        }
                    }
                }
            }
            
            if sender.box.isMine {
                self.mineButtonClicked()
            }
            
            var nonRevealedBoxes: [Box] = []
            var minesBoxes: [Box] = []
            for button in buttons {
                if (!button.box.isRevealed){
                    nonRevealedBoxes.append(button.box)
                }
            }
            println("\(nonRevealedBoxes.count)")
            println("\(self.minesNum)")
            if nonRevealedBoxes.count == self.minesArray.count {
                allMinesDetected()
            }
        }

    }
    
    
    func allMinesDetected() {
        // "you win" alert view
        var alertView1 = UIAlertView()
        alertView1.addButtonWithTitle("New Game")
        alertView1.title = "You win"
        alertView1.message = "You detected all the mines."
        alertView1.tag = 1
        alertView1.show()
        alertView1.delegate = self
    }
    
    func mineButtonClicked() {
        // "you lose" alert view
        var alertView2 = UIAlertView()
        alertView2.addButtonWithTitle("New Game")
        alertView2.title = "You lose"
        alertView2.message = "You touched a mine."
        alertView2.tag = 0
        alertView2.show()
        alertView2.delegate = self
    }
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
            self.startGame()
    }
    
}
