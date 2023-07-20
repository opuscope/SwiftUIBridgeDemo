//
//  InputRedirectionView.swift
//  NativeiOSApp
//
//  Created by Jonathan Thorpe on 20/07/2023.
//  Copyright © 2023 unity. All rights reserved.
//

import Foundation
import SwiftUI

struct UnityInputRedirectionView : UIViewRepresentable {

    func makeUIView(context: Context) -> UIInputRedirectionView {
        let result = UIInputRedirectionView()
        result.backgroundColor = UIColor.clear
        result.isOpaque = false
        UnityManager.instance.inputRedirectionView = result
        return result
    }

    func updateUIView(_ uiView: UIInputRedirectionView, context: Context) {
        
    }
}
