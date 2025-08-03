//
//  FridayPrayer.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/12/22.
//

import Foundation

enum Campus: String, Codable, Equatable, Hashable, CaseIterable {
    case atwater
    case page
    
    var name: String {
        switch self {
        case .atwater:
            "Atwater St"
        case .page:
            "Page Rd"
        }
    }
}

struct FridayPrayer: Codable, Equatable, Hashable {
    let title: String
    let shift: String
    let time: String
    let speaker: String
    let description: String
    let imageUrl: String
    let campus: Campus
    
    enum CodingKeys: String, CodingKey {
        case title
        case shift = "shift_name"
        case time
        case speaker
        case description
        case imageUrl = "image_url"
        case campus
    }
}
