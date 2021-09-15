//
//  Store.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/05/07.
//
import SwiftyStoreKit

class StoreClass {

    func get_info()
    {
        SwiftyStoreKit.retrieveProductsInfo(["com.KigyoClub.WaterCheckerProt.autoSubscription.plan1"]) { result in
            if let product = result.retrievedProducts.first {
                let priceString = product.localizedPrice!
                print("Product: \(product.localizedDescription), price: \(priceString)")
            }
            else if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
            }
            else {
                print("Error: \(result.error)")
            }
        }
    }

    func purchace()
    {
        //購入コード
        SwiftyStoreKit.purchaseProduct("com.KigyoClub.WaterCheckerProt.autoSubscription.plan1", quantity: 1, atomically: false) { result in
            switch result {
            case .success(let product):
                // fetch content from your server, then:
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
                print("Purchase Success: \(product.productId)")
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                default: print((error as NSError).localizedDescription)
                }
            }
        }
    }
    
    func restore()
    {
        SwiftyStoreKit.restorePurchases(atomically: false)
        { results in
            if results.restoreFailedPurchases.count > 0
            {
                print("Restore Failed: \(results.restoreFailedPurchases)")
            }
            else if results.restoredPurchases.count > 0
            {
                for purchase in results.restoredPurchases
                {
                    // fetch content from your server, then:
                    if purchase.needsFinishTransaction
                    {
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                }
                print("Restore Success: \(results.restoredPurchases)")
            }
            else
            {
                print("Nothing to Restore")
            }
        }
    }
    
    func get_receipt()
    {
        SwiftyStoreKit.fetchReceipt(forceRefresh: true) { result in
            switch result {
            case .success(let receiptData):
                let encryptedReceipt = receiptData.base64EncodedString(options: [])
                print("Fetch receipt success:\n\(encryptedReceipt)")
            case .error(let error):
                print("Fetch receipt failed: \(error)")
            }
        }
    }
    //自動更新型のレシート検証と継続中か期限切れかのチェック
    func check_receipt()
    {
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "52c9947da30048d8a5752be952f21b10")
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let productId = "com.KigyoClub.WaterCheckerProt.autoSubscription.plan1"
                // Verify the purchase of a Subscription
                let purchaseResult = SwiftyStoreKit.verifySubscription(
                    ofType: .autoRenewable, // or .nonRenewing (see below)
                    productId: productId,
                    inReceipt: receipt)
                switch purchaseResult {
                case .purchased(let expiryDate, let items):
                    //購入済み
                    print("\(productId) is valid until \(expiryDate)\n\(items)\n")
                    UserDefaults.standard.setValue(2, forKey: "purchace")
                    
                case .expired(let expiryDate, let items):
                    //期限切れ
                    print("\(productId) is expired since \(expiryDate)\n\(items)\n")
                    UserDefaults.standard.setValue(1, forKey: "purchace")
                case .notPurchased:
                    //未購入
                    print("The user has never purchased \(productId)")
                    UserDefaults.standard.setValue(0, forKey: "purchace")
                }

            case .error(let error):
                print("Receipt verification failed: \(error)")
            }
        }
    }


}
