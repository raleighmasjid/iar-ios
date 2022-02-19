//
//  PrayerProvider.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import Foundation
import Combine

protocol PrayerProvider {
    typealias PrayerResult = Result<PrayerProviderData, PrayerProviderError>
    
    var didUpdate: AnyPublisher<PrayerResult, Never> { get }
    
    func fetchFridaySchedule()
    func fetchPrayers()
}

enum PrayerProviderError: Error {
    case networkFailure
}

enum PrayerProviderData {
    case prayerDays([PrayerDay])
    case fridaySchedule([FridayPrayer])
}

class NetworkPrayerProvider: PrayerProvider {
    let session = URLSession.shared
    
    private let publisher = PassthroughSubject<PrayerResult, Never>()
    
    @StoredDefault(key: .prayerTimesCache, defaultValue: [])
    private var cachedPrayerTimes: [PrayerDay]
    
    @StoredDefault(key: .fridayScheduleCache, defaultValue: [])
    private var cachedFridaySchedule: [FridayPrayer]

    
    var didUpdate: AnyPublisher<PrayerResult, Never> {
        publisher.receive(on: RunLoop.main).eraseToAnyPublisher()
    }

    func fetchPrayers() {
        let cached = cachedPrayerTimes
        if !cached.isEmpty {
            let validCache = cached.filter { Calendar.current.compare(Date(), to: $0.date, toGranularity: .day) != .orderedDescending }
            publisher.send(.success(.prayerDays(validCache)))
        }

        Task {
            do {
                let (prayerData, _) = try await session.data(from: "https://raleighmasjid.org/API/app/prayer/")
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let prayerDays = try decoder.decode([PrayerDay].self, from: prayerData)
                cachedPrayerTimes = prayerDays
                publisher.send(.success(.prayerDays(prayerDays)))
            } catch {
                publisher.send(.failure(.networkFailure))
            }
        }
    }
    
    func fetchFridaySchedule() {
        let cached = cachedFridaySchedule
        if !cached.isEmpty {
            publisher.send(.success(.fridaySchedule(cached)))
        }

        Task {
            do {
                let (fridayScheduleData, _) = try await session.data(from: "https://raleighmasjid.org/API/app/friday-schedule/")
                let fridaySchedule = try JSONDecoder().decode([FridayPrayer].self, from: fridayScheduleData)
                cachedFridaySchedule = fridaySchedule
                publisher.send(.success(.fridaySchedule(fridaySchedule)))
            } catch {
                publisher.send(.failure(.networkFailure))
            }
        }
    }

}
