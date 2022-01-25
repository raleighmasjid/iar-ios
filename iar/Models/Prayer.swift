//
//  Prayer.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import Foundation

enum Prayer: CaseIterable {
    case fajr
    case shuruq
    case dhuhr
    case asr
    case maghrib
    case isha
    
    var title: String {
        switch self {
        case .fajr:
            return "Fajr"
        case .shuruq:
            return "Shuruq"
        case .dhuhr:
            return "Dhuhr"
        case .asr:
            return "Asr"
        case .maghrib:
            return "Maghrib"
        case .isha:
            return "Isha"
        }
    }
    
    func adhan(from day: PrayerDay) -> Date {
        switch self {
        case .fajr:
            return day.adhan.fajr
        case .shuruq:
            return day.adhan.shuruq
        case .dhuhr:
            return day.adhan.dhuhr
        case .asr:
            return day.adhan.asr
        case .maghrib:
            return day.adhan.maghrib
        case .isha:
            return day.adhan.isha
        }
    }
    
    func iqamah(from day: PrayerDay) -> Date? {
        switch self {
        case .fajr:
            return day.iqamah.fajr
        case .shuruq:
            return nil
        case .dhuhr:
            return day.iqamah.dhuhr
        case .asr:
            return day.iqamah.asr
        case .maghrib:
            return day.iqamah.maghrib
        case .isha:
            return day.iqamah.isha
        }
    }
}
