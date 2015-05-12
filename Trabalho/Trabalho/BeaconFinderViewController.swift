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
    @IBOutlet weak var frameFim: UIView!
    @IBOutlet weak var frameInicio: UIView!
    @IBOutlet weak var weaponImage: UIImageView!
    @IBOutlet weak var text: UIImageView!
    
    var beaconsFound: [CLBeacon] = [CLBeacon]()
    let locationManager = CLLocationManager()
    var beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: identifier)
    
    var closerBeacon = Beacon()
    
    var canDestroyTower = false
    
    var vida = 100
    
    func animation () {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        BeaconStorage().getBeaconWithMinor(16, blockSuccess: { (object) -> Void in
//            let beaconLife = object.objectForKey("Life") as! NSInteger
//            
//            println("Beacon encontrado.")
//            println("Vida do beacon: \(beaconLife)")
//        }) { (error) -> Void in
//            println("Beacon nao encontrado")
//        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.becomeFirstResponder()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.authorizationStatus() == .AuthorizedAlways {
            locationManager.startMonitoringForRegion(beaconRegion)
        }
        
        
//        BeaconStorage().updateBeaconLideWithMinor(15, newLife: 0)
        
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
    
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
        locationManager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        
        if (beacons.count > 0) {
            beaconsFound = beacons as! [CLBeacon]
            
            closerBeacon.beacon = beaconsFound[0]
            
            if canDestroyTower == false && closerBeacon.beacon.proximity.rawValue == 1 {
                canDestroyTower = true
                
                BeaconStorage().getBeaconWithMinor(NSInteger(closerBeacon.beacon.minor), blockSuccess: { (object) -> Void in
                    
                    self.closerBeacon.parseId = object.valueForKey("objectId") as! NSString
                    self.closerBeacon.life = object.valueForKey("Life") as! NSInteger
                    
                }, blockFailure: { (error) -> Void in
                    
                    println(error.description)
                    
                })
//
//                
//                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))

                constraintNotification.constant = 0

                UIView.animateWithDuration(1.0) {
                    self.view.layoutIfNeeded()
                }
            } else if canDestroyTower == true && closerBeacon.beacon.proximity.rawValue != 1 {
                canDestroyTower = false

                constraintNotification.constant = -60

                UIView.animateWithDuration(1.0) {
                    self.view.layoutIfNeeded()
                }
            }
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
        if canDestroyTower == true {
            
            closerBeacon.life! -= 10
            
//            BeaconStorage().update
            
            BeaconStorage().updateBeaconLifeWithId(closerBeacon.parseId, newLife: closerBeacon.life, blockSuccess: { () -> Void in
                
                println("Success")
                
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                
            }, blockFailure: { (error) -> Void in
                println(error.description)
            })
        }
    }
    
}
