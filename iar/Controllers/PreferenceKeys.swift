//
//  PreferenceKeys.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 5/13/24.
//

import SwiftUI

struct PrayerScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}
