//
//  PrayerProvider.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import Foundation
import SwiftUI

protocol PrayerProvider {
    func cachedPrayerTimes() -> [PrayerDay]
    func fetchPrayerTimes() async -> [PrayerDay]
}

class NetworkPrayerProvider: PrayerProvider {
    let session = URLSession.shared
    
    @StoredDefault(key: .prayerTimesCache, defaultValue: nil)
    var cachedData: Data?
    
    func cachedPrayerTimes() -> [PrayerDay] {
        guard let data = cachedData else {
            return []
        }
        
        return PrayerDay.from(data: data)
    }
    
    @MainActor
    func fetchPrayerTimes() async -> [PrayerDay] {
        do {
            let (data, _) = try await session.data(from: "https://raleighmasjid.org/API/app/prayer/")
            cachedData = data
            return PrayerDay.from(data: data)
        } catch {
            print("error loading prayer times \(error)")
            return []
        }
    }
}
