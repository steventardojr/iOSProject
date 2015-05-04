//
//  PlayerModel.swift
//  Super Fun Sudoku
//
//  Created by Steven Tardo Jr. on 3/14/15.
//  Copyright (c) 2015 CSCI 4661. All rights reserved.
//

import Foundation

/**
A model for the player object

This class models a player object, and keeps track of a player's name, number of wins,
number of losses, and an array that contains all of the saved games. This information
is kept persistent through sessions by using NSUserDefaults.
*/
class PlayerModel {
    var playerName: String
    var win: Int
    var loss: Int
    var bestTime: String
    var players: [String]
    
    init() {
        self.playerName = ""
        self.win = 0
        self.loss = 0
        self.bestTime = "00:00:00"
        let userDefaults = NSUserDefaults.standardUserDefaults()
        // Initialize array even if NSUserDefaults does not contain a value
        if userDefaults.objectForKey("players") == nil {
            self.players = []
        }
        else {
            self.players = userDefaults.objectForKey("players") as! [String]
        }
    }
    
    /**
    Returns the player's name.
    
    This method returns the player's name as a String.
    
    :returns: playerName Player's name
    */
    func getPlayerName() -> String {
        return self.playerName
    }
    
    /**
    Returns the player's number of wins.
    
    This method returns the player's number of wins
    as an Int.
    
    :returns: win Player's number of wins
    */
    func getWins() -> Int {
        return self.win
    }
    
    /**
    Returns the player's number of losses.
    
    This method returns the player's number of losses
    as an Int.
    
    :returns: loss Player's number of wins
    */
    func getLosses() -> Int {
        return self.loss
    }
    
    /**
    Returns the player's best time.
    
    This method returns the player's best time
    as a String.
    
    :returns: loss Player's number of wins
    */
    func getBestTime() -> String {
        return self.bestTime
    }
    
    /**
    Sets the player's name.
    
    This method set's the player's name as a String
    and adds the player to the saved players Array
    if it is not already contained in the Array of
    saved players, and updates the values in NSUserDefaults.
    
    :param: newPlayerName The new player's name
    */
    func setPlayerName(newPlayerName: String) {
        self.playerName = newPlayerName
        if !(contains(self.players, newPlayerName)) {
            self.players += [self.playerName]
        }
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(self.playerName as String, forKey: self.playerName)
        userDefaults.setObject(self.players as Array, forKey: "players")
    }
    
    /**
    Updates the player's number of wins.
    
    This method updates the player's number of wins
    and then updates the value in NSUserDefaults.
    
    :param: newWins The new number of wins
    */
    func setWins(newWins: Int) {
        self.win = newWins
        let userDefaults = NSUserDefaults.standardUserDefaults()
        var keyStore = NSUbiquitousKeyValueStore.defaultStore()
        userDefaults.setInteger(self.win, forKey: "\(self.playerName)win")
        keyStore.setObject(self.win, forKey: "\(self.playerName)win")
        userDefaults.synchronize()
        keyStore.synchronize()
    }
    
    /**
    Updates the player's number of losses.
    
    This method updates the player's number of losses
    and then updates the value in NSUserDefaults.
    
    :param: newLosses The new number of losses
    */
    func setLosses(newLosses: Int) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        self.loss = newLosses
        var keyStore = NSUbiquitousKeyValueStore.defaultStore()
        userDefaults.setInteger(self.loss, forKey: "\(self.playerName)loss")
        keyStore.setObject(self.loss, forKey: "\(self.playerName)loss")
        userDefaults.synchronize()
        keyStore.synchronize()
    }
    
    /**
    Updates the player's best time.
    
    This method updates the player's best time
    and then updates the value in NSUserDefaults.
    
    :param: newLosses The new number of losses
    */
    func setBestTime(newBestTime: String) {
        if newBestTime < self.bestTime || self.bestTime == "00:00:00" {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            self.bestTime = newBestTime
            var keyStore = NSUbiquitousKeyValueStore.defaultStore()
            userDefaults.setObject(self.bestTime, forKey: "\(self.playerName)bestTime")
            keyStore.setObject(self.bestTime, forKey: "\(self.playerName)bestTime")
            userDefaults.synchronize()
            keyStore.synchronize()
        }
    }
    
    /**
    Returns the saved players Array.
    
    This method returns the Array that contains
    all of the saved players.
    
    :returns: players The array of saved players
    */
    func getPlayerList() -> [String] {
        return self.players
    }
    
    /**
    Loads all the NSUserDefaults for current player.
    
    This method sets all of the values in the class to those
    stored in NSUserDefaults based on the name of the current player.
    */
    func getUserDefaults() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        var keyStore = NSUbiquitousKeyValueStore.defaultStore()
        self.playerName = userDefaults.objectForKey(self.playerName) as! String
        if userDefaults.integerForKey("\(self.playerName)win") > keyStore.objectForKey("\(self.playerName)win") as? Int {
            self.win = userDefaults.integerForKey("\(self.playerName)win")
        }
        else {
            self.win = keyStore.objectForKey("\(self.playerName)win") as! Int
        }
        if userDefaults.integerForKey("\(self.playerName)loss") > keyStore.objectForKey("\(self.playerName)loss") as? Int {
            self.loss = userDefaults.integerForKey("\(self.playerName)loss")
        }
        else {
            self.loss = keyStore.objectForKey("\(self.playerName)loss") as! Int
        }
        if userDefaults.objectForKey("\(self.playerName)bestTime") == nil || (userDefaults.objectForKey("\(self.playerName)bestTime") as! String) == "00:00:00" {
            self.bestTime = "00:00:00"
        }
        else if keyStore.objectForKey("\(self.playerName)bestTime") == nil || (keyStore.objectForKey("\(self.playerName)bestTime") as! String) == "00:00:00" {
            self.bestTime = "00:00:00"
        }
        else if (userDefaults.objectForKey("\(self.playerName)bestTime") as! String) < (keyStore.objectForKey("\(self.playerName)bestTime") as! String) {
            self.bestTime = userDefaults.objectForKey("\(self.playerName)bestTime") as! String
        }
        else {
            self.bestTime = keyStore.objectForKey("\(self.playerName)bestTime") as! String
        }
        self.players = userDefaults.objectForKey("players") as! [String]
    }
    
    /**
    Removes the saved player in NSUserDefaults
    
    This method removes all of the values saved in NSUserDefaults
    for the current player and updates the Array containing all of
    the saved players.
    
    :param: playerToRemove The name of the player to remove
    :param: indexForArray The index at which the current player is stored
    */
    func removeUserDefaults(playerToRemove: String, indexForArray: Int) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        var keyStore = NSUbiquitousKeyValueStore.defaultStore()
        userDefaults.removeObjectForKey(playerToRemove)
        userDefaults.removeObjectForKey("\(playerToRemove)win")
        keyStore.removeObjectForKey("\(playerToRemove)win")
        userDefaults.removeObjectForKey("\(playerToRemove)loss")
        keyStore.removeObjectForKey("\(playerToRemove)loss")
        userDefaults.removeObjectForKey("\(playerToRemove)bestTime")
        keyStore.removeObjectForKey("\(playerToRemove)bestTime")
        self.players.removeAtIndex(indexForArray)
        userDefaults.setObject(self.players as Array, forKey: "players")
        userDefaults.synchronize()
        keyStore.synchronize()
    }
}