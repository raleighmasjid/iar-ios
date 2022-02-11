//
//  StoredDefault.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/10/22.
//

import Foundation

@propertyWrapper
struct StoredDefault<T> {
    
    enum DefaultKey: String {
        case prayerTimesCache
    }
    
    let key: DefaultKey
    let defaultValue: T

    init(key: DefaultKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key.rawValue) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key.rawValue)
        }
    }
}
