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

class PrayerTimesViewModel: ObservableObject, PrayerProviderDelegate {
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
        self.provider = provider
        self.notificationSettings = NotificationSettings()
        
        provider.delegate = self

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
    
    func didFetchPrayerSchedule(prayerResult: PrayerResult, cached: Bool) {
        if !cached {
            loading = false
        }
        switch prayerResult {
        case .success(let prayerSchedule):
            prayerDays = prayerSchedule.prayerDays
                .filter { Calendar.current.compare(Date(), to: $0.date, toGranularity: .day) != .orderedDescending }
            fridaySchedule = prayerSchedule.fridaySchedule
        case .failure:
            error = true
        }
    }
    
    func updateNextPrayer() {
        let newUpcoming = PrayerDay.upcomingPrayer(prayerDays: prayerDays)
        if newUpcoming != upcoming {
            upcoming = newUpcoming
        }
    }
    
    func fetchLatest() {
        loading = true
        Task {
            await self.provider.fetchPrayers()
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
