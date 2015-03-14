//
//  NewPlayerViewController.swift
//  Super Fun Sudoku
//
//  Created by Steven Tardo Jr. on 3/14/15.
//  Copyright (c) 2015 CSCI 4661. All rights reserved.
//

import UIKit

class NewPlayerViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var playerName: UITextField!
    let playerModel = PlayerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        playerName.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okButtonPushed(sender: UIButton) {
        playerName.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        playerName.resignFirstResponder()
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationVC = segue.destinationViewController as NewGameViewController
        let playerNameString = playerName.text
        playerModel.setPlayerName(playerNameString)
        playerModel.setUserDefaults()
        destinationVC.playerModel = playerModel
    }
}