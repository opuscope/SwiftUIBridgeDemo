//
//  UnityManager.swift
//  NativeiOSApp
//
//  Created by Jonathan Thorpe on 21/01/2022.
//  Copyright © 2022 Opuscope SAS. All rights reserved.
//

import Foundation
import UIKit
import OSLog
import UnityFramework
import Combine
import SwiftAsyncBridge

class UnityManager: UIResponder, UnityFrameworkListener, NativeCallsProtocol, BridgeListener {
    
    public var messages : AnyPublisher<BridgeMessage, Never> {
        subject.eraseToAnyPublisher()
    }
    
    private let subject = PassthroughSubject<BridgeMessage, Never>()
    
    func showHostMainWindow(_ color: String!) {
        Logger.bridge.log("UnityLib showHostMainWindow \(color)")
    }
    
    func sendMessage(_ path: String!, _ content: String!) {
        Logger.bridge.log("UnityLib sendMessage \(path) \(content)")
        subject.send(BridgeMessage(path: path, content: content))
    }
    
    public static let instance = UnityManager()
    
    private var ufw : UnityFramework!
    
    var launchOpts : [UIApplication.LaunchOptionsKey: Any]?
    var inputRedirectionView : UIInputRedirectionView?
 
    func showUnity() {
        if(self.unityIsInitialized() == false) {
            self.initUnityWindow()
        }
        else {
            self.showUnityWindow()
        }
    }
 
    func unloadUnity() {
        if self.unityIsInitialized() {
            Logger.bridge.log("⚠️ unloading unity app session from native")
            self.unloadUnityWindow()
        }
    }
 
    func quitUnity() {
        self.quitUnityInternal()
    }

    func sendUnityMessage(_ object : String, method : String, body : String) {
        
        //Send the message right away if Unity is initialized, else cache it
        if unityIsInitialized() {
            ufw.sendMessageToGO(withName: object, functionName: method, message: body)
        }
    }
    
    public var Controller : UIViewController { ufw.appController().rootViewController }
 
    //Callback from UnityFrameworkListener
    func unityDidUnload(_ notification: Notification!) {
        ufw.unregisterFrameworkListener(self)
        ufw = nil
    }

    func unityIsInitialized() -> Bool {
        return ufw != nil && (ufw.appController() != nil)
    }
 
    //Private functions called within the class
    private func initUnityWindow() {
        
        if unityIsInitialized() {
            showUnityWindow()
            return
        }

        ufw = UnityFrameworkLoad()!
        ufw.setDataBundleId("com.unity3d.framework")
        ufw.register(self)
        FrameworkLibAPI.registerAPIforNativeCalls(self)
        ufw.runEmbedded(withArgc: CommandLine.argc, argv: CommandLine.unsafeArgv, appLaunchOpts: launchOpts)
        let levelDescription = "\(ufw.appController().window.windowLevel.rawValue)"
        Logger.bridge.log("UnityManager initUnityWindow with level \(levelDescription)")
        
        ufw.appController().window.windowLevel = UIWindow.Level(-1)
        
        if let inputRedirectionView, let unityView = ufw.appController().rootViewController.view {
            inputRedirectionView.targetView = unityView
        }
    }

    private func showUnityWindow() {
        if unityIsInitialized() {
            ufw.showUnityWindow()
        }
    }
 
    private func unloadUnityWindow() {
        if unityIsInitialized() {
            ufw.unloadApplication()
        }
    }
    
    private func quitUnityInternal() {
        if (unityIsInitialized()) {
            self.ufw.quitApplication(0)
        }
    }

    private func UnityFrameworkLoad() -> UnityFramework? {
        let bundlePath: String = Bundle.main.bundlePath + "/Frameworks/UnityFramework.framework"
   
        let bundle = Bundle(path: bundlePath )
        if bundle?.isLoaded == false {
            bundle?.load()
        }
   
        let ufw = bundle?.principalClass?.getInstance()
        if ufw?.appController() == nil {
            // unity is not initialized
            //            ufw?.executeHeader = &mh_execute_header
       
            let machineHeader = UnsafeMutablePointer<MachHeader>.allocate(capacity: 1)
            machineHeader.pointee = _mh_execute_header
       
            ufw!.setExecuteHeader(machineHeader)
        }
        return ufw
    }

}

