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

extension TimeInterval {
    func formattedInterval() -> String {
        if self > 60 * 60 {
            return Formatter.longIntervalFormatter.string(from: self) ?? ""
        } else {
            return Formatter.shortIntervalFormatter.string(from: self) ?? ""
        }
    }
}
