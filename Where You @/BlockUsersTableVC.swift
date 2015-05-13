//
//  BlockUsersTableVC.swift
//  Where You @
//
//  Created by Nick Cowart on 4/17/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit

class BlockUsersTableVC: UITableViewController {
    
    var friendsID:String?

    @IBAction func menuButton(sender: AnyObject) {
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBAction func blockUserSwitch(sender: AnyObject) {
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
                var friendRequest = FBRequest.requestForMyFriends()
        
                friendRequest.startWithCompletionHandler { (connection, result, error) -> Void in
        
                    if error == nil {
        
        
                        let resultInfo = result as! NSDictionary
        
                        GameData.mainData().myFriends = resultInfo["data"] as! NSArray
        
                        self.tableView.reloadData()
                        
                    }
                    
                }
        
//         addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
//        GameData.mainData().refreshGameUsers { () -> () in
//            
//            self.tableView.reloadData()
//            
//        }

        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func stateChanged(switchState: UISwitch) {
        
        if switchState.on {
            
            
            println("Switch On")
            
        } else {
            
            println("Switch Off")
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return GameData.mainData().myFriends.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("blockFriendCell", forIndexPath: indexPath) as! CustomTableViewCell
        
        let friend:AnyObject = GameData.mainData().myFriends[indexPath.row]
        
        let friendsID = friend["id"] as! String
        
        cell.friendsName.text = friend["name"] as? String
        
        if let url = NSURL(string: "https://graph.facebook.com/\(friendsID)/picture?type=large&return_ssl_resources=1" as String) {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                
                if let data = NSData(contentsOfURL: url) {
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        cell.fBProfilePic.image = UIImage(data: data)
                        
                    })
                    
                }
                
            })
            
            
        }
        
//        cell.blockUser.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
//        func stateChanged(switchState: UISwitch) {
//            
//            if switchState.on {
//                
////                let id = friend["id"]
//                println("Switch On")
//                
//            } else {
//                
//                println("Switch Off")
//                
//            }
//            
//        }
        
        
        
        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("BlockUsersDetailVC") as! BlockUsersDetailVC
        vc.friend = GameData.mainData().myFriends[indexPath.row] as! FBGraphObject
//        var cell = self.tableView(self.tableView, cellForRowAtIndexPath: indexPath) as! CustomTableViewCell
//        vc.image = cell.fBProfilePic
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
