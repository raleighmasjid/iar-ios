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
    @Published var upcoming: PrayerTime?
    @Published var timeRemaining: TimeInterval = 0
    @Published var error = false
    
    let notificationSettings: NotificationSettings
    var prayerDays: [PrayerDay] = [] {
        didSet {
            updateNextPrayer()
            
            if (prayerDays != oldValue) {
                updateNotifications()
            }
        }
    }

    weak var timer: Timer?

    let provider: PrayerProvider
    let notificationController = NotificationController()

    var cancellables = Set<AnyCancellable>()

    func prayerDay(offset: Int = 0) -> PrayerDay? {
        return prayerDays[safe: offset]
    }
    
    init(provider: PrayerProvider) {
        print(">> init PrayerTimesViewModel")
        self.provider = provider
        self.notificationSettings = NotificationSettings()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateNextPrayer()
        }

        
        
        NotificationCenter.default.publisher(for: .NSCalendarDayChanged)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.loadTimes()
            }.store(in: &cancellables)
        
        notificationSettings.didUpdate
            .sink { [weak self] in
                self?.updateNotifications()
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

    func updateNotifications() {
        let enabledPrayers = Prayer.allCases.filter { notificationSettings.isEnabled(for: $0) }
        Task {
            await self.notificationController.scheduleNotifications(prayerDays: self.prayerDays,
                                                                    enabledPrayers: enabledPrayers,
                                                                    notificationType: self.notificationSettings.type)
        }
    }
}
