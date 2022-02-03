//
//  PrayerController.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import Foundation

class PrayerController: ObservableObject {
    @Published var prayerDays: [PrayerDay] = []
    @Published var current: PrayerDay?
    @Published var upcoming: PrayerTime?
    
    let provider: PrayerProvider
    
    init(provider: PrayerProvider) {
        self.provider = provider
    }
    
    func loadTimes() {
        Task {
            prayerDays = await provider.fetchPrayerTimes()
            current = prayerDays.first(where: {
                Calendar.current.isDateInToday($0.date)
            })

            upcoming = PrayerDay.upcomingPrayer(prayerDays: prayerDays)
        }
    }
}
