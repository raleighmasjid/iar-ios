//
//  PrayerWidget.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/18/25.
//

import WidgetKit
import SwiftUI

struct PrayerWidget: Widget {
    let kind: String = "PrayerWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PrayerTimelineProvider()) { entry in
            PrayerWidgetView(entry: entry)
        }
        .configurationDisplayName("Next Prayer")
        .description("Countdown until the next prayer")
        .supportedFamilies([.systemSmall, .systemMedium])
        .contentMarginsDisabled()
    }
}

//#Preview(as: .systemSmall) {
//    PrayerWidget()
//} timeline: {
//    PrayerTimelineEntry.placeholder()
//}
