//
//  AppDelegate.swift
//  NativeiOSApp
//
//  Created by Jonathan Thorpe on 18/07/2023.
//  Copyright © 2023 unity. All rights reserved.
//

import Foundation
import UIKit
import OSLog

@main
class AppDelegate: NSObject, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        Logger.bridge.log("AppDelegate application didFinishLaunchingWithOptions")
        
        return true
    }
    
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        Logger.bridge.log("AppDelegate application configurationForConnecting \(connectingSceneSession)")
          let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
          sceneConfig.delegateClass = SceneDelegate.self
          return sceneConfig
      }
    
}
