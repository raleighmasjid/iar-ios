//
//  PrayerDay.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import Foundation

struct PrayerDay: Codable, Equatable, Hashable {
    let date: Date
    let hijri: HijriComponents
    let adhan: AdhanSchedule
    let iqamah: IqamahSchedule
    
    func currentPrayer(at time: Date = Date()) -> Prayer? {
        if adhan.isha <= time {
            if Calendar.current.isDate(adhan.isha, inSameDayAs: time) {
                return .isha
            } else {
                return nil
            }
        } else if adhan.maghrib <= time {
            return .maghrib
        } else if adhan.asr <= time {
            return .asr
        } else if adhan.dhuhr <= time {
            return .dhuhr
        } else if adhan.shuruq <= time {
            return .shuruq
        } else if adhan.fajr <= time {
            return .fajr
        }

        return nil
    }
    
    func adhan(for prayer: Prayer) -> Date {
        switch prayer {
        case .fajr:
            return adhan.fajr
        case .shuruq:
            return adhan.shuruq
        case .dhuhr:
            return adhan.dhuhr
        case .asr:
            return adhan.asr
        case .maghrib:
            return adhan.maghrib
        case .isha:
            return adhan.isha
        }
    }
    
    func iqamah(for prayer: Prayer) -> Date? {
        switch prayer {
        case .fajr:
            return iqamah.fajr
        case .shuruq:
            return nil
        case .dhuhr:
            return iqamah.dhuhr
        case .asr:
            return iqamah.asr
        case .maghrib:
            return iqamah.maghrib
        case .isha:
            return iqamah.isha
        }
    }
    
    var prayerTimes: [PrayerTime] {
        Prayer.allCases.map {
            prayerTime(for: $0)
        }
    }
    
    func prayerTime(for prayer: Prayer) -> PrayerTime {
        PrayerTime(prayer: prayer, adhan: adhan(for: prayer), iqamah: iqamah(for: prayer))
    }
    
    var hasTaraweeh: Bool {
        iqamah.taraweeh != nil
    }
    
    static func upcomingPrayer(prayerDays: [PrayerDay], time: Date = Date()) -> PrayerTime? {
        let times = prayerDays.flatMap { $0.prayerTimes }.sorted(comparingKeyPath: \.adhan)
        return times.first(where: { $0.adhan >= time })
    }
}

