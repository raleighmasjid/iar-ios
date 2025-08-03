//
//  MapDisplayStyle.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 7/31/25.
//

import SwiftUI
import MapKit

enum MapDisplayStyle {
    case hybrid
    case standard
    
    var mapStyle: MapStyle {
        switch self {
        case .hybrid:
            return .hybrid
        case .standard:
            return .standard
        }
    }
    
    var symbolName: String {
        switch self {
        case .hybrid:
            "globe.americas.fill"
        case .standard:
            "map.fill"
        }
    }
    
    mutating func toggle() {
        switch self {
        case .hybrid:
            self = .standard
        case .standard:
            self = .hybrid
        }
    }
}
