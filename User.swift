//
//  User.swift
//  CynsTwitterClone
//
//  Created by Cynthia Whitlatch on 2/8/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//

import UIKit

class User: NSObject {
    var screenName: String?
    var name: String?
    var profileImageURL: String
    var location: String?
    var createdAt: String?
    
    init(screenName: String?, name: String, profileImageURL: String, location: String, createdAt: String) {
        self.screenName = screenName
        self.name = name
        self.profileImageURL = profileImageURL
        self.location = location
        self.createdAt = createdAt
        
    }
}
