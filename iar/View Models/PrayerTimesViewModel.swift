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
    @Published var fridaySchedule: [FridayPrayer] = []
    @Published var error = false
    @Published var loading = false
    
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
        print(">> init viewmodel")
        self.provider = provider
        self.notificationSettings = NotificationSettings()

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateNextPrayer()
        }

        notificationSettings.didUpdate
            .sink { [weak self] in
                self?.updateNotifications()
            }.store(in: &cancellables)
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func didFetchPrayerSchedule(schedule: PrayerSchedule) {
        prayerDays = schedule.prayerDays
            .filter { Calendar.current.compare(Date(), to: $0.date, toGranularity: .day) != .orderedDescending }
        fridaySchedule = schedule.fridaySchedule
    }
    
    func updateNextPrayer() {
        let newUpcoming = PrayerDay.upcomingPrayer(prayerDays: prayerDays)
        if newUpcoming != upcoming {
            upcoming = newUpcoming
        }
    }
    
    func fetchLatest() {
        loading = true
        if let cached = provider.cachedPrayerSchedule {
            didFetchPrayerSchedule(schedule: cached)
        }

        Task {
            do {
                let schedule = try await self.provider.fetchPrayers()
                self.didFetchPrayerSchedule(schedule: schedule)
                self.loading = false
            } catch {
                self.error = true
                self.loading = false
            }
        }
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
