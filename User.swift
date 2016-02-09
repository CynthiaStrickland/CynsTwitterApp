//
//  User.swift
//  CynsTwitterClone
//
//  Created by Cynthia Whitlatch on 2/8/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//

import UIKit

class User: NSObject {
    let name: String?
    let profileImageURL: String
    let location: String?
    let createdAt: String?
    
    init(name: String, profileImageURL: String, location: String, createdAt: String) {
        self.name = name
        self.profileImageURL = profileImageURL
        self.location = location
        self.createdAt = createdAt
        
    }
}
