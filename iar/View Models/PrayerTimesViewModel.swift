//
//  PrayerTimesViewModel.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import Foundation
import UIKit
import SwiftUI
import Combine

class PrayerTimesViewModel: ObservableObject {
    @Published var current: PrayerDay?
    @Published var upcoming: PrayerTime?
    @Published var timeRemaining: TimeInterval = 0
    @Published var error = false
    
    let notificationSettings: NotificationSettings
    var prayerDays: [PrayerDay] = [] {
        didSet {
            current = prayerDays.first(where: {
                Calendar.current.isDateInToday($0.date)
            })

            updateNextPrayer()
        }
    }

    weak var timer: Timer?

    let provider: PrayerProvider

    var cancellables = Set<AnyCancellable>()

    init(provider: PrayerProvider) {
        print("init PrayerTimesViewModel")
        self.provider = provider
        self.notificationSettings = NotificationSettings()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateNextPrayer()
        }

        let publishers = [NotificationCenter.default.publisher(for: UIScene.willEnterForegroundNotification),
                          NotificationCenter.default.publisher(for: .NSCalendarDayChanged)]
        
        Publishers.MergeMany(publishers)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.loadTimes()
            }.store(in: &cancellables)
        
        notificationSettings.didUpdate
            .sink { [weak self] in
                self?.didUpdateNotifications()
            }.store(in: &cancellables)
        
        provider.didUpdate
            .sink() { [weak self] result in
                switch result {
                case .success(let prayerDays):
                    self?.prayerDays = prayerDays
                case .failure:
                    self?.error = true
                }
            }.store(in: &cancellables)
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
        provider.fetchPrayerTimes()
    }

    func didUpdateNotifications() {
        print("didUpdateAlarm")
        Prayer.allCases.forEach { prayer in
            print("\(prayer.title) is \(self.notificationSettings.isEnabled(for: prayer))")
        }
    }
}
