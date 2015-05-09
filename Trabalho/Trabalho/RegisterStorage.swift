//
//  RegisterStorage.swift
//  Trabalho
//
//  Created by Caio K Rodrigues on 5/7/15.
//  Copyright (c) 2015 ThePhodas. All rights reserved.
//

class RegisterStorage {
    
    func signUpWithUser(user: PFUser, blockSuccess: () -> Void, blockFailure: (NSError) -> Void) {
        
        user.signUpInBackgroundWithBlock { (Bool: Bool, error: NSError?) -> Void in
            
            if error == nil {
                blockSuccess()
            } else {
                blockFailure(error!)
            }
        }
    }
    
}