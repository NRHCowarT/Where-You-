//
//  LoginViewController.swift
//  Where You @
//
//  Created by Nick Cowart on 3/4/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, dismissTheViewDelegate {
    
    @IBOutlet weak var backgroundView: UIImageView!
    
    @IBOutlet weak var logo: UIImageView!
    
    func dismissViewController() {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func loginButton(sender: AnyObject) {
        
        var permissions = ["public_profile", "user_friends"]
        
        PFFacebookUtils.logInWithPermissions(permissions, {
            (user: PFUser!, error: NSError!) -> Void in
            if let user = user {
                
                var request = FBRequest.requestForMe()
                request.startWithCompletionHandler { (connection, result, error) -> Void in
                    
                    if error == nil {
                        
                        let userData = result as NSDictionary
                        
                        println(userData)
                        
                        let facebookID = userData["id"] as String
                        let name = userData["name"] as String
                        
                        user["name"] = userData["name"] as String
                        user["avatar"] = "https://graph.facebook.com/\(facebookID)/picture?type=large&return_ssl_resources=1"
                        
                        user.saveInBackground()
                        
                    }
                    
                }
               
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("GameFlow") as GameFlowViewController
                vc.delegate = self
                self.presentViewController(vc, animated: true, completion: nil)

           }
            
        })
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
