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
        let newRequests = prayerTimes.map { notificationRequest(prayerTime: $0, notificationType: notificationType) }
        for request in newRequests {
            do {
                try await center.add(request)
            } catch {
                NSLog("Error scheduling notification: \(error)")
            }
        }
        let newRequestIDs = newRequests.map(\.identifier)
        let allRequestIDs = await center.pendingNotificationRequests().map(\.identifier)
        let toRemove = Array(Set(allRequestIDs).subtracting(Set(newRequestIDs)))
        center.removePendingNotificationRequests(withIdentifiers: toRemove)
    }
    
    private func notificationRequest(prayerTime: PrayerTime, notificationType: NotificationType) -> UNNotificationRequest {
        let fireDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: prayerTime.notificationTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)
        
        let content = UNMutableNotificationContent()
        switch prayerTime.prayer {
        case .shuruq:
            content.body = "Shuruq is in 30 minutes"
            content.sound = notificationType == .silent ? nil : UNNotificationSound.default
        default:
            content.body = prayerTime.prayer.title
            content.sound = notificationType.notificationSound
        }
        
        content.interruptionLevel = .timeSensitive
        return UNNotificationRequest(identifier: prayerTime.notificationIdentifier, content: content, trigger: trigger)
    }
}
