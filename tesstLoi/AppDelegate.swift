//
//  AppDelegate.swift
//  tesstLoi
//
//  Created by Apple on 2/21/21.
//  Copyright © 2021 Tofu. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import DropDown
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        var window: UIWindow?
//
//        GMSServices.provideAPIKey("AIzaSyDFWa0NcyAk0VaZCRc2v4IcctBcr8g5R4")
//        GMSPlacesClient.provideAPIKey("AIzaSyDFWa0NcyAk0VaZCRc2v4IcctBcr8g5R4")
        GMSServices.provideAPIKey("AIzaSyD7gl7LrxtbTjlplCXphN2EJi7HRi9s_8Y")
              GMSPlacesClient.provideAPIKey("AIzaSyD7gl7LrxtbTjlplCXphN2EJi7HRi9s_8Y")
        DropDown.startListeningToKeyboard()


        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

