//
//  StartViewController.swift
//  minesSweeperFP
//
//  Created by Victor ALIBERT on 14/05/2015.
//  Copyright (c) 2015 Victor ALIBERT. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    var difficulty:Int!
    
    @IBAction func easyGameClicked(sender: AnyObject) {
        println("easy")
        difficulty = 8
    }
    
    @IBAction func hardGameClicked(sender: AnyObject) {
        println("hard")
        difficulty = 16
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "segueDifficulty") {
            var vc = segue!.destinationViewController as! ViewController;
            
            vc.gridSize = difficulty
            
        }
    }
    
}