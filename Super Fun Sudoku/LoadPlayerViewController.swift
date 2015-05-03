//
//  LoadPlayerViewController.swift
//  Super Fun Sudoku
//
//  Created by Steven Tardo Jr. on 3/14/15.
//  Copyright (c) 2015 CSCI 4661. All rights reserved.
//

import UIKit

class LoadPlayerViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    let playerModel = PlayerModel()
    var players: [String]!
    var selectedPlayer: String!
    var arrayIndex: Int!
    @IBOutlet var loadButton: UIButton!
    @IBOutlet var picker: UIPickerView!
    @IBOutlet var noSavedPlayersLabel: UILabel!
    @IBOutlet var deleteButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        players = playerModel.getPlayerList()
        picker.dataSource = self
        picker.delegate = self
        playerListIsEmpty()
        navigationItem.title = "Load Player"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationVC = segue.destinationViewController as! NewGameViewController
        /*
        If the user does not touch the UIPickerView, this if statement
        sets the selected player to the first saved player.
        */
        if selectedPlayer == nil {
            selectedPlayer = players[0]
        }
        
        playerModel.setPlayerName(selectedPlayer)
        playerModel.getUserDefaults()
        destinationVC.playerModel = playerModel
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return players.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        arrayIndex = row
        return players[row]
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        let pickerLabel = UILabel()
        let titleData = players[row]
        arrayIndex = row
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Noteworthy-Bold", size: 30.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = .Center
        return pickerLabel
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPlayer = players[row]
        arrayIndex = row
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
    
    /**
    Checks if the array in the Player model is empty
    
    This method checks if the array in the Player model is empty,
    disables the load and delete buttons, and adds the label
    "No Saved Players"
    */
    func playerListIsEmpty() {
        if playerModel.getPlayerList().isEmpty {
            loadButton.hidden = true
            deleteButton.hidden = true
            noSavedPlayersLabel.text = "No Saved Players"
        }
    }
    
    /**
    Performs the necessary actions when the Delete button is pushed
    
    This method removes the selected player from the array in the Player model,
    and removes the values stored for keys associated with the player's name
    in NSUserDefaults, then reloads the picker
    
    :param: sender The Delete UIButton
    */
    @IBAction func deleteButtonPush(sender: UIButton) {
        /*
        If the user does not touch the UIPickerView, this if statement
        sets the selected player to the first saved player.
        */
        if selectedPlayer == nil {
            selectedPlayer = players[0]
        }
        
        playerModel.removeUserDefaults(selectedPlayer, indexForArray: arrayIndex)
        players = playerModel.getPlayerList()
        picker.reloadAllComponents()
        playerListIsEmpty()
    }

}
