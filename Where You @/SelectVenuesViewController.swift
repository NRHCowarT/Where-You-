//
//  SelectVenuesViewController.swift
//  Where You @
//
//  Created by Nick Cowart on 3/4/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit
import MapKit
//import CoreLocation


//var onceToken : dispatch_once_t = 0

class SelectVenuesViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate {

    var foundVenues:[AnyObject] = []
    
    var currentLocation: CLLocation?

    @IBOutlet weak var selectVenuesTableView: UITableView!
    
    @IBOutlet weak var selectVenuesMapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        selectVenuesTableView.delegate = self
        selectVenuesTableView.dataSource = self
        selectVenuesTableView.allowsMultipleSelection = true
        
        selectVenuesMapView.delegate = self
        selectVenuesMapView.mapType = MKMapType.Standard
        selectVenuesMapView.showsUserLocation = true

// ASK JO  //        self.navigationItem.backBarButtonItem  -> correctLocation.removeAllObjects
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        manager.requestWhenInUseAuthorization()
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//        manager.startUpdatingLocation()
        
//        println(currentLocation)
        zoomToLocation(currentLocation!)

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
//        manager.delegate = nil
    }
    
    func zoomToLocation(location: CLLocation){
       
        var span = MKCoordinateSpanMake(0.01, 0.01)
        var mapRegion = MKCoordinateRegionMake(location.coordinate, span)
        
        mapRegion.center = location.coordinate
        selectVenuesMapView.setRegion(mapRegion, animated: true)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return foundVenues.count
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("venueCell", forIndexPath: indexPath) as UITableViewCell
        
        let venue = foundVenues[indexPath.row] as [String:AnyObject]

        cell.textLabel?.text = venue["name"] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let venue = foundVenues[indexPath.row] as [String:AnyObject]
        
//        println(venue["name"])
        
        GameData.mainData().selectedVenues.append(venue)
        
        println(GameData.mainData().selectedVenues)
        
        if GameData.mainData().selectedVenues.count == 3 {
            
            GameData.mainData().newPicture?["selectedVenues"] = GameData.mainData().selectedVenues
            
            GameData.mainData().newPicture?.saveInBackground()
            
            GameData.mainData().newPicture =  nil
            GameData.mainData().selectedVenues = []
            GameData.mainData().correctVenue = []
            
          //  println(GameData.mainData().selectedVenues)
            
            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
    }

    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        GameData.mainData().selectedVenues.removeLast()
        println(GameData.mainData().selectedVenues)
    
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
