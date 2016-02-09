//
//  TweetJSONParser.swift
//  CynsTwitterClone
//
//  Created by Cynthia Whitlatch on 2/8/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//

import UIKit

class TweetJSONParser: NSObject {

    typealias JSONData = [String:AnyObject]
    
    func tweetFromJSONData(jsonData: NSData) -> [Tweet]? {

    do {
        if let rootObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as? [[String:AnyObject]]
        {
            var tweets = [Tweet]()
            
            for tweetObject in rootObject {
                if let
                    text = tweetObject["text"] as? String,
                    id = tweetObject["id"] as? String?,
                    user = tweetObject["user"] as? [String:AnyObject]  {
                    let tweet = Tweet(text: text, id: id!)
                        
                    if let
                        name = user["name"] as? String, profileImageURL =
                        user["profileImageURL"] as? String,location =
                        user ["location"] as? String, createdAt =
                        user["createdAt"] as? String
                    {
                        tweet.user = User(name: name, profileImageURL: profileImageURL, location: location, createdAt: createdAt)
                    }
                }
            }
        }
    } catch {
            print("error serializing JSON: \(error)")
        }
    }
}

//
//class TweetJSONParser {
//    class func tweetsFromJSONData(jsonData : NSData) -> [Tweet]? {
//        var error : NSError?
//        
//        if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as? [[String : AnyObject]] {
//            var tweets = [Tweet]()
//            for tweetObject in rootObject {
//                if let text = tweetObject["text"] as? String,
//                    id = tweetObject["id_str"] as? String,
//                    userInfo = tweetObject["user"] as? [String : AnyObject],
//                    username = userInfo["name"] as? String,
//                    profileImageURL = userInfo["profile_image_url"] as? String {
//                        
//                    let tweet = Tweet(text: text, id: id, username: username, profileImageURL: profileImageURL, profileImage: nil)
//                        tweets.append(tweet)
//                }
//            }
//            return tweets
//        }
//        return nil
//    }
//}