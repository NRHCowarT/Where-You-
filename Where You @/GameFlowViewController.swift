//
//  GameFlow.swift
//  Where You @
//
//  Created by Nick Cowart on 3/30/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit

protocol dismissTheViewDelegate{
    
    func dismissViewController()
}

class GameFlowViewController: UIViewController {
    
    var delegate: dismissTheViewDelegate?

    @IBAction func continueButton(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate?.dismissViewController()
        
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
