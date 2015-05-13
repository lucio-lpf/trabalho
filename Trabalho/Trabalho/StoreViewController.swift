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
    
    
    var product_id = "com.app.Trabalho.catapult"
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        
    }
    
    @IBAction func selectPick(sender: AnyObject) {
        defaults.setValue(false, forKey: "weapon")
        
//        self.dismissViewControllerAnimated(true) {}
        self.performSegueWithIdentifier("backToWar", sender: nil)
    }
    @IBAction func selectCatapult(sender: UIButton) {
        var alert = UIAlertController(title: "Buy the Catapult", message: "Do you want to buy the Catapult?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .Default) { action -> Void in
            self.buyNonConsumable()
            })
        alert.addAction(UIAlertAction(title: "No", style: .Cancel) { action -> Void in
//                alert.dismissViewControllerAnimated(true, completion: nil)
            self.performSegueWithIdentifier("backToWar", sender: nil)
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
                if(defaults.valueForKey("weapon") as! Bool == false){
                println("Product Purchased");
            SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
            setWeapon()
            break;
            }
            case .Restored:
                println("Product Restored");
            setWeapon()
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
    
    func setWeapon() {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "weapon")
        //defaults.synchronize()
        
        self.performSegueWithIdentifier("backToWar", sender: nil)
//        self.dismissViewControllerAnimated(true) {}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}