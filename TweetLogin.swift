//
//  TweetLogin.swift
//  CynsTwitterClone
//
//  Created by Cynthia Whitlatch on 2/8/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//

import UIKit
import Accounts

typealias TwitterLoginCompletion = (String?, ACAccount?) -> ()

class TweetLogin {

    func getTimeLine(completion: TwitterLoginCompletion) {
        let account = ACAccountStore()
        let accountType = account.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        account.requestAccessToAccountsWithType(accountType, options: nil,
            completion: {(success: Bool, error: NSError!) -> Void in
                
                if success {
                    let arrayOfAccounts = account.accountsWithAccountType(accountType)
                    
                    if arrayOfAccounts.count > 0 {
                        let twitterAccount = arrayOfAccounts.last as! ACAccount
                        
                        let requestURL = NSURL(string:
                            "https://api.twitter.com/1.1/statuses/user_timeline.json")
                        
                        let parameters = ["screen_name" : "@techotopia",
                            "include_rts" : "0",
                            "trim_user" : "1",
                            "count" : "20"]
                        
                        let postRequest = SLRequest(forServiceType:
                            SLServiceTypeTwitter,
                            requestMethod: SLRequestMethod.GET,
                            URL: requestURL,
                            parameters: parameters)
                        
                        postRequest.account = twitterAccount
                        
                        postRequest.performRequestWithHandler(
                            {(responseData: NSData!,
                                urlResponse: NSHTTPURLResponse!,
                                error: NSError!) -> Void in
                                var err: NSError?
                                self.dataSource = NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.MutableLeaves, error: &err) as! [AnyObject]
                                
                                if self.dataSource.count != 0 {
                                    dispatch_async(dispatch_get_main_queue()) {
                                        self.tweetTableView.reloadData()
                                    }
                                }
                        })
                    }
                } else {
                    println("Failed to access account")
                }
        })
    }
}
