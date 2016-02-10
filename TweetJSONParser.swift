//
//  TweetJSONParser.swift
//  CynsTwitterClone
//
//  Created by Cynthia Whitlatch on 2/8/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//
import Foundation
import UIKit
import Accounts
import Social


class TweetJSONParser: NSObject {
    
    class func userFromJSONData(user: NSData) -> [Tweet]? {
        return [Tweet]()
    }
    
    class func tweetsFromJSONData(jsonData : NSData) -> [Tweet]? { var error : NSError?
    
        NSOperationQueue().addOperationWithBlock { () -> Void in
        
        do {
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as? [[String : AnyObject]] {
                
                var tweets = [Tweet]()
                for tweetObject in rootObject {
                    if let
                        text = tweetObject["text"] as? String,
                        id = tweetObject["id"] as? String?,
                        user = tweetObject["user"] as? [String:AnyObject]  {
                        let tweet = Tweet(text: text, id: id!)
                        tweets.append(tweet)

                    if let
                        screenName = user["screen_name"] as? String,
                        name = user["name"] as? String,
                        profileImageURL = user["profileImageURL"] as? String,
                        location = user ["location"] as? String,
                        createdAt = user["createdAt"] as? String
                    {
                        
    //                    let user = self.userFromTweetJSON(userJSON)
                        let user = User(screenName: screenName, name: name, profileImageURL: profileImageURL, location: location, createdAt: createdAt)
                        }
                    }
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
    //                    completion(success:true, tweets: tweets)
                    })
                }
            }
        } catch {
                print("error serializing JSON: \(error)")
                }
            }
        return nil
        }
}