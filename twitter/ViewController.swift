//
//  ViewController.swift
//  twitter
//
//  Created by Vishal on 27/03/17.
//  Copyright © 2017 Self. All rights reserved.
//

import UIKit
import Social
import Accounts

class ViewController: UIViewController {

    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tt()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tt() {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(
            withAccountTypeIdentifier: ACAccountTypeIdentifierFacebook)
        
        let postingOptions = [ACFacebookAppIdKey:
            "APP ID",
                              ACFacebookPermissionsKey: ["email"],
                              ACFacebookAudienceKey: ACFacebookAudienceFriends] as [String : Any]
       
        accountStore.requestAccessToAccounts(with: accountType,
                                             options: postingOptions as [NSObject : AnyObject]) {
                                                success, error in
                                                if success {
                                                    print(success)
                                                    let options = [ACFacebookAppIdKey:
                                                        "APP ID",
                                                                   ACFacebookPermissionsKey: ["publish_actions"],
                                                                   ACFacebookAudienceKey: ACFacebookAudienceEveryone] as [String : Any]
                                                    
                                                    accountStore.requestAccessToAccounts(with: accountType,
                                                                                         options: options as [NSObject : AnyObject]) {
                                                                                            success, error in
                                                                                            if success {
                                                                                                var accountsArray =
                                                                                                    accountStore.accounts(with: accountType)
                                                                                                
                                                                                                if (accountsArray?.count)! > 0 {
                                                                                                    let facebookAccount = accountsArray?[0]
                                                                                                        as! ACAccount
                                                                                                    print(accountsArray?.count)
                                                                                                    var parameters = Dictionary<String, AnyObject>()
                                                                                                    parameters["access_token"] =
                                                                                                        facebookAccount.credential.oauthToken
                                                                                                        as AnyObject?
                                                                                                    parameters["message"] = "My first Facebook post from iOS 1021211231212311213" as AnyObject?
                                                                                                    
                                                                                                    let feedURL = URL(string:
                                                                                                        "https://graph.facebook.com/me/feed")
                                                                                                    
                                                                                                    let postRequest = SLRequest(forServiceType:
                                                                                                        SLServiceTypeFacebook,
                                                                                                                                requestMethod: SLRequestMethod.POST,
                                                                                                                                url: feedURL,
                                                                                                                                parameters: parameters)
                                                                                                    print(parameters)
                                                                                                    postRequest?.perform(handler: {(responseData,
                                                                                                        urlResponse, error) in
                                                                                                        
                                                                                                        print("Facebook HTTP response \(urlResponse?.statusCode)")
                                                                                                    })
                                                                                                }
                                                                                            } else {
                                                                                                print("Access denied")
                                                                                                print(error?.localizedDescription)
                                                                                            }
                                                    }
                                                } else {
                                                    print("Access denied")
                                                    print(error?.localizedDescription)
                                                }
        }
    }

}

