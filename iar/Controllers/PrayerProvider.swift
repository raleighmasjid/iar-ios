//
//  PrayerProvider.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import Foundation
import Combine

protocol PrayerProvider: AnyObject {
    var cachedPrayerSchedule: PrayerSchedule? { get }
    func fetchPrayers(forceRefresh: Bool) async throws -> PrayerSchedule
}

class NetworkPrayerProvider: PrayerProvider {
    let session = URLSession.shared

    @StoredDefault(key: .prayerScheduleCache, defaultValue: nil)
    private(set) var cachedPrayerSchedule: PrayerSchedule?

    @MainActor
    func fetchPrayers(forceRefresh: Bool = false) async throws -> PrayerSchedule {
        if let cache = cachedPrayerSchedule, let cacheDate = cache.cacheDate, !forceRefresh {
            // 5 minute cache lifetime
            let cacheInterval = Date().timeIntervalSince(cacheDate)
            if cacheInterval < 60 * 5 {
                return cache
            }
        }

        let (data, _) = try await session.data(from: "https://raleighmasjid.org/API/app/prayer-schedule/")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        var schedule = try decoder.decode(PrayerSchedule.self, from: data)
        schedule.cacheDate = Date()
        cachedPrayerSchedule = schedule
        return schedule
    }
}
