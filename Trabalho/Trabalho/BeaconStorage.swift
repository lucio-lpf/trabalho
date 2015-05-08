//
//  BeaconStorage.swift
//  Trabalho
//
//  Created by Caio K Rodrigues on 5/8/15.
//  Copyright (c) 2015 ThePhodas. All rights reserved.
//

import UIKit

class BeaconStorage {
    
    func getBeaconWithMinor(minor: NSInteger, blockSuccess: (PFObject!) -> Void, blockFailure: (NSError!) -> Void) {
        
        var query = PFQuery(className: "Tower")
        
        query.whereKey("minor", equalTo: minor)
        
        query.getFirstObjectInBackgroundWithBlock { (objects: PFObject?, error: NSError?) -> Void in
            
            if error == nil {
                blockSuccess(objects)
            } else {
                blockFailure(error)
            }
        }
    }
    
}
