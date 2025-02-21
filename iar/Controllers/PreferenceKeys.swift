//
//  PreferenceKeys.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 5/13/24.
//

import SwiftUI

struct FramePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
    }
}
