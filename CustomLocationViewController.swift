//
//  CorrectLocationViewController.swift
//  Where You @
//
//  Created by Nick Cowart on 3/14/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit

protocol reloadPageDelegate {
    
    func reloadTheView()    ////
}

class CustomLocationViewController: UIViewController {
    
    var delegate: reloadPageDelegate?   /////
    
    @IBOutlet weak var customLocationTextField: UITextField!
    
    
    @IBAction func saveCustomLocationButton(sender: AnyObject) {
        
        if customLocationTextField.text == ""{
        
            let alert = UIAlertController(title: "Enter Your Location", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            
            let defaultAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
            alert.addAction(defaultAction)
            
            presentViewController(alert, animated: true, completion: nil)
        
        }else{
        
        if let customLocation = customLocationTextField.text {
            
            if let locationName = ["name" : "\(customLocation)"] as Dictionary? {
                
            GameData.mainData().correctVenue.append(locationName)
                
           //     println(GameData.mainData().correctVenue)
                
                dismissViewControllerAnimated(true, completion: nil)

                delegate?.reloadTheView()   /////
                
                println(GameData.mainData().correctVenue)

                }
         
            }

        }
            
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
