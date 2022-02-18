//
//  PrayerTime.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import Foundation
import UserNotifications

struct PrayerTime {
    let prayer: Prayer
    let adhan: Date
    let iqamah: Date?
    
    var notificationTime: Date {
        switch prayer {
        case .shuruq:
            return adhan.addingTimeInterval(-60 * 30)
        default:
            return adhan
        }
    }
    
    func notificationRequest(notificationType: NotificationType) -> UNNotificationRequest {
        let fireDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notificationTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)
        
        let content = UNMutableNotificationContent()
        switch prayer {
        case .shuruq:
            content.body = "Shuruq is in 30 minutes"
        default:
            content.body = prayer.title
        }
        
        content.sound = notificationType.notificationSound
        
        if #available(iOS 15.0, *) {
            content.interruptionLevel = .timeSensitive
        }
        return UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    }
}
