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
        self.players = []
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
        self.players += [playerName]
    }
    
    func setWins(newWins: Int) {
        self.win = newWins
    }
    
    func setLosses(newLosses: Int) {
        self.loss = newLosses
    }
    
    func getPlayerList() -> [String] {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        self.players = userDefaults.objectForKey("players") as [String]
        return self.players
    }
    
    func setUserDefaults() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(self.playerName as String, forKey: self.playerName)
        userDefaults.setInteger(win, forKey: "\(playerName)win")
        userDefaults.setInteger(loss, forKey: "\(playerName)loss")
        userDefaults.setObject(self.players as Array, forKey: "players")
    }
    
    func getUserDefaults() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        playerName = userDefaults.objectForKey(self.playerName) as String
        win = userDefaults.integerForKey("\(playerName)win")
        loss = userDefaults.integerForKey("\(playerName)loss")
    }
}