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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
        checkForWin()
    }
    
    override func viewDidDisappear(animated: Bool) {
        if winLabel.text != "You Win!" {
            playerModel.setLosses(playerModel.getLosses() + 1)
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.selectedTextRange = textField.textRangeFromPosition(textField.beginningOfDocument, toPosition: textField.endOfDocument)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let maxLength = countElements(textField.text) + countElements(string) - range.length
        return maxLength <= 1
    }
    
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
    
    func checkForWin() {
        var didWin = true
        
        if boardRow1[0] != "8" {
            didWin = false
        }
        if boardRow1[3] != "5" {
            didWin = false
        }
        if boardRow1[7] != "1" {
            didWin = false
        }
        if boardRow1[8] != "9" {
            didWin = false
        }
        if boardRow2[0] != "6" {
            didWin = false
        }
        if boardRow2[2] != "1" {
            didWin = false
        }
        if boardRow2[4] != "4" {
            didWin = false
        }
        if boardRow2[5] != "2" {
            didWin = false
        }
        if boardRow2[6] != "8" {
            didWin = false
        }
        if boardRow3[0] != "5" {
            didWin = false
        }
        if boardRow3[1] != "3" {
            didWin = false
        }
        if boardRow3[2] != "4" {
            didWin = false
        }
        if boardRow3[5] != "9" {
            didWin = false
        }
        if boardRow3[6] != "7" {
            didWin = false
        }
        if boardRow3[7] != "6" {
            didWin = false
        }
        if boardRow4[1] != "8" {
            didWin = false
        }
        if boardRow4[3] != "4" {
            didWin = false
        }
        if boardRow4[4] != "5" {
            didWin = false
        }
        if boardRow4[5] != "1" {
            didWin = false
        }
        if boardRow4[6] != "3" {
            didWin = false
        }
        if boardRow4[8] != "7" {
            didWin = false
        }
        if boardRow5[1] != "1" {
            didWin = false
        }
        if boardRow5[3] != "2" {
            didWin = false
        }
        if boardRow5[5] != "7" {
            didWin = false
        }
        if boardRow5[7] != "4" {
            didWin = false
        }
        if boardRow6[0] != "9" {
            didWin = false
        }
        if boardRow6[2] != "7" {
            didWin = false
        }
        if boardRow6[3] != "3" {
            didWin = false
        }
        if boardRow6[4] != "6" {
            didWin = false
        }
        if boardRow6[5] != "8" {
            didWin = false
        }
        if boardRow6[7] != "2" {
            didWin = false
        }
        if boardRow7[1] != "6" {
            didWin = false
        }
        if boardRow7[2] != "9" {
            didWin = false
        }
        if boardRow7[3] != "8" {
            didWin = false
        }
        if boardRow7[6] != "1" {
            didWin = false
        }
        if boardRow7[7] != "5" {
            didWin = false
        }
        if boardRow7[8] != "4" {
            didWin = false
        }
        if boardRow8[2] != "3" {
            didWin = false
        }
        if boardRow8[3] != "9" {
            didWin = false
        }
        if boardRow8[4] != "7" {
            didWin = false
        }
        if boardRow8[6] != "2" {
            didWin = false
        }
        if boardRow8[8] != "6" {
            didWin = false
        }
        if boardRow9[0] != "4" {
            didWin = false
        }
        if boardRow9[1] != "2" {
            didWin = false
        }
        if boardRow9[5] != "5" {
            didWin = false
        }
        if boardRow9[8] != "3" {
            didWin = false
        }
        
        if didWin == true {
            backLabel.text = ""
            winLabel.text = "You Win!"
            playerModel.setWins(playerModel.getWins() + 1)
        }
    }
}
