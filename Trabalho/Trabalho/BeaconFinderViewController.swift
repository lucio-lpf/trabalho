//
//  BeaconFinderViewController.swift
//  Trabalho
//
//  Created by Caio K Rodrigues on 5/7/15.
//  Copyright (c) 2015 ThePhodas. All rights reserved.
//

import UIKit

let uuid = NSUUID(UUIDString: "1A8D83AD-44EC-42F9-A5A9-989B2477D800")
let identifier = "beacon.identifier"

class BeaconFinderViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var constraintNotification: NSLayoutConstraint!
    
    var beaconsFound: [CLBeacon] = [CLBeacon]()
    let locationManager = CLLocationManager()
    var beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: identifier)
    
    var canDestroyTower = false {
        didSet {
            if self == true {
                constraintNotification.constant = 0
                
                UIView.animateWithDuration(1.0) {
                    self.view.layoutIfNeeded()
                }
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
                    
                    self.constraintNotification.constant = -100
                    
                    UIView.animateWithDuration(1.0) {
                        self.view.layoutIfNeeded()
                    }
                }
            } else {
                self.constraintNotification.constant = -100
                
                UIView.animateWithDuration(1.0) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedAlways {
            locationManager.startMonitoringForRegion(beaconRegion)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        locationManager.stopMonitoringForRegion(beaconRegion)
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        locationManager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        locationManager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        
        if (beacons.count > 0) {
            beaconsFound = beacons as! [CLBeacon]
            
            for beacon in beacons {
                
                println("Beacon found: minor = \(beacon.minor)")
                
                if beacon.proximity.rawValue == 1 {
                    canDestroyTower = true
                    
//                    constraintNotification.constant = 0
//                    
//                    UIView.animateWithDuration(1.0) {
//                        self.view.layoutIfNeeded()
//                    }
//                    
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
//                        
//                        self.constraintNotification.constant = -100
//                        
//                        UIView.animateWithDuration(1.0) {
//                            self.view.layoutIfNeeded()
//                        }
//                    }
                    
                } else {
                    canDestroyTower = false
                }
            }
        }
    }
    
}
