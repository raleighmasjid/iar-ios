//
//  PrayerTimelineEntry.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/18/25.
//

import Foundation
import WidgetKit

struct PrayerTimelineEntry: TimelineEntry {
    let date: Date
    let prayerDay: PrayerDay
    let currentPrayer: PrayerTime?
    let nextPrayer: PrayerTime
    let isPlaceholder: Bool
    
    init(date: Date,
         prayerDay: PrayerDay,
         currentPrayer: PrayerTime?,
         nextPrayer: PrayerTime,
         isPlaceholder: Bool = false) {
        self.date = date
        self.prayerDay = prayerDay
        self.currentPrayer = currentPrayer
        self.nextPrayer = nextPrayer
        self.isPlaceholder = isPlaceholder
    }
    
    var description: String {
        let currentTime = currentPrayer?.adhan.formatted(date: .abbreviated, time: .shortened) ?? "-"
        let nextTime = nextPrayer.adhan.formatted(date: .abbreviated, time: .shortened)

        return """
        PrayerTimelineEntry
        Date: \(date.formatted(date: .abbreviated, time: .shortened))
        Current: \(currentPrayer?.prayer.title ?? "N/A") @ \(currentTime)
        Next: \(nextPrayer.prayer.title) @ \(nextTime)
        Prayer Day: \(prayerDay.date.formatted(date: .abbreviated, time: .omitted))
        """
    }
    
    static func entries(prayerSchedule: PrayerSchedule) -> [PrayerTimelineEntry] {
        var entries: [PrayerTimelineEntry] = []
        
        for (dayIndex, prayerDay) in prayerSchedule.prayerDays.enumerated() {
            var previousPrayerTime: PrayerTime? = nil
            for prayerTime in prayerDay.prayerTimes {
                let entry = switch prayerTime.prayer {
                case .fajr:
                    PrayerTimelineEntry(
                        date: Calendar.current.startOfDay(for: prayerDay.date),
                        prayerDay: prayerDay,
                        currentPrayer: nil,
                        nextPrayer: prayerTime
                    )
                default:
                    PrayerTimelineEntry(
                        date: previousPrayerTime?.adhan ?? .distantPast,
                        prayerDay: prayerDay,
                        currentPrayer: previousPrayerTime,
                        nextPrayer: prayerTime
                    )
                }
                entries.append(entry)
                
                previousPrayerTime = prayerTime
            }
            
            // post-isha countdown to tomorrow fajr
            if dayIndex < prayerSchedule.prayerDays.count - 1 {
                let tomorrow = prayerSchedule.prayerDays[dayIndex + 1]
                entries.append(
                    PrayerTimelineEntry(date: prayerDay.adhan(for: .isha),
                                        prayerDay: prayerDay,
                                        currentPrayer: prayerDay.prayerTime(for: .isha),
                                        nextPrayer: tomorrow.prayerTime(for: .fajr))
                )
            }
        }

        return entries.filter { $0.nextPrayer.adhan >= Date() }
    }
    
    static func snapshot(prayerSchedule: PrayerSchedule) -> PrayerTimelineEntry {
        entries(prayerSchedule: prayerSchedule).first ?? placeholder()
    }
    
    static func placeholder() -> PrayerTimelineEntry {
        let midnight = Calendar.current.startOfDay(for: Date())
        let fajr = Calendar.current.date(byAdding: DateComponents(hour: 6, minute: 36), to: midnight)!
        let shuruq = Calendar.current.date(byAdding: DateComponents(hour: 7, minute: 14), to: midnight)!
        let dhuhr = Calendar.current.date(byAdding: DateComponents(hour: 12, minute: 8), to: midnight)!
        let asr = Calendar.current.date(byAdding: DateComponents(hour: 15, minute: 15), to: midnight)!
        let maghrib = Calendar.current.date(byAdding: DateComponents(hour: 18, minute: 12), to: midnight)!
        let isha = Calendar.current.date(byAdding: DateComponents(hour: 20, minute: 40), to: midnight)!
        let prayerDay = PrayerDay(date: Date(),
                                  hijri: HijriComponents(monthName: "Ramadan", day: 1, year: 1443, month: 9),
                                  adhan: AdhanSchedule(fajr: fajr, shuruq: shuruq, dhuhr: dhuhr, asr: asr, maghrib: maghrib, isha: isha),
                                  iqamah: IqamahSchedule(
                                    fajr: fajr.addingTimeInterval(600),
                                    dhuhr: dhuhr.addingTimeInterval(600),
                                    asr: asr.addingTimeInterval(600),
                                    maghrib: maghrib.addingTimeInterval(600),
                                    isha: isha.addingTimeInterval(600),
                                    taraweeh: nil))

        return PrayerTimelineEntry(date: Date(),
                                   prayerDay: prayerDay,
                                   currentPrayer: PrayerTime(prayer: .asr, adhan: asr, iqamah: asr.addingTimeInterval(600)),
                                   nextPrayer: PrayerTime(prayer: .maghrib, adhan: maghrib, iqamah: maghrib.addingTimeInterval(600)),
                                   isPlaceholder: true)
    }
}
