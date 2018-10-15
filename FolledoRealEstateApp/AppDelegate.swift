//
//  AppDelegate.swift
//  FolledoRealEstateApp
//
//  Created by Samuel Folledo on 10/14/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//e3258093-1466-4ddd-acde-667495920a4b

import UIKit
import Firebase //RE ep.6 1min
import OneSignal //RE ep.6 1min //Not importing backendless because it's already connected to our Bridging header which automatically allows us to use it all over our project, but still need to set up at 2mins online with its APP_ID, and APP_KEY


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let APP_ID =  "6F5851E4-03F2-5A0B-FF8F-6EE34AB00100" //RE ep.6 2mins from backendless website's project settings
    let API_KEY = "86F6D554-479C-848F-FF2B-4B4322D93600" //RE ep.6 2mins backendless's api_key
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        FirebaseApp.configure() //RE ep.6 2mins start firebase
        backendless!.initApp(APP_ID, apiKey: API_KEY) //RE ep.6 5mins start backendless
        OneSignal.initWithLaunchOptions(launchOptions, appId: kONESIGNALAPPID, handleNotificationReceived: nil, handleNotificationAction: nil, settings: nil) //RE ep.6 6mins appId can be found in OneSignal's site -> App Settings -> Keys & IDs.
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

