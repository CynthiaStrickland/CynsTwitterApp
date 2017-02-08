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
                    
                    if let text = tweetObject["text"] as? String, let id = tweetObject["id_str"] as? String, let user = tweetObject["user"] as? [String : AnyObject] {
                        let tweet = Tweet(text: text, id: id)
                        if let name = user["name"] as? String, let screenName =
                            user["screen_name"] as? String, let profileImageUrl =
                            user["profile_image_url_https"] as? String, let location =
                            user["location"] as? String, let backgroundUrl =
                            user["profile_banner_url"] as? String {
                                tweet.user = User(name: name, profileImageURL: profileImageUrl, screenName: screenName, backgroundUrl: backgroundUrl, location: location)
                        }
                        tweets.append(tweet)
                        if let retweet = tweetObject["retweeted_status"] as? [String : AnyObject] {
                            if let retweetedText = retweet["text"] as? String, let retweetedId = retweet["id_str"] as? String, let retweetedUser = retweet["user"] as? [String : AnyObject] {
                                tweet.isRetweet = Tweet(text: retweetedText, id: retweetedId)
                                if let retweetedName =
                                    retweetedUser["name"] as? String, let retweetedScreenName =
                                    retweetedUser["screen_name"] as? String, let profileImageUrl =
                                    retweetedUser["profile_image_url_https"] as? String, let location =
                                    retweetedUser["location"] as? String, let backgroundUrl =
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
            if let _ = retweetObject["text"] as? String, let _ = retweetObject["user"] as? [String : AnyObject] {
                return (true, retweetObject)
            }
        }
        
        return (false, nil)
    }
    
    class func isQuote(_ tweetObject: [String : AnyObject]) -> Bool {
        if let quoteStatus = tweetObject["is_quote_status"] as? Bool, quoteStatus == true {
            if let quoteData = tweetObject["quoted_status"] as? [String : AnyObject] {
                if let _ = quoteData["text"] as? String, let _ = quoteData["user"] as? [String : AnyObject] {
                    return true
                }
            }
            
        }
        
        return false
    }
    
    class func userFromData(_ user: [String : AnyObject]) -> User? {
        if let name = user["name"] as? String, let screenName = user["screen_name"] as? String, let profileImageUrl = user["profile_image_url_https"] as? String, let backgroundUrl = user["profile_background_image_url_https"] as? String, let location = user["location"] as? String {
            return User(name: name, profileImageURL: profileImageUrl, screenName: screenName, backgroundUrl: backgroundUrl, location: location)
        }
        return nil
    }
}

