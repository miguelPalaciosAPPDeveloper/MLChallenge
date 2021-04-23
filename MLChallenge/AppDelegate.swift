//
//  AppDelegate.swift
//  MLChallenge
//
//  Created by Miguel Angel De Leon Palacios on 12/04/21.
//

import UIKit
import CoreData
import MLChallengeAPI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let coreStoreManager: CoreStoreManager = CoreStoreManagerImplementation()
    var orientationLock = UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        MLChallengueAPIConfig.appVersion = Bundle.main.appVersion
        MLChallengueAPIConfig.environment = .dev
        coreStoreManager.initialize()
        
        if #available(iOS 13, *) { return true }
        let window = UIWindow()
        window.setupRootViewController()
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
}

