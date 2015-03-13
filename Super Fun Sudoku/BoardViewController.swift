//
//  BoardViewController.swift
//  Super Fun Sudoku
//
//  Created by Steven Tardo Jr. on 3/12/15.
//  Copyright (c) 2015 CSCI 4661. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    
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

}
