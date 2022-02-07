//
//  PrayerTimesViewModel.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import Foundation
import UIKit
import SwiftUI

class PrayerTimesViewModel: ObservableObject, AlarmSettingDelegate {
    @Published var current: PrayerDay?
    @Published var upcoming: PrayerTime?
    @Published var timeRemaining: TimeInterval = 0
    
    let alarm: AlarmSetting
    var prayerDays: [PrayerDay] = []
    weak var timer: Timer?
    
    let provider: PrayerProvider
    
    init(provider: PrayerProvider) {
        print("init PrayerTimesViewModel")
        self.provider = provider
        self.alarm = AlarmSetting()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateNextPrayer()
        }
        
        self.alarm.delegate = self
        NotificationCenter.default.addObserver(forName: UIScene.willEnterForegroundNotification, object: nil, queue: nil) { [weak self] _ in
            self?.loadTimes()
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
    
    func didUpdateAlarm() {
        print("didUpdateAlarm")
    }
}
