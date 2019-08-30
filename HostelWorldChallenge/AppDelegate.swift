//
//  AppDelegate.swift
//  HostelWorldChallenge
//
//  Created by Fernando Moya de Rivas on 28/08/2019.
//  Copyright © 2019 Fernando Moya de Rivas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appContainer: AppContainer!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        appContainer = AppContainer()
        
        window = appContainer.window
        window?.rootViewController = appContainer.rootViewController
        window?.makeKeyAndVisible()

        return true
    }

}

