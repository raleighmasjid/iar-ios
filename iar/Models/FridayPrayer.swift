//
//  FridayPrayer.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/12/22.
//

import Foundation

struct FridayPrayer: Codable, Equatable, Hashable {
    let title: String
    let shift: String
    let time: String
    let speaker: String
    let description: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case shift
        case time
        case speaker
        case description
        case imageUrl = "image_url"
    }
}
