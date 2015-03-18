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
    
    var selectedVenues:[AnyObject] = []
    var correctVenue:[AnyObject] = []

    var newPicture: PFObject?
    
    var gameItems: [PFObject] = []
    //    var myfeedItems: [PFObject] = []
    
    // save photo ... creates a pfobject from selectedVenues and correctVenue ... also resets selectedVenues and correctVenue
    
    class func mainData() -> GameData {
        
        return _mainData
    }
   
}
