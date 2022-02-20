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
    }
    
    let key: DefaultKey
    let defaultValue: T

    init(key: DefaultKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.object(forKey: key.rawValue) as? Data else {
                return defaultValue
            }

            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key.rawValue)
        }
    }
}
