//
//  NotificationController.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/16/22.
//

import Foundation
import UserNotifications

actor NotificationController {
    private let notificationLimit = 64
    private let center = UNUserNotificationCenter.current()

    func scheduleNotifications(prayerDays: [PrayerDay], enabledPrayers: [Prayer], notificationType: NotificationType) async {
        guard !enabledPrayers.isEmpty else {
            center.removeAllPendingNotificationRequests()
            return
        }

        do {
            let access = try await center.requestAuthorization(options: [.alert, .sound])
            guard access else { return }

            let now = Date()
            let prayerTimes = prayerDays
                .flatMap { $0.prayerTimes }
                .filter { enabledPrayers.contains($0.prayer) && $0.notificationTime > now }
            
            await schedule(prayerTimes: Array(prayerTimes.prefix(notificationLimit)), notificationType: notificationType)
        } catch {
            NSLog("Error requesting notification authorization \(error)")
        }
    }
    
    private func schedule(prayerTimes: [PrayerTime], notificationType: NotificationType) async {
        center.removeAllPendingNotificationRequests()
        for time in prayerTimes {
            do {
                try await center.add(time.notificationRequest(notificationType: notificationType))
            } catch {
                NSLog("Error scheduling notification: \(error)")
            }
        }
        
        
    }
}
