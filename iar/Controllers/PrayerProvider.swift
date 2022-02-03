//
//  PrayerProvider.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import Foundation

protocol PrayerProvider {
    func fetchPrayerTimes() async -> [PrayerDay]
}

class NetworkPrayerProvider: PrayerProvider {
    let session = URLSession.shared
    
    @MainActor
    func fetchPrayerTimes() async -> [PrayerDay] {
        let url = URL(string: "https://raleighmasjid.org/API/prayer/app/")!
        do {
            let (data, _) = try await session.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode([PrayerDay].self, from: data)
        } catch {
            print("error loading prayer times \(error)")
            return []
        }
    }
}
