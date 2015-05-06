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
    @IBOutlet var bestTime: UILabel!
    @IBOutlet var easyButton: UIButton!
    @IBOutlet var mediumButton: UIButton!
    @IBOutlet var hardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var isSaved = false
        welcomeLabel.text = "Welcome \(playerModel.getPlayerName())"
        winLoss.text = "NUMBER OF WINS/LOSSES: \(playerModel.getWins())/\(playerModel.getLosses())"
        if (playerModel.getWins() != 0 && playerModel.getLosses() == 0) {
            winPercent.text = "WIN/LOSS RATIO: ∞"
        }
        else if (playerModel.getWins() == 0 && playerModel.getLosses() == 0) {
            winPercent.text = "WIN/LOSS RATIO: 0.00"
        }
        else {
            var winDouble = (Double(playerModel.getWins())/Double(playerModel.getLosses()))
            var winString: String = String(format: "%.2f", winDouble)
            winPercent.text = "WIN/LOSS RATIO: \(winString)"
        }
        bestTime.text = "BEST TIME: \(playerModel.getBestTime())"
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if (userDefaults.objectForKey("\(playerModel.getPlayerName())isSaved") != nil) {
            isSaved = userDefaults.objectForKey("\(playerModel.getPlayerName())isSaved") as! Bool
        }
        if isSaved {
            easyButton.setTitle("Continue", forState: UIControlState.Normal)
            mediumButton.setTitle("", forState: UIControlState.Normal)
            mediumButton.enabled = false
            hardButton.setTitle("", forState: UIControlState.Normal)
            hardButton.enabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        /*
        This method is used to update values in the view
        if the player arrives at the view by using the back button
        in the Navigation Controller
        */
        easyButton.setTitle("Easy", forState: UIControlState.Normal)
        mediumButton.setTitle("Medium", forState: UIControlState.Normal)
        mediumButton.enabled = true
        hardButton.setTitle("Hard", forState: UIControlState.Normal)
        hardButton.enabled = true
        var isSaved = false
        welcomeLabel.text = "Welcome \(playerModel.getPlayerName())"
        winLoss.text = "NUMBER OF WINS/LOSSES: \(playerModel.getWins())/\(playerModel.getLosses())"
        if (playerModel.getWins() != 0 && playerModel.getLosses() == 0) {
            winPercent.text = "WIN/LOSS RATIO: ∞"
        }
        else if (playerModel.getWins() == 0 && playerModel.getLosses() == 0) {
            winPercent.text = "WIN/LOSS RATIO: 0.00"
        }
        else {
            var winDouble = (Double(playerModel.getWins())/Double(playerModel.getLosses()))
            var winString: String = String(format: "%.2f", winDouble)
            winPercent.text = "WIN/LOSS RATIO: \(winString)"
        }
        bestTime.text = "BEST TIME: \(playerModel.getBestTime())"
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if (userDefaults.objectForKey("\(playerModel.getPlayerName())isSaved") != nil) {
            isSaved = userDefaults.objectForKey("\(playerModel.getPlayerName())isSaved") as! Bool
        }
        if isSaved {
            easyButton.setTitle("Continue", forState: UIControlState.Normal)
            mediumButton.setTitle("", forState: UIControlState.Normal)
            mediumButton.enabled = false
            hardButton.setTitle("", forState: UIControlState.Normal)
            hardButton.enabled = false
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationVC = segue.destinationViewController as! GameBoardViewController
        destinationVC.playerModel = playerModel
    }
    
}