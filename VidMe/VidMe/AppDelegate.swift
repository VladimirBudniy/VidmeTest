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
    
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateInitialViewController() as! UITabBarController
        
        if (userDefaults.value(forKey: "token") != nil) {
            let featuredViewController = FeaturedViewController()
            let newViewController = NewViewController()
            let feedViewController = FeedViewController()
            
            let collection = [featuredViewController, newViewController, feedViewController]
            tabBarController.setViewControllers(collection, animated: true)
        } else {
            let featuredViewController = FeaturedViewController()
            let newViewController = NewViewController()
            let loginViewController = LoginViewController()
            
            let collection = [featuredViewController, newViewController, loginViewController]
            tabBarController.setViewControllers(collection, animated: true)
        }
        
        
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

