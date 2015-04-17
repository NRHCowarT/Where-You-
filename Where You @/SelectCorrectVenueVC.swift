//
//  SelectCorrectVenueVC.swift
//  Where You @
//
//  Created by Nick Cowart on 3/13/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit
import MapKit

class SelectCorrectVenueVC: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate, reloadPageDelegate, UINavigationControllerDelegate {
    
    var currentLocation: CLLocation?
    var foundVenues:[AnyObject] = []
    
    var customLVC: CustomLocationViewController = CustomLocationViewController()
    
    var manager = CLLocationManager()

    @IBOutlet weak var selectVenuesTableView: UITableView!
    
    @IBOutlet weak var selectVenuesMapView: MKMapView!
    
    func reloadTheView() {
        
        if GameData.mainData().correctVenue.count > 0 {
            
            GameData.mainData().newPicture?["correctVenue"] = GameData.mainData().correctVenue
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("SelectVenuesVC") as! SelectVenuesViewController
            
            vc.foundVenues = foundVenues
            vc.currentLocation = currentLocation
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        } else {
            
            manager.requestWhenInUseAuthorization()
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(GameData.mainData().correctVenue)
        
        selectVenuesTableView.delegate = self
        selectVenuesTableView.dataSource = self
        
        selectVenuesMapView.delegate = self
        selectVenuesMapView.mapType = MKMapType.Standard
        selectVenuesMapView.showsUserLocation = true
        
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
        
        if let location = locations.last as? CLLocation {
            
            self.foundVenues = FourSquareRequest.requestVenuesWithLocation(location)
            
            self.selectVenuesTableView.reloadData()
            
            zoomToLocation(location)
            
            currentLocation = location

        }
        
        manager.stopUpdatingLocation()
        manager.delegate = nil
        
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("venueCell", forIndexPath: indexPath) as! UITableViewCell
        
        let venue = foundVenues[indexPath.row] as! [String:AnyObject]
        
        cell.textLabel?.text = venue["name"] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let venue = foundVenues[indexPath.row] as! [String:AnyObject]
        
        GameData.mainData().correctVenue.append(venue)
        
        foundVenues.removeAtIndex(indexPath.row)
        
        println(GameData.mainData().correctVenue)
        
        if GameData.mainData().correctVenue.count > 0 {
            
            GameData.mainData().newPicture?["correctVenue"] = GameData.mainData().correctVenue

            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("SelectVenuesVC") as! SelectVenuesViewController
            
            vc.currentLocation = currentLocation
            vc.foundVenues = foundVenues
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }

    }
    
    
    
    @IBAction func addCustomLocationButton(sender: AnyObject) {
    
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("CustomLocationVC") as! CustomLocationViewController
        vc.delegate = self
        self.presentViewController(vc, animated: true, completion: nil)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

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
