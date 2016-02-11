//
//  Tweet.swift
//  CynsTwitterClone
//
//  Created by Cynthia Whitlatch on 2/8/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//

import UIKit

class Tweet {
    
    let text: String
    let id: String
    var user: User?
    let rqText: String?
    let rqUser: User?
    var isRetweet: Tweet?
    
    init(text : String, rqText: String? = nil, id : String, user: User? = nil, rqUser: User? = nil, isRetweet: Tweet?=nil) {
        self.text =  text
        self.id = id
        self.user = user
        self.isRetweet = isRetweet
        self.rqUser = rqUser
        self.rqText = rqText
    }
    
}
