//
//  MapViewController.swift
//  Trabalho
//
//  Created by Caio K Rodrigues on 5/12/15.
//  Copyright (c) 2015 ThePhodas. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapVIew: MKMapView!
    
    var beacons: [Beacon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BeaconStorage().getBeaconLocations({ (beaconsArray) -> Void in
            
            println("Success")
            
            for beacon in beaconsArray {
                self.beacons.append(beacon)
            }
            
            self.plotBeacons()
            
        }, blockFailure: { (error) -> Void in
            println(error.description)
        })
    }
    
    
    func plotBeacons() {
        
        for beacon in beacons {
            var annotation = BeaconLocationModel()
            
            annotation.title = "Destroyed by \(beacon.destroyer.username!)"
            annotation.coordinate.latitude = beacon.location.latitude
            annotation.coordinate.longitude = beacon.location.longitude
            
            mapVIew.addAnnotation(annotation)
        }
    }
    
}
