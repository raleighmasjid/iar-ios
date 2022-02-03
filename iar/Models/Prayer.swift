//
//  Prayer.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import Foundation

enum Prayer: CaseIterable {
    case fajr
    case shuruq
    case dhuhr
    case asr
    case maghrib
    case isha
    
    var title: String {
        switch self {
        case .fajr:
            return "Fajr"
        case .shuruq:
            return "Shuruq"
        case .dhuhr:
            return "Dhuhr"
        case .asr:
            return "Asr"
        case .maghrib:
            return "Maghrib"
        case .isha:
            return "Isha"
        }
    }
}
