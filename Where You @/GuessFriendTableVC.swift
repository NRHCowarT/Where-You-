//
//  GuessFriendTableViewController.swift
//  Where You @
//
//  Created by Nick Cowart on 3/4/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit

class GuessFriendTableVC: UITableViewController {

    var myFriends: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var request = FBRequest.requestForMe()
        request.startWithCompletionHandler { (connection, result, error) -> Void in
            
            if error == nil {
                
                let userData = result as NSDictionary
                
                let facebookID = userData["id"] as String
                let name = userData["name"] as String
                
//                NSString *location = userData[@"location"][@"name"];
//                NSString *gender = userData[@"gender"];
//                NSString *birthday = userData[@"birthday"];
//                NSString *relationship = userData[@"relationship_status"];
//                
//                NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];

                
                
                
            }
            
        }
        
        var friendRequest = FBRequest.requestForMyFriends()
        
        friendRequest.startWithCompletionHandler { (connection, result, error) -> Void in
            
            if error == nil {
                
                
                let resultInfo = result as NSDictionary
                
                self.myFriends = resultInfo["data"] as NSArray
                
                println(self.myFriends)
                
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
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myFriends.count
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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
