//
//  SpecialAnnouncement.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/8/22.
//

import Foundation

struct SpecialAnnouncement: Codable, Equatable, WebDestination {
    let id: Int
    let title: String
    let date: Date
    let url: String
    let text: String
}

