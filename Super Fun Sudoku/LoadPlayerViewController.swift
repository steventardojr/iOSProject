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
        var destinationVC = segue.destinationViewController as NewGameViewController
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
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPlayer = players[row]
        arrayIndex = row
    }
    
    func playerListIsEmpty() {
        if playerModel.getPlayerList().isEmpty {
            loadButton.enabled = false
            deleteButton.enabled = false
            noSavedPlayersLabel.text = "No Saved Players"
        }
    }
    
    @IBAction func deleteButtonPush(sender: UIButton) {
        if selectedPlayer == nil {
            selectedPlayer = players[0]
        }
        playerModel.removeUserDefaults(selectedPlayer, indexForArray: arrayIndex)
        players = playerModel.getPlayerList()
        picker.reloadAllComponents()
        playerListIsEmpty()
    }

}
