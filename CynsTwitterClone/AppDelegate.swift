//
//  AppDelegate.swift
//  CynsTwitterClone
//
//  Created by Cynthia Whitlatch on 2/8/16.
//  Copyright © 2016 Cynthia Whitlatch. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }
    
    func TwitterKey() {
        let keys = (twitterConsumerKey:"8VGnXAqyyDWHLu9bdjC2G6Vhu", twitterConsumerSecret:"BWw4hhKFdalzHUbTIbp0w2Etg7ifRidlmm1zYofdsuYwy9mnAx")
        
        let twitterConsumerKey = keys.twitterConsumerKey
        let twitterConsumerSecret = keys.twitterConsumerSecret
    }
}

