//
//  QiblaMode.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 7/31/25.
//

import Foundation

enum QiblaMode: String, CaseIterable {
    case map
    case compass
    
    var title: String {
        switch self {
            case .map:
            return "Map"
        case .compass:
            return "Compass"
        }
    }
}
