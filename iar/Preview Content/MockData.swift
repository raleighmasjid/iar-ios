//
//  MockData.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import Foundation

#if DEBUG

class MockProvider: PrayerProvider {
    func fetchPrayerTimes() async -> [PrayerDay] {
        return [.mock(), .mock(date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)]
    }
}

extension PrayerDay {
    static func mock(date: Date = Date()) -> PrayerDay {
        let hijri = HijriComponents(monthName: "Ramadan", day: 23, year: 1443, month: 9)
        let comps = Calendar.current.dateComponents([.year, .month, .day], from: date)
        var fajr = comps
        fajr.hour = 5
        fajr.minute = 38
        var shuruq = comps
        shuruq.hour = 6
        shuruq.minute = 45
        var dhuhr = comps
        dhuhr.hour = 12
        dhuhr.minute = 24
        var asr = comps
        asr.hour = 15
        asr.minute = 11
        var maghrib = comps
        maghrib.hour = 20
        maghrib.minute = 36
        var isha = comps
        isha.hour = 21
        isha.minute = 4
        
        let fajrDate = Calendar.current.date(from: fajr)!
        let shuruqDate = Calendar.current.date(from: shuruq)!
        let dhuhrDate = Calendar.current.date(from: dhuhr)!
        let asrDate = Calendar.current.date(from: asr)!
        let maghribDate = Calendar.current.date(from: maghrib)!
        let ishaDate = Calendar.current.date(from: isha)!
        
        let iqamah = IqamahSchedule(fajr: fajrDate.addingTimeInterval(600),
                                    dhuhr: dhuhrDate.addingTimeInterval(600),
                                    asr: asrDate.addingTimeInterval(600),
                                    maghrib: maghribDate.addingTimeInterval(600),
                                    isha: ishaDate.addingTimeInterval(600),
                                    taraweeh: nil)
        let adhan = AdhanSchedule(fajr: fajrDate, shuruq: shuruqDate, dhuhr: dhuhrDate, asr: asrDate, maghrib: maghribDate, isha: ishaDate)
        return PrayerDay(date: date, hijri: hijri, adhan: adhan, iqamah: iqamah)
    }
}

#endif
