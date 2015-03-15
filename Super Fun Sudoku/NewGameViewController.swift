//
//  NewGameViewController.swift
//  Super Fun Sudoku
//
//  Created by Steven Tardo Jr. on 3/14/15.
//  Copyright (c) 2015 CSCI 4661. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController {
    @IBOutlet var playerLabel: UILabel!
    @IBOutlet var winLoss: UILabel!
    @IBOutlet var winPercent: UILabel!
    
    var playerModel: PlayerModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        playerLabel.text = playerModel.getPlayerName()
        winLoss.text = "WIN/LOSS: \(playerModel.getWins())/\(playerModel.getLosses())"
        var winPercentage = 0
        if (playerModel.getLosses() == 0) {
            winPercentage = 100
        }
        else {
            winPercentage = playerModel.getWins()/playerModel.getLosses()*100
        }
        winPercent.text = "WIN PERCENTAGE: \(winPercentage)%"
        playerModel.setWins(playerModel.getWins() + 5)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}