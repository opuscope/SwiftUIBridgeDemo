//
//  SceneDelegate.swift
//  NativeiOSApp
//
//  Created by Jonathan Thorpe on 18/07/2023.
//  Copyright © 2023 unity. All rights reserved.
//

import Foundation
import SwiftUI
import OSLog

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    let uiWindowLevel = 0.5
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        
        Logger.bridge.log("SceneDelegate willConnectTo \(session)")
        
        let window = UIWindow(windowScene: windowScene)
        window.windowLevel = UIWindow.Level(uiWindowLevel)
        window.backgroundColor = UIColor.clear;
        window.isOpaque = false
        
        let hostingViewController = UIHostingController(rootView: TestContentView())
        hostingViewController.view.isOpaque = false
        hostingViewController.view.backgroundColor = UIColor.clear;
        
        window.rootViewController = hostingViewController
        self.window = window
        window.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
      
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
      
    }

    func sceneWillResignActive(_ scene: UIScene) {
      
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
      
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
      
    }
}
