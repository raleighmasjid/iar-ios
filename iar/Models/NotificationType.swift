//
//  NotificationType.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/17/22.
//

import Foundation
import UserNotifications

enum NotificationType: String, CaseIterable {
    case saadAlghamidi
    case alafasy
    case silent
    
    var title: String {
        switch self {
        case .saadAlghamidi:
            return "Saad Al-Ghamdi"
        case .alafasy:
            return "Mishary Alafasy"
        case .silent:
            return "Silent"
        }
    }
    
    var notificationSound: UNNotificationSound? {
        switch self {
        case .saadAlghamidi:
            return UNNotificationSound(named: UNNotificationSoundName(rawValue: "AdhanAfasy.caf"))
        case .alafasy:
            return UNNotificationSound(named: UNNotificationSoundName(rawValue: "AdhanSaadAlghamdi.caf"))
        case .silent:
            return nil
        }
    }
}
