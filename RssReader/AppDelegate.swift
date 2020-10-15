//
//  AppDelegate.swift
//  RssReader
//
//  Created by vladislav on 03.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DataManager.shared.fillTheBD()
        
        return true
    }
}

