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
    
    static let longIntervalFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        return formatter
    }()
    
    static let shortIntervalFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .pad
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

extension TimeInterval {
    func formattedInterval() -> String {
        if self > 60 * 60 {
            return Formatter.longIntervalFormatter.string(from: self) ?? ""
        } else {
            return Formatter.shortIntervalFormatter.string(from: self) ?? ""
        }
    }
}
