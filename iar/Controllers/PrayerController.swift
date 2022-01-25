//
//  PrayerController.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import Foundation

class PrayerController: ObservableObject {
    @Published var prayerDays: [PrayerDay] = []
    
    let session = URLSession.shared
    
    var current: PrayerDay? {
        prayerDays.first(where: {
            Calendar.current.isDateInToday($0.date)
        })
    }
    
    @MainActor
    func loadTimes() async {
        guard let url = URL(string: "https://raleighmasjid.org/API/prayer/app/") else {
            return
        }
        do {
            let (data, _) = try await session.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            prayerDays = try decoder.decode([PrayerDay].self, from: data)
        } catch {
            print("error loading prayer times \(error)")
        }
    }
}
