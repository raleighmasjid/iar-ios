//
//  Formatter.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/2/22.
//

import Foundation

enum Formatter {
    static let dayFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d, y"
        return formatter
    }()
    
    static let timeFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
}

extension Date {
    func dayFormatted() -> String {
        Formatter.dayFormatter.string(from: self)
    }
    
    func timeFormatted() -> String {
        Formatter.timeFormatter.string(from: self)
    }
}
