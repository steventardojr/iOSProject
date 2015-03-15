//
//  PlayerModel.swift
//  Super Fun Sudoku
//
//  Created by Steven Tardo Jr. on 3/14/15.
//  Copyright (c) 2015 CSCI 4661. All rights reserved.
//

import Foundation

class PlayerModel {
    var playerName: String
    var win: Int
    var loss: Int
    var players: [String]
    
    init() {
        self.playerName = ""
        self.win = 1
        self.loss = 0
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if userDefaults.objectForKey("players") == nil {
            self.players = []
        }
        else {
            self.players = userDefaults.objectForKey("players") as [String]
        }
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
    
    func setPlayerName(newPlayerName: String) {
        self.playerName = newPlayerName
        if !(contains(self.players, newPlayerName)) {
            self.players += [self.playerName]
        }
    }
    
    func setWins(newWins: Int) {
        self.win = newWins
        setUserDefaults()
    }
    
    func setLosses(newLosses: Int) {
        self.loss = newLosses
        setUserDefaults()
    }
    
    func getPlayerList() -> [String] {
        return self.players
    }
    
    func setUserDefaults() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(self.playerName as String, forKey: self.playerName)
        userDefaults.setInteger(self.win, forKey: "\(playerName)win")
        userDefaults.setInteger(self.loss, forKey: "\(playerName)loss")
        userDefaults.setObject(self.players as Array, forKey: "players")
    }
    
    func getUserDefaults() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        playerName = userDefaults.objectForKey(self.playerName) as String
        win = userDefaults.integerForKey("\(self.playerName)win")
        loss = userDefaults.integerForKey("\(self.playerName)loss")
        players = userDefaults.objectForKey("players") as [String]
    }
}