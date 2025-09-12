//
//  GlassEffects.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 9/10/25.
//

import SwiftUI

extension ToolbarItem {
    func removeGlass() -> some ToolbarContent {
        if #available(iOS 26.0, *) {
            return self.sharedBackgroundVisibility(.hidden)
        } else {
            return self
        }
    }
}
