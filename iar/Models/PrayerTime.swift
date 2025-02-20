//
//  PrayerTime.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import Foundation

struct PrayerTime: Equatable {
    let prayer: Prayer
    let adhan: Date
    let iqamah: Date?
    
    var timeRemaining: TimeInterval {
        adhan.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate
    }
    
    var notificationTime: Date {
        switch prayer {
        case .shuruq:
            return adhan.addingTimeInterval(-60 * 30)
        default:
            return adhan
        }
    }
}
