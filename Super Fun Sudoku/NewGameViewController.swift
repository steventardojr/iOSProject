//
//  NewGameViewController.swift
//  Super Fun Sudoku
//
//  Created by Steven Tardo Jr. on 3/14/15.
//  Copyright (c) 2015 CSCI 4661. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController {
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var winLoss: UILabel!
    @IBOutlet var winPercent: UILabel!
    var playerModel: PlayerModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        welcomeLabel.text = "Welcome, \(playerModel.getPlayerName())"
        winLoss.text = "WIN/LOSS: \(playerModel.getWins())/\(playerModel.getLosses())"
        if (playerModel.getLosses() == 0) {
            winPercent.text = "WIN PERCENTAGE: 100%"
        }
        else {
            var winDouble = Int(Double(playerModel.getWins())/Double(playerModel.getLosses())*100)
            winPercent.text = "WIN PERCENTAGE: \(winDouble)%"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        welcomeLabel.text = "Welcome, \(playerModel.getPlayerName())"
        winLoss.text = "WIN/LOSS: \(playerModel.getWins())/\(playerModel.getLosses())"
        if (playerModel.getLosses() == 0) {
            winPercent.text = "WIN PERCENTAGE: 100%"
        }
        else {
            var winDouble = Int(Double(playerModel.getWins())/Double(playerModel.getLosses())*100)
            winPercent.text = "WIN PERCENTAGE: \(winDouble)%"
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationVC = segue.destinationViewController as GameBoardViewController
        destinationVC.playerModel = playerModel
    }
    
}