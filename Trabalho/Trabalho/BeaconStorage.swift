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
        
        if newLife < 0 {
            let alert = UIAlertView(title: "Impossible!", message: "The tower had alredy been destroyed.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        } else {
            let object = PFObject(withoutDataWithClassName: "Tower", objectId: id as String)
            object.setValue(newLife, forKey: "Life")
            
            object.saveInBackground()
            
            if newLife == 0 {
                
                // atribuindo o id do last hit pro tower destroyer
                let currentUser = PFUser.currentUser()
                let nameDestroyer = currentUser!.valueForKey("id") as! NSString
                object.setValue(nameDestroyer, forKey: "destroyer")
                
                // da parabens pro carinha que destuiu
                let alert = UIAlertView(title: "Congratulations!!!", message: "You have been destroyed a tower.", delegate: nil, cancelButtonTitle: "Ok")
                alert.show()
            }
        }
    }
    
    func updateBeaconLideWithMinor(minor: NSInteger, newLife: NSInteger) {
        
        
        if newLife < 0 {
            let alert = UIAlertView(title: "Impossible!", message: "The tower had alredy been destroyed.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        } else {
                
            getBeaconWithMinor(minor, blockSuccess: { (object) -> Void in
                
                object.setValue(newLife, forKey: "Life")
                
                let currentUser = PFUser.currentUser()
                
                if newLife == 0 {
                    let nameDestroyer = currentUser!.objectId
    //                    let nameDestroyer = currentUser!.valueForKey("id") as! NSString
                    object.setValue(PFUser.currentUser(), forKey: "destroyer")
                    
                    // da parabens pro carinha que destuiu
                    let alert = UIAlertView(title: "Congratulations!!!", message: "You have destroyed a tower.", delegate: nil, cancelButtonTitle: "Ok")
                    alert.show()
                }
                
                object.saveInBackground()
                
                }) { (error) -> Void in
                    println(error.description)
            }
        }
        
    }

    
    
    
    
    
}
