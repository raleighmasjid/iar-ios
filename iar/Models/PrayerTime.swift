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
    
    var notificationIdentifier: String {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(identifier: "America/New_York")!
        let comps = cal.dateComponents([.year, .month, .day], from: adhan)
        return "\(comps.year ?? 0)-\(comps.month ?? 0)-\(comps.day ?? 0)-\(prayer.title)"
    }
    
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
