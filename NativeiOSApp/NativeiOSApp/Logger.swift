//
//  Logger.swift
//  NativeiOSApp
//
//  Created by Jonathan Thorpe on 19/07/2023.
//  Copyright © 2023 unity. All rights reserved.
//

import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let bridge = Logger(subsystem: subsystem, category: "swift_bridge_demo")
}
