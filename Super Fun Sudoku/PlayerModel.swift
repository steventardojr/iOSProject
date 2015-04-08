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
    var players: [String]
    
    init() {
        self.playerName = ""
        self.win = 0
        self.loss = 0
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
        userDefaults.setInteger(self.win, forKey: "\(self.playerName)win")
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
        userDefaults.setInteger(self.loss, forKey: "\(self.playerName)loss")
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
        self.playerName = userDefaults.objectForKey(self.playerName) as! String
        self.win = userDefaults.integerForKey("\(self.playerName)win")
        self.loss = userDefaults.integerForKey("\(self.playerName)loss")
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
        userDefaults.removeObjectForKey(playerToRemove)
        userDefaults.removeObjectForKey("\(playerToRemove)win")
        userDefaults.removeObjectForKey("\(playerToRemove)loss")
        self.players.removeAtIndex(indexForArray)
        userDefaults.setObject(self.players as Array, forKey: "players")
    }
}