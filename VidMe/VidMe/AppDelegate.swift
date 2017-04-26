//
//  AppDelegate.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

let userDefaults = UserDefaults.standard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = UITabBarController()
        
        if (userDefaults.value(forKey: "token") != nil) {
            let featuredViewController = storyboard.instantiateViewController(withIdentifier: "FeaturedViewController")
            let newViewController = storyboard.instantiateViewController(withIdentifier: "NewViewController")
            let feedViewController = storyboard.instantiateViewController(withIdentifier: "FeedViewController")
            
            tabBarController.viewControllers = [featuredViewController, newViewController, feedViewController]
        } else {
            let featuredViewController = storyboard.instantiateViewController(withIdentifier: "FeaturedViewController")
            let newViewController = storyboard.instantiateViewController(withIdentifier: "NewViewController")
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            
            tabBarController.viewControllers = [featuredViewController, newViewController, loginViewController]
        }
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    
    

}

