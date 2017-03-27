//
//  ViewController.swift
//  demo
//
//  Created by Vishal on 28/03/17.
//  Copyright © 2017 Self. All rights reserved.
//

import UIKit
import Accounts
import Social

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tt()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tt()  {
        let account = ACAccountStore()
        
        let accountType = account.accountType(
            withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        account.requestAccessToAccounts(with: accountType, options: nil,
                                        completion: {(success, error) in
                                            
                                            if success {
                                                let arrayOfAccounts =
                                                    account.accounts(with: accountType)
                                                
                                                if (arrayOfAccounts?.count)! > 0 {
                                                    print(arrayOfAccounts?.count)
                                                    let twitterAccount = arrayOfAccounts?.last as! ACAccount
                                                    let message = ["status" : "My first post from iOS 121212121212121"]
                                                    let requestURL = URL(string:
                                                        "https://api.twitter.com/1.1/statuses/update.json")
                                                    
                                                    let postRequest = SLRequest(forServiceType:
                                                        SLServiceTypeTwitter,
                                                                                requestMethod: SLRequestMethod.POST,
                                                                                url: requestURL,
                                                                                parameters: message)
                                                    
                                                    postRequest?.account = twitterAccount
                                                    
                                                    postRequest?.perform(handler: {(responseData, urlResponse,
                                                        error) in
                                                        
                                                        if let err = error {
                                                            print("Error : \(err.localizedDescription)")
                                                        }
                                                        print("Twitter HTTP response \(urlResponse?.statusCode)")
                                                    })
                                                }
                                                else {
                                                    print("error")
                                                }
                                            }
                                            if error != nil {
                                                print(error)
                                            }
        })

    }

}

