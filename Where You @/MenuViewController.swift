//
//  MenuViewController.swift
//  Where You @
//
//  Created by Nick Cowart on 3/4/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBAction func takePhotoButton(sender: AnyObject) {
    }
    
    @IBAction func guessFriendsPlacesButton(sender: AnyObject) {
    }
    
    @IBAction func leaderBoardButton(sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // check if logged in
        
        // else present LoginVC
                
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if PFUser.currentUser() == nil{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("LoginVC") as LoginViewController
            self.presentViewController(vc, animated: true, completion: nil)
            //            self.presentViewController(vc, animated: true, completion: nil)
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
