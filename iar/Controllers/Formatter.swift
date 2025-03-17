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
        formatter.timeZone = TimeZone(identifier: "America/New_York")
        return formatter
    }()
    
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.timeZone = TimeZone(identifier: "America/New_York")
        return formatter
    }()
}

extension Calendar {
    static let zonedCalendar: Calendar = {
        var cal = Calendar(identifier: .gregorian)
        if let zone = TimeZone(identifier: "America/New_York") {
            cal.timeZone = zone
        }
        return cal
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
