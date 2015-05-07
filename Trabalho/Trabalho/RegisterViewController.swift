//
//  RegisterViewController.swift
//  Trabalho
//
//  Created by Lúcio Pereira Franco on 06/05/15.
//  Copyright (c) 2015 ThePhodas. All rights reserved.
//

import Foundation
import Parse

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    @IBAction func registerButton(sender: AnyObject) {
        
        var newUser = PFUser()
        newUser.username = userField.text
        newUser.password = "123"
        newUser.email = emailField.text
        
        newUser.signUpInBackgroundWithBlock { (Bool:Bool, error:NSError?) -> Void in
            if (error == nil){
                self.navigationController?.popToRootViewControllerAnimated(true)
                let alertController = UIAlertView()
                alertController.title = "Login Successful"
                alertController.message = "Come back and do your login!"
                alertController.addButtonWithTitle("Ok")
                alertController.show()
            }
            else{
                let alertController = UIAlertView()
                alertController.title = "Erro"
                alertController.message = error?.description
                alertController.addButtonWithTitle("Ok")
                alertController.show()
                
            }
            
        }
    }
}