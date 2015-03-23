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
    
    var score:Int = 0
    
    var myFriends: NSArray = []
    
    var selectedVenues:[AnyObject] = []
    var correctVenue:[AnyObject] = []

    var newPicture: PFObject?
    
    var gameItems: [PFObject] = []
    
    // save photo ... creates a pfobject from selectedVenues and correctVenue ... also resets selectedVenues and correctVenue
    
    class func mainData() -> GameData {
        
        return _mainData
    }
   
    //   need to make sure only pulling down item that have all required info
    func refreshGameItems(completion: () -> () ){
        
        var feedQuery = PFQuery(className: "Picture")
        
        if let guessed = PFUser.currentUser()["guessed"] as? [String] {
            
            feedQuery.whereKey("objectId", notContainedIn: guessed)
            
        }
        
        feedQuery.includeKey("creator")
//        feedQuery.whereKey("creator", notEqualTo: PFUser.currentUser())
        feedQuery.whereKeyExists("correctVenue")
        feedQuery.whereKeyExists("selectedVenues")
        
        
        feedQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if objects.count > 0 {
                
                self.gameItems = objects as [PFObject]
                
//                println("STOP")
//                println(objects)
                
            }
            
            completion()
            
        }
    }

}
