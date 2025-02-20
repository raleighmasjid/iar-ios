//
//  StoredDefault.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/10/22.
//

import Foundation

@propertyWrapper
struct StoredDefault<T: Codable> {
    
    enum DefaultKey: String {
        case prayerScheduleCache
        case newsCache
        case viewedAnnouncements
    }
    
    let key: DefaultKey
    let defaultValue: T

    init(key: DefaultKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            guard let data = sharedUserDefaults.object(forKey: key.rawValue) as? Data else {
                return defaultValue
            }

            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        
        set {
            let data = try? JSONEncoder().encode(newValue)
            sharedUserDefaults.set(data, forKey: key.rawValue)
        }
    }
}

fileprivate let sharedUserDefaults: UserDefaults = UserDefaults(suiteName: "group.com.lemosys.IARMasjid")!
