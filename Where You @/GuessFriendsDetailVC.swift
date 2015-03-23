//
//  GuessFriendsDetailVC.swift
//  Where You @
//
//  Created by Nick Cowart on 3/4/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit
import Foundation

//func shuffle<C: MutableCollectionType where C.Index == Int>(var list: C) -> C {
//    let count = countElements(list)
//    for i in 0..<(count - 1) {
//        let j = Int(arc4random_uniform(UInt32(count - i))) + i
//        swap(&list[i], &list[j])
//    }
//    return list
//}

extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&self[i], &self[j])
        }
    }
}

class GuessFriendsDetailVC: UIViewController {
    
    var endDate: NSDate?
    
    var startDate: NSDate?
    
    var score:Int = 0
    
    var picture: PFObject?
    
    var guessFriendsVenue:[AnyObject] = []
    
    var shuffleVenues: [AnyObject] = []
    
    // ask jo why in sit fit we used did set method to convert PFFile to UIImage
    
    @IBOutlet weak var venue1: DesignalbeButton!
    
    @IBOutlet weak var venue2: DesignalbeButton!
    
    @IBOutlet weak var venue3: DesignalbeButton!
    
    @IBOutlet weak var venue4: DesignalbeButton!
        
    @IBOutlet weak var guessFriendsPicture: UIImageView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBAction func venue1Button(sender: UIButton) {
        
        endDate = NSDate()
        
        let correctLocation = picture?["correctVenue"].firstObject as NSDictionary
        let correctName = correctLocation["name"] as String
        if correctName == sender.titleLabel?.text {
            
            var guessTime = endDate?.timeIntervalSinceDate(startDate!)
            
            if guessTime <= 10 {
                
                score += 3000
            
            } else if guessTime <= 20 {
                
                score += 2000
                
            } else if guessTime <= 29 {
                
                score += 1000
                
            }
            
            let alert = UIAlertController(title: "Nice Guess. You're Right!!!", message: "You Just Earned \(score) Points!!!", preferredStyle: UIAlertControllerStyle.Alert)
            

            
            let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: { (action) -> Void in
                
                self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                println("boom")
                
                

            })
            
            score += PFUser.currentUser()["playerScore"] as Int
            PFUser.currentUser()["playerScore"] = score
            PFUser.currentUser().saveInBackground()
            
            alert.addAction(defaultAction)
            
            presentViewController(alert, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Wrong Answer! Better Luck Next Time.", message: "No Points For You!", preferredStyle: UIAlertControllerStyle.Alert)
            
            let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: { (action) -> Void in
                
                self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                println("boom")

            })
            
            alert.addAction(defaultAction)
            
            presentViewController(alert, animated: true, completion: nil)
            
        }
    
        var guessed = PFUser.currentUser()["guessed"] as? [String] ?? []
        
        guessed.append(picture!.objectId)
        
        PFUser.currentUser()["guessed"] = guessed
        
        PFUser.currentUser().saveInBackground()
        
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
//            shuffleVenues.addObject(venue["name"] as String)
            shuffleVenues.append(venue["name"]as String)
            
        }
        
        var correctLocation = picture?["correctVenue"].firstObject as NSDictionary
//        shuffleVenues.addObject(correctLocation["name"] as String)
        shuffleVenues.append(correctLocation["name"] as String)
        
        println(shuffleVenues)
        
        shuffleVenues.shuffle()
        
        println(shuffleVenues)
        
        for venues in shuffleVenues {
            
            shuffleVenues.removeAtIndex(0)
            guessFriendsVenue.append(venues)
            
        }
        
        println(guessFriendsVenue)
        
        venue1.setTitle("\(guessFriendsVenue[0])", forState: UIControlState.Normal)
        venue2.setTitle("\(guessFriendsVenue[1])", forState: UIControlState.Normal)
        venue3.setTitle("\(guessFriendsVenue[2])", forState: UIControlState.Normal)
        venue4.setTitle("\(guessFriendsVenue[3])", forState: UIControlState.Normal)
        
        

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        startDate = NSDate()
        
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
