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
        static let darkGreen = Color("DarkGreen")
        static let prayerBackground = Color("PrayerBackground")
        static let prayerBorder = Color("PrayerBorder")
        static let prayerBorderCurrent = Color("PrayerBorderCurrent")
        static let badgeBackground = Color("BadgeBackground")
        static let indicatorActive = Color("IndicatorActive")
        static let indicatorInactive = Color("IndicatorInactive")
    }
    
    var uiColor: UIColor {
        UIColor(self)
    }
}
