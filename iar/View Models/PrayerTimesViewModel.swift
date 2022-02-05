//
//  PrayerTimesViewModel.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import Foundation

class PrayerTimesViewModel: ObservableObject {
    @Published var prayerDays: [PrayerDay] = []
    @Published var current: PrayerDay?
    @Published var upcoming: PrayerTime?
    @Published var timeRemaining: TimeInterval = 0
    
    weak var timer: Timer?
    
    let provider: PrayerProvider
    
    init(provider: PrayerProvider) {
        self.provider = provider
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateNextPrayer()
        }
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func updateNextPrayer() {
        upcoming = PrayerDay.upcomingPrayer(prayerDays: prayerDays)
        if let upcoming = upcoming {
            timeRemaining = upcoming.adhan.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate
        }
    }
    
    func loadTimes() {
        Task {
            prayerDays = await provider.fetchPrayerTimes()
            current = prayerDays.first(where: {
                Calendar.current.isDateInToday($0.date)
            })

            updateNextPrayer()
        }
    }
}
