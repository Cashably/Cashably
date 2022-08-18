//
//  AppDelegate.swift
//  Cashably
//
//  Created by apollo on 6/12/22.
//

import UIKit
import FirebaseCore
import IQKeyboardManagerSwift
import LinkKit
import Intercom

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        Intercom.setApiKey("ios_sdk-caf6380af6ad72663e809463f42385ede36d9e03", forAppId:"slmcubf2")
//        Intercom.setLauncherVisible(true)
        #if DEBUG
        Intercom.enableLogging()
        #endif
        
        let center = UNUserNotificationCenter.current()
                // Request permission to display alerts and play sounds.
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
        UIApplication.shared.registerForRemoteNotifications()
        
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = UIColor(red: 0.024, green: 0.792, blue: 0.549, alpha: 1)
        let fontAttributes = [NSAttributedString.Key.font: UIFont(name: "BRFirma-SemiBold", size: 11)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        
        IQKeyboardManager.shared.enable = true
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Intercom.setDeviceToken(deviceToken)
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
    
    func application(_ application: UIApplication,
                         continue userActivity: NSUserActivity,
                         restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb, let webpageURL = userActivity.webpageURL else {
            return false
        }

        // The Plaid Link SDK ignores unexpected URLs passed to `continue(from:)` as
        // per Apple’s recommendations, so there is no need to filter out unrelated URLs.
        // Doing so may prevent a valid URL from being passed to `continue(from:)` and
        // OAuth may not continue as expected.
        // For details see https://plaid.com/docs/link/ios/#set-up-universal-links
        guard let linkOAuthHandler = window?.rootViewController as? LinkOAuthHandling, let handler = linkOAuthHandler.linkHandler
        else {
            return false
        }

        // Continue the Link flow
        handler.continue(from: webpageURL)
        return true
    }


}

