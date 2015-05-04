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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var boardRow = [boardRow1, boardRow2, boardRow3, boardRow4, boardRow5, boardRow6, boardRow7, boardRow8, boardRow9]
        for i in 0...8 {
            var tempBoardRow = boardRow[i]
            for j in 0...8 {
                tempBoardRow[j].delegate = self
            }
            boardRow[i] = tempBoardRow
        }
        setUpGame()
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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        // Call check for win after a UITextField is no longer being edited
        self.view.endEditing(true)
        checkForWin()
    }
    
    override func viewDidDisappear(animated: Bool) {
        // Add a loss is game isn't over
        if winLabel.text != "You Win!" {
            playerModel.setLosses(playerModel.getLosses() + 1)
        }
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
        
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        let hours = UInt8(elapsedTime / 3600.0)
        elapsedTime -= (NSTimeInterval(hours) * 3600)
        
        //calculate the seconds in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //find out the fraction of milliseconds to be displayed.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        let strHours = hours > 9 ? "\(String(hours))":"0\(String(hours))"
        let strMinutes = minutes > 9 ? "\(String(minutes))":"0\(String(minutes))"
        let strSeconds = seconds > 9 ? "\(String(seconds))":"0\(String(seconds))"
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        timePassed.text = "\(strHours):\(strMinutes):\(strSeconds)"
    }
    
    /**
    Sets up a new Sudoku game
    
    This method sets up a new Sudoku game by placing the
    known values in the correct UITextFields and disabling
    those UITextFields from being edited.
    */
    func setUpGame() {
        boardRow1[1].text = "7"
        boardRow1[1].enabled = false
        boardRow1[2].text = "2"
        boardRow1[2].enabled = false
        boardRow1[4].text = "3"
        boardRow1[4].enabled = false
        boardRow1[5].text = "6"
        boardRow1[5].enabled = false
        boardRow1[6].text = "4"
        boardRow1[6].enabled = false
        
        boardRow2[1].text = "9"
        boardRow2[1].enabled = false
        boardRow2[3].text = "7"
        boardRow2[3].enabled = false
        boardRow2[7].text = "3"
        boardRow2[7].enabled = false
        boardRow2[8].text = "5"
        boardRow2[8].enabled = false
        
        boardRow3[3].text = "1"
        boardRow3[3].enabled = false
        boardRow3[4].text = "8"
        boardRow3[4].enabled = false
        boardRow3[8].text = "2"
        boardRow3[8].enabled = false
        
        boardRow4[0].text = "2"
        boardRow4[0].enabled = false
        boardRow4[2].text = "6"
        boardRow4[2].enabled = false
        boardRow4[7].text = "9"
        boardRow4[7].enabled = false
        
        boardRow5[0].text = "3"
        boardRow5[0].enabled = false
        boardRow5[2].text = "5"
        boardRow5[2].enabled = false
        boardRow5[4].text = "9"
        boardRow5[4].enabled = false
        boardRow5[6].text = "6"
        boardRow5[6].enabled = false
        boardRow5[8].text = "8"
        boardRow5[8].enabled = false
        
        boardRow6[1].text = "4"
        boardRow6[1].enabled = false
        boardRow6[6].text = "5"
        boardRow6[6].enabled = false
        boardRow6[8].text = "1"
        boardRow6[8].enabled = false
        
        boardRow7[0].text = "7"
        boardRow7[0].enabled = false
        boardRow7[4].text = "2"
        boardRow7[4].enabled = false
        boardRow7[5].text = "3"
        boardRow7[5].enabled = false
        
        boardRow8[0].text = "1"
        boardRow8[0].enabled = false
        boardRow8[1].text = "5"
        boardRow8[1].enabled = false
        boardRow8[5].text = "4"
        boardRow8[5].enabled = false
        boardRow8[7].text = "8"
        boardRow8[7].enabled = false
        
        boardRow9[2].text = "8"
        boardRow9[2].enabled = false
        boardRow9[3].text = "6"
        boardRow9[3].enabled = false
        boardRow9[4].text = "1"
        boardRow9[4].enabled = false
        boardRow9[6].text = "9"
        boardRow9[6].enabled = false
        boardRow9[7].text = "7"
        boardRow9[7].enabled = false
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
            backLabel.text = ""
            winLabel.text = "You Win!"
            timer.invalidate()
            playerModel.setWins(playerModel.getWins() + 1)
        }
    }
}
