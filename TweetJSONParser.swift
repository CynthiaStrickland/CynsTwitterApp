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
    
    func tweetFromJSONData(json: NSData) -> [Tweet]? {

    do {
        if let rootObject = try NSJSONSerialization.JSONObjectWithData(json, options: []) as? [[String:AnyObject]]
        {
            var tweets = [Tweet]()
            
            for tweetObject in rootObject {
                if let text = tweetOjbect["text"] as? String, id = tweetObject["id"] as? String?, user = tweetObject["user"] as? [String:AnyObject] {
                    let tweet = Tweet(text: text, id: id)
                    if let
                        name = user["name"] as? String, profileImageURL =
                        user["profileImageURL"] as? String,location =
                        user ["location"] as? String, createdAt =
                            user["createdAt"] as? String {
                                tweet.user = User(name: name, profileImageURL: profileImageURL, location: location, createdAt: createdAt)
                    }
                }
            }
            
        }
    
    if let blogs = json["blogs"] as? [[String: AnyObject]] {
    for blog in blogs {
    if let name = blog["name"] as? String {
    names.append(name)
    }
    }
    }
    } catch {
    print("error serializing JSON: \(error)")
    }
    
    print(names)
}
