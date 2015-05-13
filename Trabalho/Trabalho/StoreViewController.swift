//
//  StoreViewController.swift
//  Trabalho
//
//  Created by Lúcio Pereira Franco on 12/05/15.
//  Copyright (c) 2015 ThePhodas. All rights reserved.
//

import UIKit
import Foundation
import Parse
import StoreKit


class StoreViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver{
    @IBOutlet weak var removeAdsBtn: UIButton!
    var product_id = "com.app.Trabalho.catapult"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        
    }
    
    @IBAction func removeBanners(sender: UIButton) {
        var alert = UIAlertController(title: "Remove Ads", message: "Do you want to remove the Ads?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .Default) { action -> Void in
            self.buyNonConsumable()
            })
        alert.addAction(UIAlertAction(title: "No", style: .Cancel) { action -> Void in
                alert.dismissViewControllerAnimated(true, completion: nil)
                })
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func buyNonConsumable() {
        
        println("About to fetch the products")
        // We check that we are allow to make the purchase.
        
        if (SKPaymentQueue.canMakePayments()) {
            var productID:NSSet = NSSet(object: self.product_id);
            var productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as Set<NSObject>);
            productsRequest.delegate = self;
            productsRequest.start();
            println("Fething Products");
        } else {
            println("can not make purchases");
        }
    }
    
    
    func productsRequest (request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        println("got the request from Apple")
        var count : Int = response.products.count
        if (count > 0) {
            var validProducts = response.products
            var validProduct: SKProduct = response.products[0] as! SKProduct
            if (validProduct.productIdentifier == self.product_id) {
                println(validProduct.localizedTitle)
                // println(validProduct.localizedDescription)
                //  println(validProduct.price)
                buyProduct(validProduct);
            } else {
                println(validProduct.productIdentifier)
            }
        } else {
            println("nothing")
        }
    }
    
    func buyProduct(product: SKProduct) {
        println("Sending the Payment Request to Apple");
        var payment = SKPayment(product: product)
        SKPaymentQueue.defaultQueue().addPayment(payment);
    }
    
    func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!)    {
        
        println("Received Payment Transaction Response from Apple");
        
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
            switch trans.transactionState {
            case .Purchased:
                println("Product Purchased");
            SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
            removeAds()
            break;
            case .Restored:
                println("Product Restored");
            removeAds()
            break;
            case .Failed:
                println("Purchased Failed");
            SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
            break;
            default:
                println("Purchased ????");
            break;
            }
            }
        }
    }
    
    func removeAds() {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "ads")
        //defaults.synchronize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}