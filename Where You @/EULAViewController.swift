//
//  EULAViewController.swift
//  Where You @
//
//  Created by Nick Cowart on 4/16/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit
import Foundation

class EULAViewController: UIViewController {

    @IBOutlet weak var blurEffect: UIVisualEffectView!
    
    @IBAction func acceptTerms(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "eulaAccepted")

    }
    
    @IBAction func declineTerms(sender: AnyObject) {
        
        let alert = UIAlertController(title: "You Must Agree to the Terms to Use The App!", message: "You're Gonna Miss Out!",preferredStyle: UIAlertControllerStyle.Alert)
        
        let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: { (action) -> Void in
            
        })
        
        alert.addAction(defaultAction)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        blurEffect.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
    
        blurEffect.alpha = 1.0
        
        //updateBlur()
    
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
