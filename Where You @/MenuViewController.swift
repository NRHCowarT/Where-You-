//
//  MenuViewController.swift
//  Where You @
//
//  Created by Nick Cowart on 3/4/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit
import GameKit

class MenuViewController: UIViewController, GKGameCenterControllerDelegate {
    
    @IBAction func takePhotoButton(sender: AnyObject) {
    }
    
    @IBAction func guessFriendsPlacesButton(sender: AnyObject) {
    }
    
    @IBAction func leaderBoardButton(sender: AnyObject) {
        
        var leaderboardVC = GKGameCenterViewController()
        
        leaderboardVC.leaderboardIdentifier = "Where_You_At_Leaderboard"
        leaderboardVC.gameCenterDelegate = self
        
        presentViewController(leaderboardVC, animated: true, completion: nil)
        
        
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
        
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        println(PFUser.currentUser())
        
        if PFUser.currentUser() == nil {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("LoginVC") as LoginViewController
            self.presentViewController(vc, animated: true, completion: nil)
            //            self.presentViewController(vc, animated: true, completion: nil)
            
        } else {
            
            GKLocalPlayer.localPlayer().authenticateHandler = {(viewController: UIViewController!,error: NSError!) -> Void in
                
                if viewController != nil { self.presentViewController(viewController, animated: true, completion: nil) }
                
                println("authentication done = \(GKLocalPlayer.localPlayer().authenticated)")
                
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
}
