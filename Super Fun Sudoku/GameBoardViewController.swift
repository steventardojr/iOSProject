//
//  GameBoardViewController.swift
//  Super Fun Sudoku
//
//  Created by Steven Tardo Jr. on 3/15/15.
//  Copyright (c) 2015 CSCI 4661. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var boardRow1: [UITextField]!
    @IBOutlet var boardRow2: [UITextField]!
    @IBOutlet var boardRow3: [UITextField]!
    @IBOutlet var boardRow4: [UITextField]!
    @IBOutlet var boardRow5: [UITextField]!
    @IBOutlet var boardRow6: [UITextField]!
    @IBOutlet var boardRow7: [UITextField]!
    @IBOutlet var boardRow8: [UITextField]!
    @IBOutlet var boardRow9: [UITextField]!
    @IBOutlet var winLabel: UILabel!
    @IBOutlet var backLabel: UILabel!
    var playerModel: PlayerModel!
    @IBOutlet var timePassed: UILabel!
    var startTime: NSTimeInterval!
    var timer: NSTimer!
    var boardRow: [[UITextField]]!
    @IBOutlet var giveUpButton: UIButton!
    var baseHours: Int!
    var baseMinutes: Int!
    var baseSeconds: Int!
    var newHours: Int!
    var newMinutes: Int!
    var newSeconds: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var isSaved = false
        
        boardRow = [boardRow1, boardRow2, boardRow3, boardRow4, boardRow5, boardRow6, boardRow7, boardRow8, boardRow9]
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if (userDefaults.objectForKey("\(playerModel.getPlayerName())isSaved") != nil) {
            isSaved = userDefaults.objectForKey("\(playerModel.getPlayerName())isSaved") as! Bool
        }
        if isSaved {
            for i in 0...8 {
                var tempBoardRow = boardRow[i]
                for j in 0...8 {
                    tempBoardRow[j].text = userDefaults.objectForKey("\(playerModel.getPlayerName())\(i)\(j)") as! String
                    tempBoardRow[j].delegate = self
                    if (userDefaults.objectForKey("\(playerModel.getPlayerName())\(i)\(j)enab") != nil) && (!(userDefaults.objectForKey("\(playerModel.getPlayerName())\(i)\(j)enab") as! Bool)) {
                        tempBoardRow[j].enabled = false
                    }
                }
                boardRow[i] = tempBoardRow
                baseHours = (userDefaults.objectForKey("\(playerModel.getPlayerName())hours") as! Int)
                baseMinutes = (userDefaults.objectForKey("\(playerModel.getPlayerName())minutes") as! Int)
                baseSeconds = (userDefaults.objectForKey("\(playerModel.getPlayerName())seconds") as! Int)
            }
        }
        else {
            for i in 0...8 {
                var tempBoardRow = boardRow[i]
                for j in 0...8 {
                    tempBoardRow[j].delegate = self
                }
                boardRow[i] = tempBoardRow
            }
            setUpGame()
            baseHours = 0
            baseMinutes = 0
            baseSeconds = 0
        }
        
        startTime = NSTimeInterval()
        timer = NSTimer()
        let aSelector : Selector = "updateTime"
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        if winLabel.text != "You Win!" && winLabel.text != "You Lose" {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            for i in 0...8 {
                var tempBoardRow = boardRow[i]
                for j in 0...8 {
                    userDefaults.setObject(tempBoardRow[j].text, forKey: "\(playerModel.getPlayerName())\(i)\(j)")
                }
            }
            userDefaults.setObject(newHours, forKey: "\(playerModel.getPlayerName())hours")
            userDefaults.setObject(newMinutes, forKey: "\(playerModel.getPlayerName())minutes")
            userDefaults.setObject(newSeconds, forKey: "\(playerModel.getPlayerName())seconds")
            
            var isSaved = true
            userDefaults.setObject(isSaved, forKey: "\(playerModel.getPlayerName())isSaved")
        }
    }
    
    @IBAction func giveUpButtonPush(sender: UIButton) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        self.view.endEditing(true)
        for i in 0...8 {
            var tempBoardRow = boardRow[i]
            for j in 0...8 {
                tempBoardRow[j].enabled = false
                if userDefaults.objectForKey("\(playerModel.getPlayerName())\(i)\(j)") != nil {
                    userDefaults.removeObjectForKey("\(playerModel.getPlayerName())\(i)\(j)")
                }
                if userDefaults.objectForKey("\(playerModel.getPlayerName())\(i)\(j)") != nil {
                    userDefaults.removeObjectForKey("\(playerModel.getPlayerName())\(i)\(j)enab")
                }
            }
            boardRow[i] = tempBoardRow
        }
        var isSaved = false
        userDefaults.setObject(isSaved, forKey: "\(playerModel.getPlayerName())isSaved")
        backLabel.text = ""
        winLabel.text = "You Lose"
        timer.invalidate()
        playerModel.setLosses(playerModel.getLosses() + 1)
        giveUpButton.enabled = false
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        // Call check for win after a UITextField is no longer being edited
        self.view.endEditing(true)
        checkForWin()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Selects all current text
        textField.selectedTextRange = textField.textRangeFromPosition(textField.beginningOfDocument, toPosition: textField.endOfDocument)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // Limits each UITextField to one character
        let maxLength = count(textField.text) + count(string) - range.length
        return maxLength <= 1
    }
    
    func updateTime() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime: NSTimeInterval = currentTime - startTime
        let hours = UInt8(elapsedTime / 3600.0) + UInt8(baseHours)
        newHours = Int(hours)
        elapsedTime -= (NSTimeInterval(hours) * 3600)
        let minutes = UInt8(elapsedTime / 60.0) + UInt8(baseMinutes)
        newMinutes = Int(minutes)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        let seconds = UInt8(elapsedTime) + UInt8(baseSeconds)
        newSeconds = Int(seconds)
        elapsedTime -= NSTimeInterval(seconds)
        let strHours = hours > 9 ? "\(String(hours))":"0\(String(hours))"
        let strMinutes = minutes > 9 ? "\(String(minutes))":"0\(String(minutes))"
        let strSeconds = seconds > 9 ? "\(String(seconds))":"0\(String(seconds))"
        timePassed.text = "\(strHours):\(strMinutes):\(strSeconds)"
        checkForWin()
    }
    
    /**
    Sets up a new Sudoku game
    
    This method sets up a new Sudoku game by placing the
    known values in the correct UITextFields and disabling
    those UITextFields from being edited.
    */
    func setUpGame() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        boardRow1[1].text = "7"
        boardRow1[1].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())01enab")
        boardRow1[2].text = "2"
        boardRow1[2].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())02enab")
        boardRow1[4].text = "3"
        boardRow1[4].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())04enab")
        boardRow1[5].text = "6"
        boardRow1[5].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())05enab")
        boardRow1[6].text = "4"
        boardRow1[6].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())06enab")
        
        boardRow2[1].text = "9"
        boardRow2[1].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())11enab")
        boardRow2[3].text = "7"
        boardRow2[3].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())13enab")
        boardRow2[7].text = "3"
        boardRow2[7].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())17enab")
        boardRow2[8].text = "5"
        boardRow2[8].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())18enab")
        
        boardRow3[3].text = "1"
        boardRow3[3].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())23enab")
        boardRow3[4].text = "8"
        boardRow3[4].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())24enab")
        boardRow3[8].text = "2"
        boardRow3[8].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())28enab")
        
        boardRow4[0].text = "2"
        boardRow4[0].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())30enab")
        boardRow4[2].text = "6"
        boardRow4[2].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())32enab")
        boardRow4[7].text = "9"
        boardRow4[7].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())37enab")
        
        boardRow5[0].text = "3"
        boardRow5[0].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())40enab")
        boardRow5[2].text = "5"
        boardRow5[2].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())42enab")
        boardRow5[4].text = "9"
        boardRow5[4].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())44enab")
        boardRow5[6].text = "6"
        boardRow5[6].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())46enab")
        boardRow5[8].text = "8"
        boardRow5[8].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())48enab")
        
        boardRow6[1].text = "4"
        boardRow6[1].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())51enab")
        boardRow6[6].text = "5"
        boardRow6[6].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())56enab")
        boardRow6[8].text = "1"
        boardRow6[8].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())58enab")
        
        boardRow7[0].text = "7"
        boardRow7[0].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())60enab")
        boardRow7[4].text = "2"
        boardRow7[4].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())64enab")
        boardRow7[5].text = "3"
        boardRow7[5].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())65enab")
        
        boardRow8[0].text = "1"
        boardRow8[0].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())70enab")
        boardRow8[1].text = "5"
        boardRow8[1].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())71enab")
        boardRow8[5].text = "4"
        boardRow8[5].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())75enab")
        boardRow8[7].text = "8"
        boardRow8[7].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())77enab")
        
        boardRow9[2].text = "8"
        boardRow9[2].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())82enab")
        boardRow9[3].text = "6"
        boardRow9[3].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())83enab")
        boardRow9[4].text = "1"
        boardRow9[4].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())84enab")
        boardRow9[6].text = "9"
        boardRow9[6].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())86enab")
        boardRow9[7].text = "7"
        boardRow9[7].enabled = false
        userDefaults.setObject(false, forKey: "\(playerModel.getPlayerName())87enab")
    }
    
    /**
    Checks to see if puzzle was solved.
    
    This method is called after each entry in a UITextField
    to check if the puzzle was solved. A Boolean value is
    set to false if the puzzle was not solved. If the Boolean
    value remains true after checking, a label is updated
    to let the player know they won, and a win is added to the
    value in the Player model.
    */
    func checkForWin() {
        var didWin: Bool = true
        
        if boardRow1[0].text != "8" {
            didWin = false
        }
        if boardRow1[3].text != "5" {
            didWin = false
        }
        if boardRow1[7].text != "1" {
            didWin = false
        }
        if boardRow1[8].text != "9" {
            didWin = false
        }
        if boardRow2[0].text != "6" {
            didWin = false
        }
        if boardRow2[2].text != "1" {
            didWin = false
        }
        if boardRow2[4].text != "4" {
            didWin = false
        }
        if boardRow2[5].text != "2" {
            didWin = false
        }
        if boardRow2[6].text != "8" {
            didWin = false
        }
        if boardRow3[0].text != "5" {
            didWin = false
        }
        if boardRow3[1].text != "3" {
            didWin = false
        }
        if boardRow3[2].text != "4" {
            didWin = false
        }
        if boardRow3[5].text != "9" {
            didWin = false
        }
        if boardRow3[6].text != "7" {
            didWin = false
        }
        if boardRow3[7].text != "6" {
            didWin = false
        }
        if boardRow4[1].text != "8" {
            didWin = false
        }
        if boardRow4[3].text != "4" {
            didWin = false
        }
        if boardRow4[4].text != "5" {
            didWin = false
        }
        if boardRow4[5].text != "1" {
            didWin = false
        }
        if boardRow4[6].text != "3" {
            didWin = false
        }
        if boardRow4[8].text != "7" {
            didWin = false
        }
        if boardRow5[1].text != "1" {
            didWin = false
        }
        if boardRow5[3].text != "2" {
            didWin = false
        }
        if boardRow5[5].text != "7" {
            didWin = false
        }
        if boardRow5[7].text != "4" {
            didWin = false
        }
        if boardRow6[0].text != "9" {
            didWin = false
        }
        if boardRow6[2].text != "7" {
            didWin = false
        }
        if boardRow6[3].text != "3" {
            didWin = false
        }
        if boardRow6[4].text != "6" {
            didWin = false
        }
        if boardRow6[5].text != "8" {
            didWin = false
        }
        if boardRow6[7].text != "2" {
            didWin = false
        }
        if boardRow7[1].text != "6" {
            didWin = false
        }
        if boardRow7[2].text != "9" {
            didWin = false
        }
        if boardRow7[3].text != "8" {
            didWin = false
        }
        if boardRow7[6].text != "1" {
            didWin = false
        }
        if boardRow7[7].text != "5" {
            didWin = false
        }
        if boardRow7[8].text != "4" {
            didWin = false
        }
        if boardRow8[2].text != "3" {
            didWin = false
        }
        if boardRow8[3].text != "9" {
            didWin = false
        }
        if boardRow8[4].text != "7" {
            didWin = false
        }
        if boardRow8[6].text != "2" {
            didWin = false
        }
        if boardRow8[8].text != "6" {
            didWin = false
        }
        if boardRow9[0].text != "4" {
            didWin = false
        }
        if boardRow9[1].text != "2" {
            didWin = false
        }
        if boardRow9[5].text != "5" {
            didWin = false
        }
        if boardRow9[8].text != "3" {
            didWin = false
        }
        
        if didWin {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            self.view.endEditing(true)
            for i in 0...8 {
                var tempBoardRow = boardRow[i]
                for j in 0...8 {
                    tempBoardRow[j].enabled = false
                    if userDefaults.objectForKey("\(playerModel.getPlayerName())\(i)\(j)") != nil {
                        userDefaults.removeObjectForKey("\(playerModel.getPlayerName())\(i)\(j)")
                    }
                    if userDefaults.objectForKey("\(playerModel.getPlayerName())\(i)\(j)") != nil {
                        userDefaults.removeObjectForKey("\(playerModel.getPlayerName())\(i)\(j)enab")
                    }
                }
                boardRow[i] = tempBoardRow
            }
            var isSaved = false
            userDefaults.setObject(isSaved, forKey: "\(playerModel.getPlayerName())isSaved")
            backLabel.text = ""
            winLabel.text = "You Win!"
            timer.invalidate()
            playerModel.setWins(playerModel.getWins() + 1)
            playerModel.setBestTime(timePassed.text as String!)
            giveUpButton.enabled = false
        }
    }
}
