//
//  PrayerDayTimelineProvider.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/19/25.
//

import Foundation
import WidgetKit

struct PrayerDayTimelineProvider: TimelineProvider {
    let networkPrayerProvider = NetworkPrayerProvider()
    
    func placeholder(in context: Context) -> PrayerTimelineEntry {
        PrayerTimelineEntry.placeholder()
    }

    func getSnapshot(in context: Context, completion: @escaping (PrayerTimelineEntry) -> ()) {
        if context.isPreview {
            completion(PrayerTimelineEntry.placeholder())
            return
        }
        Task {
            do {
                let prayerSchedule = try await networkPrayerProvider.fetchPrayers()
                completion(PrayerTimelineEntry.snapshot(prayerSchedule: prayerSchedule))
            } catch {
                completion(PrayerTimelineEntry.placeholder())
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            do {
                let prayerSchedule = try await networkPrayerProvider.fetchPrayers()
                completion(Timeline(entries: PrayerTimelineEntry.dayEntries(prayerSchedule: prayerSchedule), policy: .atEnd))
            } catch {
                completion(Timeline(entries: [], policy: .after(Date().addingTimeInterval(60 * 5))))
            }
        }
    }
}
