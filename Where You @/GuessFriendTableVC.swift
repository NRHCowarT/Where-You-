//
//  GuessFriendTableViewController.swift
//  Where You @
//
//  Created by Nick Cowart on 3/4/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit

class GuessFriendTableVC: UITableViewController {

    @IBAction func menuButton(sender: AnyObject) {
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GameData.mainData().refreshGameItems { () -> () in
        
            self.tableView.reloadData()
        
        }
        
        var friendRequest = FBRequest.requestForMyFriends()
        
        friendRequest.startWithCompletionHandler { (connection, result, error) -> Void in
            
            if error == nil {
                
                
                let resultInfo = result as! NSDictionary
                
                GameData.mainData().myFriends = resultInfo["data"] as! NSArray
                
                self.tableView.reloadData()
                
            }
            
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return GameData.mainData().gameItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("guessFriendCell", forIndexPath: indexPath) as! GuessFriendsTableViewCell

        let picture = GameData.mainData().gameItems[indexPath.row]
        
        let creator = picture["creator"] as! PFUser
        
        if let url = NSURL(string: creator["avatar"] as! String) {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                
                if let data = NSData(contentsOfURL: url) {
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in

                        cell.fBProfilePic.image = UIImage(data: data)
                        
                    })
                    
                }
                
            })
            
            
        }
        
        cell.friendsName.text = creator["name"] as? String
        let date = picture.updatedAt

        let dateFormatter = NSDateFormatter()//3
        dateFormatter.dateStyle = .ShortStyle //5
        
        var dateString = dateFormatter.stringFromDate(date)

//        let timeFormatter = NSDateFormatter()
//        timeFormatter.timeStyle = .ShortStyle
//        var timeString = timeFormatter.stringFromDate(date)
      
        cell.timeAndDatePosted.text =  "\(dateString)"
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("GuessFriendsDetailVC") as! GuessFriendsDetailVC
        vc.picture = GameData.mainData().gameItems[indexPath.row]

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
