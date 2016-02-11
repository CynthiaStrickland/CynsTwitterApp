//
//  User.swift
//  CynsTwitterClone
//
//  Created by Cynthia Whitlatch on 2/8/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//

import UIKit

class User {
    
    var name: String
    var profileImageURL: String
    var image: UIImage?
    var screenName: String
    var background: UIImage?
    var backgroundUrl: String
    let location: String
    
    init(name: String, profileImageURL: String, screenName: String, backgroundUrl:String, location: String) {
        self.name = name
        self.profileImageURL = profileImageURL
        self.screenName = screenName
        self.backgroundUrl = backgroundUrl
        self.location = location
        
    }
    
}
