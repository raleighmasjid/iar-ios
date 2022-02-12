//
//  PrayerProvider.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import Foundation
import Combine

protocol PrayerProvider {
    var didUpdate: AnyPublisher<[PrayerDay], Never> { get }
    func fetchPrayerTimes()
}

class NetworkPrayerProvider: PrayerProvider {
    let session = URLSession.shared
    
    private let publisher = PassthroughSubject<[PrayerDay], Never>()
    
    @StoredDefault(key: .prayerTimesCache, defaultValue: nil)
    private var cachedData: Data?
    
    func cachedPrayerTimes() -> [PrayerDay] {
        guard let data = cachedData else {
            return []
        }
        
        return PrayerDay.from(data: data)
    }
    
    var didUpdate: AnyPublisher<[PrayerDay], Never> {
        publisher.receive(on: RunLoop.main).eraseToAnyPublisher()
    }
    
    func fetchPrayerTimes() {
        let cache = cachedPrayerTimes()
        if !cache.isEmpty {
            publisher.send(cache)
        }
        Task {
            do {
                let (data, _) = try await session.data(from: "https://raleighmasjid.org/API/app/prayer/")
                cachedData = data
                publisher.send(PrayerDay.from(data: data))
            } catch {
                print("error loading prayer times \(error)")
                publisher.send([])
            }
        }
    }

}
