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
        self.win = 0
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
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(self.playerName as String, forKey: self.playerName)
        userDefaults.setObject(self.players as Array, forKey: "players")
    }
    
    func setWins(newWins: Int) {
        self.win = newWins
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setInteger(self.win, forKey: "\(self.playerName)win")
    }
    
    func setLosses(newLosses: Int) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        self.loss = newLosses
        userDefaults.setInteger(self.loss, forKey: "\(self.playerName)loss")
    }
    
    func getPlayerList() -> [String] {
        return self.players
    }
    
    func getUserDefaults() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        self.playerName = userDefaults.objectForKey(self.playerName) as String
        self.win = userDefaults.integerForKey("\(self.playerName)win")
        self.loss = userDefaults.integerForKey("\(self.playerName)loss")
        self.players = userDefaults.objectForKey("players") as [String]
    }
    
    func removeUserDefaults(playerToRemove: String, indexForArray: Int) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.removeObjectForKey(playerToRemove)
        userDefaults.integerForKey("\(playerToRemove)win")
        userDefaults.integerForKey("\(playerToRemove)loss")
        self.players.removeAtIndex(indexForArray)
        userDefaults.setObject(self.players as Array, forKey: "players")
    }
}