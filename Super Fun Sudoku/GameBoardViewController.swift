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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for i in 0...8 {
            boardRow1[i].delegate = self
        }
        for i in 0...8 {
            boardRow2[i].delegate = self
        }
        for i in 0...8 {
            boardRow3[i].delegate = self
        }
        for i in 0...8 {
            boardRow4[i].delegate = self
        }
        for i in 0...8 {
            boardRow5[i].delegate = self
        }
        for i in 0...8 {
            boardRow6[i].delegate = self
        }
        for i in 0...8 {
            boardRow7[i].delegate = self
        }
        for i in 0...8 {
            boardRow8[i].delegate = self
        }
        for i in 0...8 {
            boardRow9[i].delegate = self
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.selectedTextRange = textField.textRangeFromPosition(textField.beginningOfDocument, toPosition: textField.endOfDocument)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let maxLength = countElements(textField.text) + countElements(string) - range.length
        return maxLength <= 1
    }
    
}
