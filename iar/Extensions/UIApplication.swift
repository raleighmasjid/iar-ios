//
//  UIApplication.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/21/25.
//

import UIKit
import SwiftUI

extension UIApplication {
    var primaryWindow: UIWindow? {
        connectedScenes
        .compactMap {
            $0 as? UIWindowScene
        }
        .flatMap {
            $0.windows
        }
        .first {
            $0.isKeyWindow
        }
    }
    
    var statusBarHeight: CGFloat {
        primaryWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
}
