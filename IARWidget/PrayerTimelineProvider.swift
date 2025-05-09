//
//  PrayerTimelineProvider.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/18/25.
//

import Foundation
import WidgetKit

struct PrayerTimelineProvider: TimelineProvider {
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
                let prayerSchedule = try await networkPrayerProvider.fetchPrayers(forceRefresh: false)
                completion(PrayerTimelineEntry.snapshot(prayerSchedule: prayerSchedule))
            } catch {
                completion(PrayerTimelineEntry.placeholder())
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            do {
                let prayerSchedule = try await networkPrayerProvider.fetchPrayers(forceRefresh: false)
                completion(Timeline(entries: PrayerTimelineEntry.entries(prayerSchedule: prayerSchedule), policy: .atEnd))
            } catch {
                completion(Timeline(entries: [], policy: .after(Date().addingTimeInterval(60 * 5))))
            }
        }
    }
}
