//
//  Tweet.swift
//  CynsTwitterClone
//
//  Created by Cynthia Whitlatch on 2/8/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    let text: String?
    let id: String?
    let retweetCount: Int
    let user: User?
    
    init(text: String, id: String, retweetCount: Int, user: User? = nil) {
        self.text = text
        self.id = id
        self.retweetCount = retweetCount
        self.user = user
    }
    
}
