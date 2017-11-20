//
//  AppDelegate.swift
//  Netnotifi
//
//  Created by Naruto on 11/19/17.
//  Copyright © 2017 Naruto. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import FirebaseInstanceID
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (isGranted, err) in
            if err != nil {
                //Something bad happend
            } else {
                UNUserNotificationCenter.current().delegate = self
                Messaging.messaging().delegate = self
                
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        
        FirebaseApp.configure()
        
        return true
    }
    
    func ConnectToFCM() {
        Messaging.messaging().shouldEstablishDirectChannel = true
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        Messaging.messaging().shouldEstablishDirectChannel = false
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        Messaging.messaging().shouldEstablishDirectChannel = false
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        ConnectToFCM()
        Messaging.messaging().shouldEstablishDirectChannel = false
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        let newToken = InstanceID.instanceID().token()
        ConnectToFCM()
    }
    
}


