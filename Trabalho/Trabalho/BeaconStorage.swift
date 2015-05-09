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
    
    func updateBeaconLifeWithId(id: NSString, newLife: NSInteger, blockSuccess: () -> Void, blockFailure: (NSError!) -> Void) {
        
        let object = PFObject(withoutDataWithClassName: "Tower", objectId: id as String)
        object.setValue(newLife, forKey: "Life")
        
        object.save()
//        getBeaconWithMinor(minor, blockSuccess: { (object) -> Void in
//            
//            object.setValue(newLife, forKey: "Life")
//            object.save()
//            
//        }) { (error) -> Void in
//            blockFailure(error)
//        }
        
    }
    
}
