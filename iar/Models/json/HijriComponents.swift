//
//  HijriComponents.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import Foundation

struct HijriComponents: Codable, Equatable, Hashable {
    let monthName: String
    let day: Int
    let year: Int
    let month: Int
    
    enum CodingKeys: String, CodingKey {
        case monthName = "month"
        case day
        case year
        case month = "month_numeric"
    }
    
    func formatted() -> String {
        "\(monthName) \(day), \(year) h"
    }
}
