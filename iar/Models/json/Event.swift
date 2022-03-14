//
//  Event.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/8/22.
//

import Foundation

struct Event: Codable, Identifiable, Hashable, WebDestination {
    let id: Int
    let title: String
    let url: String
    let description: String
    let start: Date
    let end: Date
    let allDay: Bool
    let repeating: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, title, url, description, start, end, repeating
        case allDay = "all_day"
    }
}
