//
//  BeaconStorage.swift
//  Trabalho
//
//  Created by Caio K Rodrigues on 5/8/15.
//  Copyright (c) 2015 ThePhodas. All rights reserved.
//

class BeaconStorage {
    
    func getBeaconWithMinor(minor: NSInteger, blockSuccess: (PFObject!) -> Void, blockFailure: (NSError!) -> Void) {
        
        var query = PFQuery(className: "Tower")
        
        query.whereKey("minor", equalTo: minor)
        
        query.getFirstObjectInBackgroundWithBlock { (object: PFObject?, error: NSError?) -> Void in
            
            if error == nil {
                blockSuccess(object)
            } else {
                blockFailure(error)
            }
        }
    }
    
    func updateBeaconLifeWithMinor(minor: NSInteger, newLife: NSInteger, blockSuccess: () -> Void, blockFailure: (NSError!) -> Void) {
        
        getBeaconWithMinor(minor, blockSuccess: { (object) -> Void in
            
            object.setValue(newLife, forKey: "Life")
            object.saveInBackground()
            
            blockSuccess()
            
        }) { (error) -> Void in
            blockFailure(error)
        }
        
        let object = PFObject(withoutDataWithClassName: "Tower", objectId: "7OGe3xS3oJ")
        object.setValue(newLife, forKey: "Life")
        
        object.save()
        
    }
    
}
