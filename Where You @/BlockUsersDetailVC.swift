//
//  BlockUsersDetailVC.swift
//  Where You @
//
//  Created by Nick Cowart on 5/7/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit

class BlockUsersDetailVC: UIViewController {
    
    var friend = FBGraphObject()
    
    var blockedFriendsID = String()
    
    @IBOutlet weak var friendsImage: UIImageView!
    
    @IBOutlet weak var friendsName: UILabel!
    
    @IBOutlet weak var blockFriendSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blockFriendSwitch.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)

        println(friend)

        var name = friend.valueForKey("name")as! String
        var id = friend.valueForKey("id")as! String
        
        blockedFriendsID = id
        
        friendsName.text = name
        
        
        if let url = NSURL(string: "https://graph.facebook.com/\(blockedFriendsID)/picture?type=large&return_ssl_resources=1" as String) {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                
                if let data = NSData(contentsOfURL: url) {
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        self.friendsImage.image = UIImage(data: data)
                        
                    })
                    
                }
                
            })
            
            
        }
        
    }
    
    func stateChanged(switchState: UISwitch) {
        
        if switchState.on {
            
            var blocked = PFUser.currentUser()["blockedUsers"] as? [String] ?? []
            
            blocked.append(blockedFriendsID)
            
            PFUser.currentUser()["blockedUsers"] = blocked
            
            PFUser.currentUser().saveInBackground()
            
//            var feedQuery = PFUser.query()
//
//            feedQuery.whereKey("facebookId", equalTo: blockedFriendsID)
//            
//            feedQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//                
//                if objects.count > 0 {
//                    println(objects)
//                    var blockedUser = objects[0] as! PFUser
//                    
//                    var bblocked = blockedUser["blockedUsers"] as? [String] ?? []
//                    
//                    bblocked.append(PFUser.currentUser()["facebookId"] as! String)
//                    
//                    blockedUser["blockedUsers"] = bblocked
//                    
//                    blockedUser.saveInBackground()
//                }
//                
//                
//            }
            
            println("\(blockedFriendsID) blocked")
            
            
        } else {
            
            var unblocked = PFUser.currentUser()["blockedUsers"] as? [String] ?? []
            
            for index in 0...unblocked.count {
                
                var iD = unblocked[index]
                if iD == blockedFriendsID {
                    unblocked.removeAtIndex(index)
                    break
                }
            }
            
            PFUser.currentUser()["blockedUsers"] = unblocked
            
            PFUser.currentUser().saveInBackground()
            println("\(blockedFriendsID) unblocked")
            
            
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
