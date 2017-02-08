//
//  TwitterService.swift
//  CynsTwitterClone
//
//  Created by Cynthia Whitlatch on 2/8/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//


import Foundation
import Accounts
import Social

class TwitterService {
    static let sharedService = TwitterService()
    var account : ACAccount?
    var user : User?
    
//    class func tweetsFromHomeTimeline(_ completion: (String?, [Tweet]?) -> () ) {
//        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, url: URL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json"), parameters: nil)
//        if let account = self.sharedService.account {
//            request?.account = account
//            request?.perform { (data, response, error) -> Void in
//                if let error = error {
//                    return
//                }
//                switch response?.statusCode {
//                case 200..<299:
//                    let tweets = TweetJSONParser.TweetFromJSONData(data!)
//                    completion(nil, tweets)
//                case 400...499:
//                    print(response?.statusCode)
//                    completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json returned status code \(String(describing: response?.statusCode)) [user input error].", nil)
//                case 500...599:
//                    completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json returned status code \(String(describing: response?.statusCode)) [server side error].", nil)
//                default:
//                    completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json returned status code \(String(describing: response?.statusCode)) [unknown error].", nil)
//                }
//            }
//        }
//    }
    
    class func getAuthUser(_ completion:(String?, User?)-> ()) {
        
        let request = SLRequest(forServiceType:
                    SLServiceTypeTwitter,
                    requestMethod: SLRequestMethod.GET,
                    url: URL(string: "https://api.twitter.com/1.1/account/verify_credentials.json"),
                    parameters: nil)
        
        if let account = self.sharedService.account {
            request?.account = account
            request?.perform { (data, response, error) -> Void in
                
                if let error = error {
                    print(error)
                    return
                }
                
                if let data = NSString(data: data!, encoding: String.Encoding.utf8) {
                    print(data)
                }
                
                switch response?.statusCode {
                case 200...299:
                    do {
                        if let userData = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject] {
                            if let user = TweetJSONParser.userFromData(userData){
                                completion(nil, user); return
                            }
                            completion("ERROR: unable create user object from de-serialized JSON object", nil)
                        }
                    } catch {
                        completion("ERROR: NSJSONSerialization.JSONObjectWithData was unable to de-serialize JSON object.", nil)
                    }
                case 400...499:
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json returned status code \(String(describing: response?.statusCode)) [user input error].", nil)
                case 500...599:
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json returned status code \(String(describing: response?.statusCode)) [server side error].", nil)
                default:
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json returned status code \(String(describing: response?.statusCode)) [unknown error].", nil)
                }
            }
        }
    }
}

