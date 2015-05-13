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




￼








//    
//    //    var list = [SKProduct]()
//    
//    var product_id: NSString?;
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        println(PFUser.currentUser())
//        
//        product_id = "com.app.Trabalho.catapult"
//        
//        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
//    }
//    
//    func buyProduct(product: SKProduct){
//        println("Sending the Payment Request to Apple");
//        var payment = SKPayment(product: product)
//        SKPaymentQueue.defaultQueue().addPayment(payment);
//        
//    }
//    
//    
//    func productsRequest(request: SKProductsRequest!, didReceiveResponse response: SKProductsResponse!) {
//        println(response) // [SKProduct]
//        
//        var count : Int = response.products.count
//        if (count > 0) {
//            var validProducts = response.products
//            var validProduct: SKProduct = response.products[0] as! SKProduct
//            if (validProduct.productIdentifier == self.product_id) {
//                println(validProduct.localizedTitle)
//                println(validProduct.localizedDescription)
//                println(validProduct.price)
//                buyProduct(validProduct);
//            } else {
//                println(validProduct.productIdentifier)
//            }
//        } else {
//            println("nothing")
//        }
//    }
//    
//    func request(request: SKRequest!, didFailWithError error: NSError!) {
//        println("Error Fetching product information");
//    }
//    
//    
//    func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!) {
//        for transaction:AnyObject in transactions {
//            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction {
//                switch trans.transactionState {
//                    
//                case .Purchasing:
//                    println("Purchasing Product")
//                    break
//                    
//                case .Failed:
//                    println("Purchase Failed")
//                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
//                    break
//                    
//                case .Restored:
//                    println("Product Restored")
//                    break
//                    
//                case .Purchased:
//                    println("Product Purchased")
//                    addKeys() // função que libera as keys pro usuáro depois que ele comprou o produto
//                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
//                    break
//                    
//                default:
//                    break
//                };
//            }
//        }
//    }
//    
//    
//    @IBAction func BuyButtonPressed(sender: AnyObject) {
//        
//        if (SKPaymentQueue.canMakePayments()) {
//            
//            var productID:NSSet = NSSet(object: self.product_id!);
//            var productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as Set<NSObject>);
//            productsRequest.delegate = self;
//            productsRequest.start();
//            println("Fething Products");
//            
//        } else {
//            println("can't make purchases");
//        }
//        
//    }
//    
//    
//    func addKeys (){
//        
//        var query = PFQuery(className: "_User")
//        query.whereKey("objectId", equalTo: PFUser.currentUser()!.objectId!)
//        
//        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
//            
//            if error == nil {
//                println("Successfully retrieved \(objects!.count) scores.")
//                // Do something with the found objects
//                
//                
//                if let objects = objects as? [PFObject] {
//                    for object in objects {
//                        
//                        println(object.objectId)
//                        println("Ele comprou 10 chaves \\o/")
//                        object["keys"] = object["keys"] as! NSInteger + 10
//                        object.saveEventually()
//                        
//                    }
//                } else {
//                    println("Usuário não encontrado")
//                }
//                
//                
//            } else {
//                // Log details of the failure
//                println("Error: \(error!) \(error!.userInfo!)")
//            }
//        }
//        
//    }
//    
//}
//
//
//
//
//
