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

@MainActor
class PrayerTimesViewModel: ObservableObject {
    @Published var upcoming: PrayerTime?
    @Published var fridaySchedule: [FridayPrayer] = []
    @Published var error = false
    @Published var loading = false
    @Published var prayerDays: [PrayerDay] = [] {
        didSet {
            updateNextPrayer()
            
            if (prayerDays != oldValue) {
                updateNotifications()
            }
        }
    }

    let notificationSettings: NotificationSettings
    
    private weak var timer: Timer?

    private let provider: PrayerProvider
    private let notificationController = NotificationController()

    private var cancellables = Set<AnyCancellable>()

    init(provider: PrayerProvider) {
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
    
    func prayerDay(offset: Int = 0) -> PrayerDay? {
        return prayerDays[safe: offset]
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
    
    private func didFetchPrayerSchedule(schedule: PrayerSchedule) {
        prayerDays = schedule.prayerDays
            .filter { Calendar.zonedCalendar.compare(Date(), to: $0.date, toGranularity: .day) != .orderedDescending }
        fridaySchedule = schedule.fridaySchedule
    }
    
    private func updateNextPrayer() {
        let newUpcoming = PrayerDay.upcomingPrayer(prayerDays: prayerDays)
        if newUpcoming != upcoming {
            upcoming = newUpcoming
        }
    }

    private func updateNotifications() {
        let enabledPrayers = Prayer.allCases.filter { notificationSettings.isEnabled(for: $0) }
        Task {
            await self.notificationController.scheduleNotifications(prayerDays: self.prayerDays,
                                                                    enabledPrayers: enabledPrayers,
                                                                    notificationType: self.notificationSettings.type)
        }
    }
}
