//
//  BeaconFinderViewController.swift
//  Trabalho
//
//  Created by Caio K Rodrigues on 5/7/15.
//  Copyright (c) 2015 ThePhodas. All rights reserved.
//

import UIKit
import CoreLocation
import AudioToolbox

let uuid = NSUUID(UUIDString: "1A8D83AD-44EC-42F9-A5A9-989B2477D800")
let identifier = "beacon.identifier"

class BeaconFinderViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var constraintNotification: NSLayoutConstraint!
    
    var beaconsFound: [Beacon] = [Beacon]()
    let locationManager = CLLocationManager()
    var beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: identifier)
    
    var closerBeacon: Beacon?
    
    var canDestroyTower = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var query = PFQuery(className: "Tower")
        
        query.whereKey("minor", equalTo: NSInteger(15))
        
        query.getFirstObjectInBackgroundWithBlock { (objects: PFObject?, error: NSError?) -> Void in
            
            if error == nil {
                println("Ta funfando")
            } else {
                println("Erro")
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.becomeFirstResponder()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.authorizationStatus() == .AuthorizedAlways {
            locationManager.startMonitoringForRegion(beaconRegion)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        locationManager.stopMonitoringForRegion(beaconRegion)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func logoutButton(sender: AnyObject) {
        
        PFUser.logOut()
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedAlways {
            locationManager.startMonitoringForRegion(beaconRegion)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        locationManager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        locationManager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        
        if (beacons.count > 0) {
            beaconsFound = beacons as! [Beacon]
            
            closerBeacon = getCloserBeacon(beaconsFound)
            
            if canDestroyTower == false && closerBeacon!.proximity.rawValue == 1 {
                canDestroyTower = true

                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))

                constraintNotification.constant = 0

                UIView.animateWithDuration(1.0) {
                    self.view.layoutIfNeeded()
                }
            } else if canDestroyTower == true && closerBeacon!.proximity.rawValue != 1 {
                canDestroyTower = false

                closerBeacon = nil

                constraintNotification.constant = -60

                UIView.animateWithDuration(1.0) {
                    self.view.layoutIfNeeded()
                }
            }
            
//            for beacon in beacons {
//                
//                if canDestroyTower == false && beacon.proximity.rawValue == 1 {
//                
//                    canDestroyTower = true
//                    
//                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
//                    
//                    constraintNotification.constant = 0
//                    
//                    UIView.animateWithDuration(1.0) {
//                        self.view.layoutIfNeeded()
//                    }
//                    
////                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
////                        
////                        self.constraintNotification.constant = -60
////                        
////                        UIView.animateWithDuration(1.0) {
////                            self.view.layoutIfNeeded()
////                        }
////                    }
//                    
//                } else if canDestroyTower == true && beacon.proximity.rawValue != 1 {
//                    canDestroyTower = false
//                    
//                    closerBeacon = nil
//                    
//                    constraintNotification.constant = -60
//                    
//                    UIView.animateWithDuration(1.0) {
//                        self.view.layoutIfNeeded()
//                    }
//                }
//            }
        }
    }
    
    
    //MARK: motion gesture methods
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {
        println("Motion began")
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if closerBeacon != nil {
            closerBeacon!.life! -= 10
            
            // executa atualizacao do beacon no parse
        }
    }
    
    
    
    
    
    
    
    
    
    func getCloserBeacon(beacons: [Beacon]) -> Beacon {
        
        var theCloserBeacon = Beacon()
        var proximity = 4
        
        for beacon in beacons {
            if beacon.proximity.rawValue < proximity && beacon.proximity.rawValue != 0 {
                theCloserBeacon = beacon
            }
        }
        
        return theCloserBeacon
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
