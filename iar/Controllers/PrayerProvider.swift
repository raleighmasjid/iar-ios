//
//  PrayerProvider.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import Foundation
import Combine

typealias PrayerResult = Result<PrayerSchedule, PrayerProviderError>

protocol PrayerProviderDelegate: AnyObject {
    func didFetchPrayerSchedule(prayerResult: PrayerResult, cached: Bool)
}

protocol PrayerProvider: AnyObject {
    var delegate: PrayerProviderDelegate? { get set }
    func fetchPrayers() async
}

enum PrayerProviderError: Error {
    case networkFailure
}

class NetworkPrayerProvider: PrayerProvider {

    weak var delegate: PrayerProviderDelegate?
    
    let session = URLSession.shared

    @StoredDefault(key: .prayerScheduleCache, defaultValue: nil)
    private var cachedPrayerSchedule: PrayerSchedule?

    @MainActor
    func fetchPrayers() async {
        if let cached = cachedPrayerSchedule {
            delegate?.didFetchPrayerSchedule(prayerResult: .success(cached), cached: true)
        }

        do {
            let (data, _) = try await session.data(from: "https://raleighmasjid.org/API/app/prayer-schedule/")
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let schedule = try decoder.decode(PrayerSchedule.self, from: data)
            cachedPrayerSchedule = schedule
            delegate?.didFetchPrayerSchedule(prayerResult: .success(schedule), cached: false)
        } catch {
            delegate?.didFetchPrayerSchedule(prayerResult: .failure(.networkFailure), cached: false)
        }
    }
}
