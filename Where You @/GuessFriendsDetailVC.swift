//
//  GuessFriendsDetailVC.swift
//  Where You @
//
//  Created by Nick Cowart on 3/4/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit
import Foundation
import GameKit


extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&self[i], &self[j])
        }
    }
}

class GuessFriendsDetailVC: UIViewController, GKGameCenterControllerDelegate {
    
    let timeAllotted = 30
    
    var timer: NSTimer?
    
    var endDate: NSDate?
    
    var startDate: NSDate?
    
    var playerScore:Int = 0
    
    var picture: PFObject?
    
    var guessFriendsVenue:[AnyObject] = []
    
    var shuffleVenues: [AnyObject] = []
    
    
    @IBOutlet weak var venue1: DesignalbeButton!
    
    @IBOutlet weak var venue2: DesignalbeButton!
    
    @IBOutlet weak var venue3: DesignalbeButton!
    
    @IBOutlet weak var venue4: DesignalbeButton!
        
    @IBOutlet weak var guessFriendsPicture: UIImageView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBAction func flagContent(sender: AnyObject) {
        
        let alertController = UIAlertController(title: nil, message: "Would you like to report this post.", preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            
            // ...
        }
        alertController.addAction(cancelAction)
        
        let blockAction = UIAlertAction(title: "Report", style: .Destructive) { (action) in
            
            self.picture?["flagged"] = true
            self.picture?.saveInBackground()
            
            var guessed = PFUser.currentUser()["guessed"] as? [String] ?? []
            guessed.append(self.picture!.objectId)
            PFUser.currentUser()["guessed"] = guessed
            PFUser.currentUser().saveInBackground()
            
            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            
            println(action)
        }
        alertController.addAction(blockAction)
        
        self.presentViewController(alertController, animated: true) {
            
//            self.timer?.invalidate()
            // ...
        }
        
    }
    
    @IBAction func guessSelectionButton(sender: UIButton) {
        
        endDate = NSDate()
        
        let correctLocation = picture?["correctVenue"].firstObject as! NSDictionary
        let correctName = correctLocation["name"] as! String
        if correctName == sender.titleLabel?.text {
            
            var guessTime = endDate?.timeIntervalSinceDate(startDate!)
            
            
            
            if guessTime <= 10 {
                
                playerScore += 3000
            
            } else if guessTime <= 20 {
                
                playerScore += 2000
                
            } else if guessTime <= 29 {
                
                playerScore += 1000
                
            }
            
            timerLabel.hidden = true
            
            let alert = UIAlertController(title: "Nice Guess. You're Right!!!", message: "You Just Earned \(playerScore) Points!!!", preferredStyle: UIAlertControllerStyle.Alert)
            

            let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: { (action) -> Void in
                
                self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                println("boom")
                
            })
            
            playerScore += PFUser.currentUser()["playerScore"] as! Int
            PFUser.currentUser()["playerScore"] = playerScore
            PFUser.currentUser().saveInBackground()
            
            var score = GKScore(leaderboardIdentifier: "Where_You_At_Leaderboard")
            score.value = Int64(playerScore)
            GKScore.reportScores([score], withCompletionHandler: {(error) -> Void in
                
                
            })
            
            alert.addAction(defaultAction)
            
            presentViewController(alert, animated: true, completion: nil)
            
        } else {
            
            timerLabel.hidden = true
            
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
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerLabel.text = "\(timeAllotted)"
        
        self.navigationItem.hidesBackButton = true
        
        
        guessFriendsPicture.clipsToBounds = true
        blurView.clipsToBounds = true
        
        let friendsPicture = picture?["image"] as! PFFile
        
        friendsPicture.getDataInBackgroundWithBlock {
            
            (imageData: NSData!, error: NSError!) -> Void in
            
            if error == nil {
           
                let image = UIImage(data:imageData)
               
                self.guessFriendsPicture.image = image
                
            }
            
        }
        
        var venues = picture?["selectedVenues"] as! NSArray
       
        for venue in  venues {
            
            shuffleVenues.append(venue["name"]as! String)
            
        }
        
        var correctLocation = picture?["correctVenue"].firstObject as! NSDictionary
        
        shuffleVenues.append(correctLocation["name"] as! String)
        
//        println(shuffleVenues)
        
        shuffleVenues.shuffle()
        
//        println(shuffleVenues)
        
        for venues in shuffleVenues {
            
            shuffleVenues.removeAtIndex(0)
            guessFriendsVenue.append(venues)
            
        }
        
//        println(guessFriendsVenue)
        
        venue1.setTitle("\(guessFriendsVenue[0])", forState: UIControlState.Normal)
        venue2.setTitle("\(guessFriendsVenue[1])", forState: UIControlState.Normal)
        venue3.setTitle("\(guessFriendsVenue[2])", forState: UIControlState.Normal)
        venue4.setTitle("\(guessFriendsVenue[3])", forState: UIControlState.Normal)
        
        

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        startDate = NSDate()
        
        updateBlur()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "countDown", userInfo: nil, repeats: true)
        
    }
    
    func updateBlur() {
        
        blurView.alpha = 1.0
        
        UIView.animateWithDuration(12, animations: { () -> Void in
            
            self.blurView.alpha = 0
            
        })
        
    }
    
    func countDown() {
        var guessTime = (NSDate().timeIntervalSinceDate(startDate!))
        var displayTime = max(timeAllotted - Int(guessTime), 0)
        timerLabel.text = "\(displayTime)"
        
        if guessTime > 30 {
            
            var guessed = PFUser.currentUser()["guessed"] as? [String] ?? []
            
            guessed.append(picture!.objectId)
            
            PFUser.currentUser()["guessed"] = guessed
            
            PFUser.currentUser().saveInBackground()
        
            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
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
