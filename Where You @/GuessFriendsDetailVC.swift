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
    
    var guessFriendsVenue: NSMutableArray = []
    
    // ask jo why in sit fit we used did set method to convert PFFile to UIImage
    
    @IBOutlet weak var guessFriendsPicture: UIImageView!
    
    @IBAction func venue1Button(sender: UIButton) {
        let correctLocation = picture?["correctVenue"].firstObject as NSDictionary
        let correctName = correctLocation["name"] as String
        if correctName == sender.titleLabel?.text {
            println("Correct")
        }
//        arc4random_uniform(array.count - 1)
        
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

        
        var venues = picture?["selectedVenues"] as NSArray
        for venue in  venues {
            guessFriendsVenue.addObject(venue["name"] as String)
            
        }
        
        println(picture)
        
        var correctLocation = picture?["correctVenue"].firstObject as NSDictionary
        guessFriendsVenue.addObject(correctLocation["name"] as String)
        
        
        
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
