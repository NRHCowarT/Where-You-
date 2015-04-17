//
//  GameData.swift
//  Where You @
//
//  Created by Nick Cowart on 3/15/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit

let _mainData: GameData = GameData()


class GameData: NSObject {
    
    var playerScore:Int?

    var score:Int = 0
    
    var myFriends: NSArray = []
    
    var selectedVenues:[AnyObject] = []
    var correctVenue:[AnyObject] = []

    var newPicture: PFObject?
    
    var gameItems: [PFObject] = []
    
    class func mainData() -> GameData {
        
        return _mainData
    }
    
    func refreshGameItems(completion: () -> () ){
        
        var feedQuery = PFQuery(className: "Picture")
        


        
        if let guessed = PFUser.currentUser()["guessed"] as? [String] {
            
            feedQuery.whereKey("objectId", notContainedIn: guessed)
            
        }
        
        feedQuery.includeKey("creator")
        feedQuery.whereKey("creator", notEqualTo: PFUser.currentUser())
        feedQuery.orderByDescending("createdAt")
        feedQuery.whereKeyExists("correctVenue")
        feedQuery.whereKeyExists("selectedVenues")
        
        
        feedQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if objects.count > 0 {
                
                self.gameItems = objects as! [PFObject]
                
            }
            
            completion()
            
        }
    }

    
}
