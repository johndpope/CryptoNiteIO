
//
//  AppDelegate.swift
//  CryptoNiteIO
//
//  Created by LogicAppSourceIO on 23/05/17.
//  Copyright © 2017 Logicappsource. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  //var coordinator: AppCoordinator!
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool { // Override point for customization after application launch.
    

    //Coordinator = AppCoordinator(window: UIWindow(frame: UIScreen.main.bounds))
  /*
    window = UIWindow(frame: UIScreen.main.bounds)
    coordinator = AppCoordinator(window: .init()) //navigationController
    coordinator.start()
    window?.makeKeyAndVisible()
    coordinator.start()     
    */
    
    //Background Fetch
    UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
    
    UNUserNotificationCenter.current().delegate = self
    
    configureUserNotifications()
    
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
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let tabBarController = window?.rootViewController as? UITabBarController,
        let viewControllers = tabBarController.viewControllers
        {
            for viewController in viewControllers {
                if let TempEthereumViewController = viewController as? TempEthereumViewController {
                    TempEthereumViewController.fetch {
                        TempEthereumViewController.updateUI()
                        completionHandler(.newData)
                    }
                }
            }
        }
    }

    
    private func configureUserNotifications() {
        
        let favAction = UNNotificationAction(identifier: "Keep Notifying me", title: "Keep Notifying me", options: [])
        let dissmisAction = UNNotificationAction(identifier: "Don´t Disturb", title: "Don´t Disturb", options: [])
        
        let category = UNNotificationCategory(identifier: "bitcoinNotificationCategory", actions: [favAction, dissmisAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    
        
    }
    
    
    
    
    
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Response received for \(response.actionIdentifier)")
        completionHandler()
        
    }
    
    
    
}


