//
//  GuessFriendsDetailVC.swift
//  Where You @
//
//  Created by Nick Cowart on 3/4/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit

class GuessFriendsDetailVC: UIViewController {
    
    var picture: PFObject?
    
    var guessFreindsVenue = []
    
    // ask jo why in sit fit we used did set method to convert PFFile to UIImage
    
    @IBOutlet weak var guessFriendsPicture: UIImageView!
    
    @IBAction func venue1Button(sender: AnyObject) {
    }
    
    @IBAction func venue2Button(sender: AnyObject) {
    }
    
    @IBAction func venue3Button(sender: AnyObject) {
    }
    
    @IBAction func venue4Button(sender: AnyObject) {
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        let friendsPicture = picture?["image"] as PFFile
        
        friendsPicture.getDataInBackgroundWithBlock {
            
            (imageData: NSData!, error: NSError!) -> Void in
            
            if error == nil {
           
                let image = UIImage(data:imageData)
                self.guessFriendsPicture.image = image
                
            }
            
        }

            println(picture)
        
        var incorrectVenues = NSMutableArray()
        var venues = picture?["selectedVenues"] as NSArray
        for venue in  venues {
            incorrectVenues.addObject(venue["name"] as String)
            
            println(incorrectVenues)
            
        }
        
        
//            let selectedVenues = picture?["selectedVenues"] as [NSArray]
//            let incorrectVenues = selectedVenues.valueForKey("name") as [String:AnyObject]
//        println(incorrectVenues)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
