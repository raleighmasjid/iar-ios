//
//  UIScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/5/22.
//

import Foundation
import UIKit

extension UIScreen {
    static var isTiny: Bool {
        return (UIScreen.main.bounds.width <= 320)
    }
}
