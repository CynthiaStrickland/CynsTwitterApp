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

//typealias TwitterLoginCompletion = (String?, ACAccount?) -> ()
//
//class TweetLogin {
//
//            //MAKE A SINGLETON
//    static let shared = TweetLogin()
//    private init() {}
//    
//    
//    func getTimeLine(completion: TwitterLoginCompletion) {
//        let accountStore = ACAccountStore()
//        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
//        var datasource = [Tweet]()
//
//        
//        accountStore.requestAccessToAccountsWithType(accountType, options: nil,
//            completion: {(success: Bool, error: NSError!) -> Void in
//                
//                if success {
//                    let arrayOfAccounts = accountStore.accountsWithAccountType(accountType)
//                    
//                    if arrayOfAccounts.count > 0 {
//                        let twitterAccount = arrayOfAccounts.last as! ACAccount
//                        
//                        let requestURL = NSURL(string:
//                            "https://api.twitter.com/1.1/statuses/user_timeline.json")   //URL for getting tweets
//                        
//                        let parameters = ["screen_name" : "@techotopia",
//                            "include_rts" : "0",
//                            "trim_user" : "1",
//                            "count" : "20"]
//                        
//                        let postRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: parameters)
//                        
//                        postRequest.account = twitterAccount
//                        
//                        postRequest.performRequestWithHandler( {(responseData: NSData!, urlResponse: NSHTTPURLResponse!, error: NSError!) -> Void in
//                            
//                            var err: NSError?
//                                self.dataSource = NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.MutableLeaves) as! [AnyObject]
//                            
//                            if self.dataSource.count != 0 {
//                                dispatch_async(dispatch_get_main_queue()) {
//                                    self.tweetTableView.reloadData()
//                                }
//                            }
//                        })
//                    }
//                } else {
//                    completion("Failed to access account", nil)
//                }
//        })
//    }
//}






