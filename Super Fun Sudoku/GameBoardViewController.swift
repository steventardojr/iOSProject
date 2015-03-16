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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newLength = countElements(textField.text) + countElements(string) - range.length
        return newLength <= 1 // Bool
    }
}
