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
    
    /**
    Performs the necessary actions when the OK button is pushed.
    
    This method causes the UITextField playerName to resign first responder
    if the new player's name is not already taken, and updated the
    nameAlreadyTaken label if the name is already taken.
    
    :param: sender The OK UIButton
    */
    @IBAction func okButtonPushed(sender: UIButton) {
        if !(contains(playerModel.getPlayerList(), playerName.text)) {
            playerName.resignFirstResponder()
            nameAlreadyTakenLabel.text = ""
        }
        else {
            nameAlreadyTakenLabel.text = "That name has already been taken."
        }
    }
    
    /**
    Performs the necessary actions when the keyboard Done button is pushed.
    
    This method causes the UITextField playerName to resign first responder
    if the new player's name is not already taken, and updated the
    nameAlreadyTaken label if the name is already taken.
    
    :param: textField The UITextField from the view
    */
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        if !(contains(playerModel.getPlayerList(), playerName.text)) {
            playerName.resignFirstResponder()
            nameAlreadyTakenLabel.text = ""
            return true
        }
        else {
            nameAlreadyTakenLabel.text = "That name has already been taken."
            return false
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Selects all text if the UITextField is touched
        textField.selectedTextRange = textField.textRangeFromPosition(textField.beginningOfDocument, toPosition: textField.endOfDocument)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender as? UIBarButtonItem != navigationItem.leftBarButtonItem {
            var destinationVC = segue.destinationViewController as NewGameViewController
            playerModel.setPlayerName(playerName.text)
            destinationVC.playerModel = playerModel
        }
    }
    
}