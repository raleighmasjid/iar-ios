//
//  Color.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import Foundation
import SwiftUI

extension Color {
    enum Theme {
        
        static let tabBackground = Color("TabBackground")
        static let tabForeground = Color("TabForeground")
        static let darkGreen = Color("DarkGreen")
        static let prayerBackground = Color("PrayerBackground")
        static let prayerBorder = Color("PrayerBorder")
        static let prayerBorderCurrent = Color("PrayerBorderCurrent")
        static let badgeBackground = Color("BadgeBackground")
        static let indicatorActive = Color("IndicatorActive")
        static let indicatorInactive = Color("IndicatorInactive")
        static let segmentedBackground = Color("SegmentedBackground")
    }
    
    var uiColor: UIColor {
        UIColor(self)
    }
}
