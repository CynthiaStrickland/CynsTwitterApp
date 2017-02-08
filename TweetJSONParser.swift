//
//  TweetJSONParser.swift
//  CynsTwitterClone
//
//  Created by Cynthia Whitlatch on 2/8/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//

import Foundation

class TweetJSONParser {
    
    class func TweetFromJSONData(_ jsonData: Data) -> [Tweet]? {
        do {
            
            if let rootObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String : AnyObject]] {
                
                var tweets = [Tweet]()
                
                for tweetObject in rootObject {
                    
                    if let text = tweetObject["text"] as? String, id = tweetObject["id_str"] as? String, user = tweetObject["user"] as? [String : AnyObject] {
                        let tweet = Tweet(text: text, id: id)
                        if let name = user["name"] as? String, screenName =
                            user["screen_name"] as? String, profileImageUrl =
                            user["profile_image_url_https"] as? String, location =
                            user["location"] as? String, backgroundUrl =
                            user["profile_banner_url"] as? String {
                                tweet.user = User(name: name, profileImageURL: profileImageUrl, screenName: screenName, backgroundUrl: backgroundUrl, location: location)
                        }
                        tweets.append(tweet)
                        if let retweet = tweetObject["retweeted_status"] as? [String : AnyObject] {
                            if let retweetedText = retweet["text"] as? String, retweetedId = retweet["id_str"] as? String, retweetedUser = retweet["user"] as? [String : AnyObject] {
                                tweet.isRetweet = Tweet(text: retweetedText, id: retweetedId)
                                if let retweetedName =
                                    retweetedUser["name"] as? String, retweetedScreenName =
                                    retweetedUser["screen_name"] as? String, profileImageUrl =
                                    retweetedUser["profile_image_url_https"] as? String, location =
                                    retweetedUser["location"] as? String, backgroundUrl =
                                    retweetedUser["profile_banner_url"] as? String {
                                        tweet.isRetweet?.user = User(name: retweetedName, profileImageURL: profileImageUrl, screenName: retweetedScreenName, backgroundUrl: backgroundUrl, location: location)
                                }
                            }
                        }
                    }
                }
                
                return tweets
            }
            
        } catch _ {
            
            return nil
            
        }
        
        return nil;
    }
    
    
    class func isRetweet(_ tweetObject: [String : AnyObject]) -> (Bool, [String : AnyObject]?) {
        if let retweetObject  = tweetObject["retweeted_status"] as? [String : AnyObject] {
            if let _ = retweetObject["text"] as? String, _ = retweetObject["user"] as? [String : AnyObject] {
                return (true, retweetObject)
            }
        }
        
        return (false, nil)
    }
    
    class func isQuote(_ tweetObject: [String : AnyObject]) -> Bool {
        if let quoteStatus = tweetObject["is_quote_status"] as? Bool where quoteStatus == true {
            if let quoteData = tweetObject["quoted_status"] as? [String : AnyObject] {
                if let _ = quoteData["text"] as? String, _ = quoteData["user"] as? [String : AnyObject] {
                    return true
                }
            }
            
        }
        
        return false
    }
    
    class func userFromData(_ user: [String : AnyObject]) -> User? {
        if let name = user["name"] as? String, screenName = user["screen_name"] as? String, profileImageUrl = user["profile_image_url_https"] as? String, backgroundUrl = user["profile_background_image_url_https"] as? String, location = user["location"] as? String {
            return User(name: name, profileImageURL: profileImageUrl, screenName: screenName, backgroundUrl: backgroundUrl, location: location)
        }
        return nil
    }
}

//import Foundation
//import UIKit
//import Accounts
//import Social
//
//
//class TweetJSONParser: NSObject {
//    
//    class func userFromJSONData(user: NSData) -> [Tweet]? {
//        return [Tweet]()
//    }
//    
//    class func tweetsFromJSONData(jsonData : NSData) -> [Tweet]? { var error : NSError?
//    
//        NSOperationQueue().addOperationWithBlock { () -> Void in
//        
//        do {
//            if let rootObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as? [[String : AnyObject]] {
//                
//                var tweets = [Tweet]()
//                for tweetObject in rootObject {
//                    if let
//                        text = tweetObject["text"] as? String,
//                        id = tweetObject["id"] as? String?,
//                        user = tweetObject["user"] as? [String:AnyObject]  {
//                        let tweet = Tweet(text: text, id: id!)
//                        tweets.append(tweet)
//
//                    if let
//                        screenName = user["screen_name"] as? String,
//                        name = user["name"] as? String,
//                        profileImageURL = user["profileImageURL"] as? String,
//                        location = user ["location"] as? String,
//                        createdAt = user["createdAt"] as? String
//                    {
//                        
//    //                    let user = self.userFromTweetJSON(userJSON)
//                        let user = User(screenName: screenName, name: name, profileImageURL: profileImageURL, location: location, createdAt: createdAt)
//                        }
//                    }
//                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
////                        completion(success:true, tweets: tweets)
//                    })
//                }
//            }
//        } catch {
//                print("error serializing JSON: \(error)")
//                }
//            }
//        return nil
//        }
//}
