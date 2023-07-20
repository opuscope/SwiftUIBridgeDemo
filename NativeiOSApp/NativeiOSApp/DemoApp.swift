//
//  DemoApp.swift
//  NativeiOSApp
//
//  Created by Jonathan Thorpe on 18/07/2023.
//  Copyright © 2023 unity. All rights reserved.
//

import SwiftUI

// note : can't find a way to configure window for transparency without going through App/Secene delegate

//@main
struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            TestContentView()
        }
    }
}

