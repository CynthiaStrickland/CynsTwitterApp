//
//  TweetLogin.swift
//  CynsTwitterClone
//
//  Created by Cynthia Whitlatch on 2/8/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//

import UIKit
import Accounts
import Social

class TweetLogin {
    
    func loginTwitter(_ completionHandler : (String?, ACAccount?) -> (Void)) {
        
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccounts(with: accountType, options:nil,
            completion: {(success, error) in
                if success {
                    let twitterAccount = accountStore.accounts(with: accountType)
                        print("ACCESS GRANTED")
                    
                    if (twitterAccount?.count)! > 0 {
                        let myTwitterAccount = twitterAccount?.last as! ACAccount
                        let message = ["status" : "My post from iOS 10"]
                        let requestURL = URL(string: "https://api.twitter.com/1.1/statuses/update.json")
                        
                        let postRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, url: requestURL, parameters: message)
                        
                        postRequest?.account = myTwitterAccount
                        
                        postRequest?.perform(handler: { (responseDatat, urlResponse, error) in
                            if let err = error {
                                print("Error : \(err.localizedDescription)")
                            }
                                print("Twitter HTTP response \(String(describing: urlResponse?.statusCode))")
                        })
                    }
                }
            })
        }
    }

