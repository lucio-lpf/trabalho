//
//  ViewController.swift
//  Trabalho
//
//  Created by Lúcio Pereira Franco on 06/05/15.
//  Copyright (c) 2015 ThePhodas. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var userField: UITextField!
    
    @IBOutlet weak var passField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        }
        // Do any additional setup after loading the view, typically from a nib.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButton(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(userField, passField) { (PFUser?, NSError?) -> Void in
            <#code#>
        }
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {}

}

