//
//  IndexedPrayerDay.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/20/22.
//

import Foundation

struct PrayerDayViewModel: Equatable, Hashable {
    let prayerDay: PrayerDay
    let currentPrayer: Prayer?
    let index: Int
    
    init(prayerDay: PrayerDay, index: Int) {
        self.prayerDay = prayerDay
        self.index = index
        self.currentPrayer = prayerDay.currentPrayer()
    }
}
