//
//  ViewController.swift
//  Trabalho
//
//  Created by Lúcio Pereira Franco on 06/05/15.
//  Copyright (c) 2015 ThePhodas. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginConstraint: NSLayoutConstraint!
    @IBOutlet weak var userField: UITextField!
    
    @IBOutlet weak var passField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userField.text = "CaioTheDestroyer"
        passField.text = "123"
        
        navigationController!.navigationBar.translucent = true
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        
    }

    @IBAction func loginButton(sender: AnyObject) {
        var user = userField.text
        var pass = passField.text
        
        LoginStorage().loginWithUsername(user, pass: pass, blockSuccess: { () -> Void in
            self.performSegueWithIdentifier("loginOk", sender: nil)
        }) { (error) -> () in
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = error.description
            alert.addButtonWithTitle("Ok")
            alert.show()
        }
    }
    
//    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
//        self.view.endEditing(true)
//    }

    @IBAction func unwind(segue: UIStoryboardSegue) {}
    
}

