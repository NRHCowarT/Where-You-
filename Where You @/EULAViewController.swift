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
        
        println("accept")
    }
    @IBAction func declineTerms(sender: AnyObject) {
        
        println("decline")
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

//    func updateBlur() {
//        
//        blurEffect.alpha = 1.0
//        
//        UIView.animateWithDuration(12, animations: { () -> Void in
//            
//            self.blurEffect.alpha = 1.0
//            
//        })
//a
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
