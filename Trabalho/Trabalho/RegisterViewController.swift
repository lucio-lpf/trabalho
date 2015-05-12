//
//  RegisterViewController.swift
//  Trabalho
//
//  Created by Lúcio Pereira Franco on 06/05/15.
//  Copyright (c) 2015 ThePhodas. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var signUpConstraint: NSLayoutConstraint!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        self.signUpConstraint.constant = keyboardFrame.size.height + 20
        self.bottomConstraint.constant = 10
        self.topConstraint.constant = -20
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        self.signUpConstraint.constant = 154
        self.bottomConstraint.constant = 54
        self.topConstraint.constant = 15
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func registerButton(sender: AnyObject) {
        
        var newUser = PFUser()
        newUser.username = userField.text
        newUser.password = "123"
        newUser.email = emailField.text
        
        navigationController!.navigationBar.translucent = true
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        
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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
}