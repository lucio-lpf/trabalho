//
//  RegisterViewController.swift
//  Trabalho
//
//  Created by Lúcio Pereira Franco on 06/05/15.
//  Copyright (c) 2015 ThePhodas. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    @IBAction func registerButton(sender: AnyObject) {
        
        var newUser = PFUser()
        newUser.username = userField.text
        newUser.password = "123"
        newUser.email = emailField.text
        
        RegisterStorage().signUpWithUser(newUser, blockSuccess: { () -> Void in
            LoginStorage().loginWithUsername(newUser.username!, pass: newUser.password!, blockSuccess: { () -> Void in
                self.performSegueWithIdentifier("registerOk", sender: nil)
            }, blockFailure: { (error) -> () in
                let alertController = UIAlertView()
                alertController.title = "Error"
                alertController.message = error.description
                alertController.addButtonWithTitle("Ok")
                alertController.show()
            })
        }) { (error) -> Void in
            let alertController = UIAlertView()
            alertController.title = "Error"
            alertController.message = error.description
            alertController.addButtonWithTitle("Ok")
            alertController.show()
        }
    }
    
}