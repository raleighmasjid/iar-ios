//
//  NewsSection.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/12/22.
//

import Foundation

enum NewsSection: String, CaseIterable, Identifiable {
    case announcements
    case events
    
    var title: String {
        switch self {
        case .announcements:
            return "Announcements"
        case .events:
            return "Events"
        }
    }
    
    var id: String { rawValue }
}
