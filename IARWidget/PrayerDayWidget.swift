//
//  PrayerDayWidget.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/19/25.
//

import WidgetKit
import SwiftUI

struct PrayerDayWidget: Widget {
    let kind: String = "PrayerDayWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PrayerDayTimelineProvider()) { entry in
            PrayerWidgetView(entry: entry)
        }
        .configurationDisplayName("Prayer Times")
        .description("View today's prayer times")
        .supportedFamilies([.systemMedium])
        .contentMarginsDisabled()
    }
}

#Preview(as: .systemMedium) {
    PrayerDayWidget()
} timeline: {
    PrayerTimelineEntry.placeholder()
}
