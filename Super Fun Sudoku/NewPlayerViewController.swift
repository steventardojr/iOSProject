//
//  NewPlayerViewController.swift
//  Super Fun Sudoku
//
//  Created by Steven Tardo Jr. on 3/14/15.
//  Copyright (c) 2015 CSCI 4661. All rights reserved.
//

import UIKit

class NewPlayerViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var nameAlreadyTakenLabel: UILabel!
    @IBOutlet var playerName: UITextField!
    let playerModel = PlayerModel()
    var players: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        playerName.delegate = self
        navigationItem.title = "Create New Player"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okButtonPushed(sender: UIButton) {
        if !(contains(playerModel.getPlayerList(), playerName.text)) {
            playerName.resignFirstResponder()
        }
        else {
            nameAlreadyTakenLabel.text = "That name has already been taken."
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        if !(contains(playerModel.getPlayerList(), playerName.text)) {
            playerName.resignFirstResponder()
            return true
        }
        else {
            nameAlreadyTakenLabel.text = "That name has already been taken."
            return false
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationVC = segue.destinationViewController as NewGameViewController
        playerModel.setPlayerName(playerName.text)
        destinationVC.playerModel = playerModel
    }
}