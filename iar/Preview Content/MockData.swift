//
//  MockData.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import Foundation
import Combine

#if DEBUG

class MockProvider: PrayerProvider {
    var cachedPrayerSchedule: PrayerSchedule? = nil
    
    func fetchPrayers() async throws -> PrayerSchedule {
        let days: [PrayerDay] = [.mock(), .mock(date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)]
        return PrayerSchedule(prayerDays: days, fridaySchedule: FridayPrayer.mocks())
    }
}

extension FridayPrayer {
    static func mocks() -> [FridayPrayer] {
        let json = """
        [
            {
              "title": "How Can I Help to Convey the Message of Islam Lorem Ipsum Dolor Sit Amet How Can I Help to Convey the Message of Islam Lorem Ipsum Dolor Sit Amet",
              "shift": "1st Shift",
              "time": "11:30",
              "speaker": "Imam Mohamed Badawy Ibn Rasheed Ibn Fadlan Ibn Ahmed",
              "description": "Religious Specialist - Imam at Islamic Association of Raleigh",
              "image_url": "https://raleighmasjid.org/wp-content/uploads/2021/05/badawy-logo.jpg"
            },
            {
              "title": "Da`wah: An Important Duty in Islam",
              "shift": "2nd Shift",
              "time": "1:00",
              "speaker": "Fiaz Fareed",
              "description": "Chairman of Outreach & Da'wah at IAR",
              "image_url": "https://raleighmasjid.org/wp-content/uploads/2021/05/brother-fiaz-fareed-smaller.png"
            },
            {
              "title": "Islam: What the World Needs",
              "shift": "3rd Shift",
              "time": "2:15",
              "speaker": "Mohammed Hannini",
              "description": "Islamic Sciences Instructor",
              "image_url": "https://raleighmasjid.org/wp-content/uploads/2021/05/Hanini.jpeg"
            }
          ]
        """
        return try! JSONDecoder().decode([FridayPrayer].self, from: json.data(using: .utf8)!)
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
        let adhan = AdhanSchedule(fajr: fajrDate,
                                  shuruq: shuruqDate,
                                  dhuhr: dhuhrDate,
                                  asr: asrDate,
                                  maghrib: maghribDate,
                                  isha: ishaDate)
        return PrayerDay(date: date, hijri: hijri, adhan: adhan, iqamah: iqamah)
    }
}

#endif
