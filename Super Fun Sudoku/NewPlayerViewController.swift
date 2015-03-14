//
//  NewPlayerViewController.swift
//  Super Fun Sudoku
//
//  Created by Steven Tardo Jr. on 3/14/15.
//  Copyright (c) 2015 CSCI 4661. All rights reserved.
//

import Foundation
import UIKit

class NewPlayerViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var playerName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        playerName.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}