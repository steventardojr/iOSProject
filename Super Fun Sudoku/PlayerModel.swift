//
//  PlayerModel.swift
//  Super Fun Sudoku
//
//  Created by Steven Tardo Jr. on 3/14/15.
//  Copyright (c) 2015 CSCI 4661. All rights reserved.
//

import Foundation

class PlayerModel {
    var playerName: String!
    var win: Int
    var loss: Int
    
    init() {
        self.playerName = ""
        self.win = 0
        self.loss = 0
    }
    
    func getPlayerName() -> String {
        return self.playerName
    }
    
    func getWins() -> Int {
        return self.win
    }
    
    func getLosses() -> Int {
        return self.loss
    }
    
    func setPlayerName(newPlayerName: String!) {
        self.playerName = newPlayerName
    }
    
    func setWins(newWins: Int) {
        self.win = newWins
    }
    
    func setLosses(newLosses: Int) {
        self.loss = newLosses
    }
    
    func setUserDefaults() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(self, forKey: self.playerName)
    }
}