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
    
    class func tweetsFromHomeTimeline(completion: (String?, [Tweet]?) -> () ) {
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json"), parameters: nil)
        if let account = self.sharedService.account {
            request.account = account
            request.performRequestWithHandler { (data, response, error) -> Void in
                if let error = error {
                    print(error.description)
                    completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json could not be completed.", nil); return
                }
                switch response.statusCode {
                case 200...299:
                    let tweets = TweetJSONParser.TweetFromJSONData(data)
                    completion(nil, tweets)
                case 400...499:
                    print(response.description)
                    completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json returned status code \(response.statusCode) [user input error].", nil)
                case 500...599:
                    completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json returned status code \(response.statusCode) [server side error].", nil)
                default:
                    completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json returned status code \(response.statusCode) [unknown error].", nil)
                }
            }
        }
    }
    
    class func getAuthUser(completion: (String?, User?)-> ()) {
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        
        if let account = self.sharedService.account {
            request.account = account
            request.performRequestWithHandler { (data, response, error) -> Void in
                
                if let error = error {
                    print(error)
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json could not be completed.", nil); return
                }
                
                if let data = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    print(data)
                }
                
                switch response.statusCode {
                case 200...299:
                    do {
                        if let userData = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String : AnyObject] {
                            if let user = TweetJSONParser.userFromData(userData){
                                completion(nil, user); return
                            }
                            completion("ERROR: unable create user object from de-serialized JSON object", nil)
                        }
                    } catch {
                        completion("ERROR: NSJSONSerialization.JSONObjectWithData was unable to de-serialize JSON object.", nil)
                    }
                case 400...499:
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json returned status code \(response.statusCode) [user input error].", nil)
                case 500...599:
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json returned status code \(response.statusCode) [server side error].", nil)
                default:
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json returned status code \(response.statusCode) [unknown error].", nil)
                }
            }
        }
    }
}
//import UIKit
//import Foundation
//import Accounts
//import Social
//
//class TwitterService: NSObject {
//    
//    let AUTH_URL_BASE = "https://api.twitter.com/oauth/authorize?oauth_token="
//    let twitterBaseURL = NSURL(string: "https://api.twitter.com")
//    let twitterConsumerKey = "8VGnXAqyyDWHLu9bdjC2G6Vhu"
//    let twitterConsumerSecret = "BWw4hhKFdalzHUbTIbp0w2Etg7ifRidlmm1zYofdsuYwy9mnAx"
//    
//    typealias TweetCompletion = (String?, [Tweet]?) -> ()
//    typealias UserCompletion = (String?, User?) -> ()
//    
//    class TwitterService {
//        
//        static let sharedService = TwitterService()
//        
//        var account: ACAccount?
//        var screenName: String?
//        var user: User?
//
//        
//        class func tweetsFromHomeTimeline(completion: TweetCompletion) {
//            let timelineUrl = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
//            let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: timelineUrl, parameters: nil)
//            
//            if let account = self.sharedService.account {
//                request.account = account
//                request.performRequestWithHandler({ (data, response, error) -> Void in
//                    switch response.statusCode {
//                    case 200...299:
//                        let tweets = TweetJSONParser.tweetsFromJSONData(data)
//                        completion(nil, tweets)
//                    case 400...499:
//                        completion("Client error returned status code: \(response.statusCode)", nil)
//                    case 500...599:
//                        completion("Server error returned status code: \(response.statusCode)", nil)
//                    default:
//                        completion("Unknown error returned status code: \(response.statusCode)", nil)
//                    }
//                })
//            }
//        }
//        
//        class func getAuthUser(completion: UserCompletion) {
//            let url = NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")
//            let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: url, parameters: nil)
//            
//            if let account = self.sharedService.account {
//                request.account = account
//                request.performRequestWithHandler({ (data, response, error) -> Void in
//                    switch response.statusCode {
//                    case 200...299:
//                        do {
//                            let userData = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
//                            if let user = TweetJSONParser.userFromJSONData(data) {
//                                completion(nil, user)
//                            }
//                        } catch _ {}
//                    case 400...499:
//                        completion("Client error returned status code: \(response.statusCode)", nil)
//                    case 500...599:
//                        completion("Server error returned status code: \(response.statusCode)", nil)
//                    default:
//                        completion("Unknown error returned status code: \(response.statusCode)", nil)
//                    }
//                })
//            }
//        }
//        
//        class func tweetsFromUserTimeline(user: User?, completion: TweetCompletion) {
//            var parameters = [String:AnyObject]()
//            if let screenName = user?.screenName {
//                parameters["screen_name"] = "\(screenName)"
//            }
//            let userTimelineUrl = NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json")
//            let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: userTimelineUrl, parameters: parameters)
//            
//            if let account = self.sharedService.account {
//                request.account = account
//                request.performRequestWithHandler({ (data, response, error) -> Void in
//                    switch response.statusCode {
//                    case 200...299:
//                        let tweets = TweetJSONParser.tweetsFromJSONData(data)
//                        completion(nil, tweets)
//                    case 400...499:
//                        completion("Client error returned status code: \(response.statusCode)", nil)
//                    case 500...599:
//                        completion("Server error returned status code: \(response.statusCode)", nil)
//                    default:
//                        completion("Unknown error returned status code: \(response.statusCode)", nil)
//                    }
//                })
//            }
//        }
//        
//    }
//
//}
