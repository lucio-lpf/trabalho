//
//  Beacon.swift
//  Trabalho
//
//  Created by Caio K Rodrigues on 5/8/15.
//  Copyright (c) 2015 ThePhodas. All rights reserved.
//

import CoreLocation

@objc(Beacon)

class Beacon {
    
    var parseId: NSString!
    var life: NSInteger!
    
    var beacon: CLBeacon!
}
