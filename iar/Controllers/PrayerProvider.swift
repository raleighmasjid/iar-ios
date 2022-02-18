//
//  PrayerProvider.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import Foundation
import Combine

protocol PrayerProvider {
    
    typealias PrayerResult = Result<[PrayerDay], PrayerProviderError>
    
    var didUpdate: AnyPublisher<PrayerResult, Never> { get }
    func fetchPrayerTimes()
}


enum PrayerProviderError: Error {
    case networkFailure
}

class NetworkPrayerProvider: PrayerProvider {
    let session = URLSession.shared
    
    private let publisher = PassthroughSubject<PrayerResult, Never>()
    
    @StoredDefault(key: .prayerTimesCache, defaultValue: nil)
    private var cachedData: Data?

    func cachedPrayerTimes() -> [PrayerDay] {
        guard let data = cachedData,
        let prayerDays = try? PrayerDay.from(data: data) else {
            return []
        }
        
        return prayerDays.filter { Calendar.current.compare(Date(), to: $0.date, toGranularity: .day) != .orderedDescending }
    }
    
    var didUpdate: AnyPublisher<PrayerResult, Never> {
        publisher.receive(on: RunLoop.main).eraseToAnyPublisher()
    }
    
    func fetchPrayerTimes() {
        print(">> fetch")
        let cache = cachedPrayerTimes()
        if !cache.isEmpty {
            print(">> cache \(cache.map { $0.date })")
            publisher.send(.success(cache))
        }

        Task {
            do {
                let (data, _) = try await session.data(from: "https://raleighmasjid.org/API/app/prayer/")
                let prayerDays = try PrayerDay.from(data: data)
                cachedData = data
                publisher.send(.success(prayerDays))
            } catch {
                publisher.send(.failure(.networkFailure))
            }
        }
    }

}
