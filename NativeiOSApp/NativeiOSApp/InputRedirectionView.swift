//
//  InputRedirectionView.swift
//  NativeiOSApp
//
//  Created by Jonathan Thorpe on 19/07/2023.
//  Copyright © 2023 unity. All rights reserved.
//

import Foundation
import UIKit

class InputRedirectionView : UIView {
    var targetView: UIView?
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let hitView = super.hitTest(point, with: event),
           hitView != self {
            return hitView
        }
        
        return targetView?.hitTest(point, with: event)
    }
}
