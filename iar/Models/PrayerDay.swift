//
//  PrayerDay.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import Foundation

struct PrayerDay: Codable {
    let date: Date
    let hijri: HijriComponents
    let adhan: AdhanSchedule
    let iqamah: IqamahSchedule
}
