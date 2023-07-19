//
//  TestContentView.swift
//  NativeiOSApp
//
//  Created by Jonathan Thorpe on 18/07/2023.
//  Copyright © 2023 unity. All rights reserved.
//

import Foundation
import SwiftUI
import OSLog

struct Hero: Identifiable {
  let id: UUID = UUID()
  let name: String
}

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .clipShape(Capsule())
    }
}

struct TestContentView: View {
    let duration : TimeInterval = 5
    var body: some View {
      VStack {
          Spacer()
          HStack {
              Button("Red") {
                  SwiftBridgeDemo.instance.switchColor(red: 1, green: 0, blue: 0, duration: duration)
              }.buttonStyle(BlueButton())
              Button("Green") {
                  SwiftBridgeDemo.instance.switchColor(red: 0, green: 1, blue: 0, duration: duration)
              }.buttonStyle(BlueButton())
              Button("Blue") {
                  SwiftBridgeDemo.instance.switchColor(red: 0, green: 0, blue: 1, duration: duration)
              }.buttonStyle(BlueButton())
          }
          HStack {
              Button("Show Unity") {
                  UnityManager.instance.showUnity()
              }.buttonStyle(BlueButton())
              Button("Unload Unity") {
                  UnityManager.instance.unloadUnity()
              }.buttonStyle(BlueButton())
          }
      }.background(Color.clear)
    }
}
