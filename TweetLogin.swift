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
    
    func loginTwitter(_ completionHandler : @escaping (String?, ACAccount?) -> (Void)) {
    let accountStore = ACAccountStore()
    let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
    accountStore.requestAccessToAccounts(with: accountType, options: nil) { (granted, error) -> Void in
        if let _ = error {
            completionHandler("Please sign in", nil)
            return
        } else {
            if granted {
                if let account = accountStore.accounts(with: accountType).first as? ACAccount {
                    completionHandler(nil, account)
                    print("ACCESS GRANTED")
                }
            } else {
                completionHandler("This app requires twitter access",nil)
            }
            
            }
        }
    }
}






