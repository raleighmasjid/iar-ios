//
//  News.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/8/22.
//

import Foundation

struct News: Codable {
    let announcements: Announcements
    var cacheDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case announcements = "announcements"
        case cacheDate = "cache_date"
    }
    
    var isValidCache: Bool {
        guard let cacheTimestamp = cacheDate else {
            return false
        }
        let cacheInterval = Date().timeIntervalSince(cacheTimestamp)
        
        // 5 minute cache lifetime
        return cacheInterval < 5 * 60
    }
}
