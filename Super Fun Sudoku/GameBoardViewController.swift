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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
        if boardRow1[0].text == "5" {
            backLabel.text = ""
            winLabel.text = "You Win!"
            playerModel.setWins(playerModel.getWins() + 1)
        }
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
    
}
