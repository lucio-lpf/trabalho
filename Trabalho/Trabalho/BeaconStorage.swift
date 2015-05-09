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
        
        let restantlifes: AnyObject? =  object.valueForKey("Life")
        // verificando se pode dar mais um hit
        if restantlifes as! NSNumber == 0 {
            
            let alert = UIAlertView(title: "Impossible", message: "The tower have alredy been destroyed.", delegate: nil, cancelButtonTitle: "Ok")
            alert.show()
        }
        else{
            // verificando se é o ultimo hit
        object.setValue(newLife, forKey: "Life")
            if newLife == 0{
                
                // atribuindo o nome do last hit pro tower destroyer
                let currentUser = PFUser.currentUser()
                let namedestroyer: AnyObject? = currentUser?.valueForKey("username")
                object.setValue(namedestroyer as! NSString, forKey: "destroyer")
                
                // da parabens pro carinha que destuiu
                let alert = UIAlertView(title: "Congratulations!!!", message: "You have been destroyed a tower.", delegate: nil, cancelButtonTitle: "Ok")
                alert.show()
            }
        object.save()
        }
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
