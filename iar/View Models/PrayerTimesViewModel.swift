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
import WidgetKit

@MainActor
class PrayerTimesViewModel: ObservableObject {
    @Published var upcoming: PrayerTime?
    @Published var fridaySchedule: [FridayPrayer] = []
    @Published var error = false
    @Published var loading = false
    @Published var prayerDays: [PrayerDay] = []

    let notificationSettings: NotificationSettings
    
    private weak var timer: Timer?

    private let provider: PrayerProvider
    private let notificationController = NotificationController()

    private var cancellables = Set<AnyCancellable>()
    private var isSchedulingNotifications: Bool = false
    private var rescheduleNotificationsRequired: Bool = false
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid

    init(provider: PrayerProvider) {
        self.provider = provider
        self.notificationSettings = NotificationSettings()

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.updateNextPrayer()
            }
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
    
    func loadData() {
        loading = true
        if let cache = provider.cachedPrayerSchedule {
            setPrayerData(schedule: cache, fromCache: true)
        }
        Task {
            do {
                startBackgroundTask()
                let schedule = try await self.provider.fetchPrayers(forceRefresh: false)
                self.setPrayerData(schedule: schedule, fromCache: false)
                WidgetCenter.shared.reloadAllTimelines()
            } catch {
                self.error = true
            }
            self.loading = false
        }
    }
    
    private func setPrayerData(schedule: PrayerSchedule, fromCache: Bool) {
        prayerDays = schedule.prayerDays
            .filter { Calendar.zonedCalendar.compare(Date(), to: $0.date, toGranularity: .day) != .orderedDescending }
        fridaySchedule = schedule.fridaySchedule
        updateNextPrayer()
        if !fromCache {
            updateNotifications()
        }
    }
    
    private func updateNextPrayer() {
        let newUpcoming = PrayerDay.upcomingPrayer(prayerDays: prayerDays)
        if newUpcoming != upcoming {
            upcoming = newUpcoming
        }
    }

    private func updateNotifications() {
        guard !isSchedulingNotifications else {
            rescheduleNotificationsRequired = true
            return
        }
        
        isSchedulingNotifications = true
        let enabledPrayers = Prayer.allCases.filter { notificationSettings.isEnabled(for: $0) }
        startBackgroundTask()
        Task {
            await self.notificationController.scheduleNotifications(prayerDays: self.prayerDays,
                                                                    enabledPrayers: enabledPrayers,
                                                                    notificationType: self.notificationSettings.type)
            
            self.isSchedulingNotifications = false
            if self.rescheduleNotificationsRequired {
                self.rescheduleNotificationsRequired = false
                updateNotifications()
            } else {
                self.endBackgroundTask()
            }
        }
    }
    
    private func startBackgroundTask() {
        if backgroundTask == .invalid {
            backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
                self?.endBackgroundTask()
            }
        }
    }

    private func endBackgroundTask() {
        if backgroundTask != .invalid {
            UIApplication.shared.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
        }
    }
}
