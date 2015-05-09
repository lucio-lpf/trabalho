//
//  LoginStorage.swift
//  Trabalho
//
//  Created by Caio K Rodrigues on 5/7/15.
//  Copyright (c) 2015 ThePhodas. All rights reserved.
//

class LoginStorage {
    
    func loginWithUsername(user: String, pass: String, blockSuccess: () -> Void, blockFailure: (NSError) -> ()) {
        
        PFUser.logInWithUsernameInBackground(user, password:pass) { (user: PFUser?, error: NSError?) -> Void in
            
            if user != nil {
                blockSuccess()
            } else {
                blockFailure(error!)
            }
        }
    }
    
}
