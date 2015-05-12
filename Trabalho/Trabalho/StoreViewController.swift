//
//  StoreViewController.swift
//  Trabalho
//
//  Created by Lúcio Pereira Franco on 12/05/15.
//  Copyright (c) 2015 ThePhodas. All rights reserved.
//


import UIKit
import StoreKit

class ViewController: UIViewController, SKProductsRequestDelegate {
    override func viewDidLoad() {
    super.viewDidLoad()
    let productsRequest = SKProductsRequest(productIdentifiers: ["produto"])
    productsRequest.delegate = self;
    productsRequest.start();
    }
    func productsRequest(request: SKProductsRequest!, didReceiveResponse response: SKProductsResponse!) {
    println(response) // [SKProduct]
    }
}