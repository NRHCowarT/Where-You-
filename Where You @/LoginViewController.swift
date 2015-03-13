//
//  LoginViewController.swift
//  Where You @
//
//  Created by Nick Cowart on 3/4/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    //
    //    - (IBAction)loginButtonTouchHandler:(id)sender  {
    //    // Set permissions required from the facebook user account
    //    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    //
    //    // Login PFUser using Facebook
    //    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
    //    [_activityIndicator stopAnimating]; // Hide loading indicator
    //
    //    if (!user) {
    //    NSString *errorMessage = nil;
    //    if (!error) {
    //    NSLog(@"Uh oh. The user cancelled the Facebook login.");
    //    errorMessage = @"Uh oh. The user cancelled the Facebook login.";
    //    } else {
    //    NSLog(@"Uh oh. An error occurred: %@", error);
    //    errorMessage = [error localizedDescription];
    //    }
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error"
    //    message:errorMessage
    //    delegate:nil
    //    cancelButtonTitle:nil
    //    otherButtonTitles:@"Dismiss", nil];
    //    [alert show];
    //    } else {
    //    if (user.isNew) {
    //    NSLog(@"User with facebook signed up and logged in!");
    //    } else {
    //    NSLog(@"User with facebook logged in!");
    //    }
    //    [self _presentUserDetailsViewControllerAnimated:YES];
    //    }
    //    }];
    //
    //    [_activityIndicator startAnimating]; // Show loading indicator until login is finished
    //    }
    
    @IBAction func loginButton(sender: AnyObject) {
        
        //set permission required from the facebook user account
        var permissions = ["user_about_me", "user_relationships", "user_birthday", "user_location"]
        
//        // Login PFUser using Facebook
//        PFFacebookUtils.logInWithPermissions(permissionArray, block: { (user, error) -> Void in
//            
//            if (user == nil) {
//                if (error == nil) {
//                    println("User cancelled FB login")
//                }else{
//                    println("FaceBook login error: \(error)")
//                }
//                
//                var alert = UIAlertController(title: "Log In Error", message: "\(error)", preferredStyle: UIAlertControllerStyle.Alert)
//                
//                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel, handler: nil))
//                
//                self.presentViewController(alert, animated: true, completion: nil)
//                
//            } else if user.isNew {
//                println("User signed up and logged in with Facebook")
//                
//            } else {
//                println("User logged in via Facebook")
//                
//            }
//            
//            
//        })
      
        PFFacebookUtils.logInWithPermissions(permissions, {
            (user: PFUser!, error: NSError!) -> Void in
            if let user = user {
                if user.isNew {
                    println("User signed up and logged in through Facebook!")
                } else {
                    println("User logged in through Facebook!")
                }
                self.dismissViewControllerAnimated(true, completion: nil)

            } else {
                println("Uh oh. The user cancelled the Facebook login.")
            }
        })
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
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
