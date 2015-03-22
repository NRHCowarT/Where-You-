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
    
    
    var picture: PFObject?
    
    var guessFriendsVenue:[AnyObject] = []
    
    var shuffleVenues: [AnyObject] = []
    
    // ask jo why in sit fit we used did set method to convert PFFile to UIImage
    
    @IBOutlet weak var guessFriendsPicture: UIImageView!
    
    @IBAction func venue1Button(sender: UIButton) {
        let correctLocation = picture?["correctVenue"].firstObject as NSDictionary
        let correctName = correctLocation["name"] as String
        if correctName == sender.titleLabel?.text {
            println("Correct")
        }
//        arc4random_uniform(array.count - 1)
        
    }
    
    @IBAction func venue2Button(sender: AnyObject) {
        
    }
    
    @IBAction func venue3Button(sender: AnyObject) {
    }
    
    @IBAction func venue4Button(sender: AnyObject) {
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
