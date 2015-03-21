//
//  SelectCorrectVenueVC.swift
//  Where You @
//
//  Created by Nick Cowart on 3/13/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class SelectCorrectVenueVC: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate, reloadPageDelegate {
    
    var currentLocation: CLLocation?
    var foundVenues:[AnyObject] = []
    
    var customLVC: CustomLocationViewController = CustomLocationViewController()    ///////
    
    var manager = CLLocationManager()
    // based off the array
    @IBOutlet weak var selectVenuesTableView: UITableView!
    
    @IBOutlet weak var selectVenuesMapView: MKMapView!
    
    func reloadTheView() {
        
        if GameData.mainData().correctVenue.count > 0 {
            
            GameData.mainData().newPicture?["correctVenue"] = GameData.mainData().correctVenue
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("SelectVenuesVC") as SelectVenuesViewController
            
            vc.foundVenues = foundVenues
            vc.currentLocation = currentLocation

            //            vc.manager = manager
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            // move on to next step pfobject of all info.save in background
            
        } else {
            
            manager.requestWhenInUseAuthorization()
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        customLVC.delegate = self
        
        selectVenuesTableView.delegate = self
        selectVenuesTableView.dataSource = self
        //selectVenuesTableView.allowsMultipleSelection = true
        
        
        
        
        
        selectVenuesMapView.delegate = self
        selectVenuesMapView.mapType = MKMapType.Standard
        selectVenuesMapView.showsUserLocation = true
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadTheView()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        manager.delegate = nil
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        //        dispatch_once(&onceToken) { () -> Void in
        
//        println(locations.last)
        
        if let location = locations.last as? CLLocation {
            // array
            self.foundVenues = FourSquareRequest.requestVenuesWithLocation(location)
            
            self.selectVenuesTableView.reloadData()
            
            zoomToLocation(location)
            
            currentLocation = location
            // request to foursquare for venues with location
        }
        
        //        }
        
        
        manager.stopUpdatingLocation()
        manager.delegate = nil
        
    }
    
    func zoomToLocation(location: CLLocation){
        //        MKCoordinateRegion mapRegion;
        //        mapRegion.center = mapView.userLocation.coordinate;
        //        mapRegion.span.latitudeDelta = 0.2;
        //        mapRegion.span.longitudeDelta = 0.2;
        //
        var span = MKCoordinateSpanMake(0.01, 0.01)
        var mapRegion = MKCoordinateRegionMake(location.coordinate, span)
        
        mapRegion.center = location.coordinate
        selectVenuesMapView.setRegion(mapRegion, animated: true)
        
        
//        println(location.coordinate)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // array count
        return foundVenues.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("venueCell", forIndexPath: indexPath) as UITableViewCell
        
        let venue = foundVenues[indexPath.row] as [String:AnyObject]
        
//        println(foundVenues)
        
        cell.textLabel?.text = venue["name"] as? String
        
//        cell.venueStatusButton.addTarget(self, action: "selectUsersVenue:", forControlEvents: UIControlEvents.TouchUpInside)
//        cell.venueStatusButton.tag = indexPath.row
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let venue = foundVenues[indexPath.row] as [String:AnyObject]
        
        GameData.mainData().correctVenue.append(venue)
        
        foundVenues.removeAtIndex(indexPath.row)
        
//        GameData.mainData().gameItems.append(GameData.mainData().correctVenue)
        
//        println(GameData.mainData().correctVenue)
        
        if GameData.mainData().correctVenue.count > 0 {
            
            GameData.mainData().newPicture?["correctVenue"] = GameData.mainData().correctVenue

            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("SelectVenuesVC") as SelectVenuesViewController
            
//            println(currentLocation)
//            println("where")
            vc.currentLocation = currentLocation
            vc.foundVenues = foundVenues
            self.navigationController?.pushViewController(vc, animated: true)
            
            // move on to next step pfobject of all info.save in background
           
        
            
        }

    }
    
    
    
    @IBAction func addCustomLocationButton(sender: AnyObject) {
    
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("CustomLocationVC") as CustomLocationViewController
        vc.delegate = self
        self.presentViewController(vc, animated: true, completion: nil)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }

}
