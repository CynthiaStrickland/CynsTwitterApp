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
    let user: User?
    
    init(text: String, id: String, user: User? = nil) {
        self.text = text
        self.id = id
        self.user = user
    }
    
}
