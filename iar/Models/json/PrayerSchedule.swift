//
//  PrayerSchedule.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/19/22.
//

import Foundation

struct PrayerSchedule: Codable {
    let prayerDays: [PrayerDay]
    let fridaySchedule: [FridayPrayer]
    var cacheDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case prayerDays = "prayer_days"
        case fridaySchedule = "friday_schedule"
        case cacheDate = "cache_date"
    }
}
