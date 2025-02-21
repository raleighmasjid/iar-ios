//
//  PrayerWidgetView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/18/25.
//

import SwiftUI
import WidgetKit

struct PrayerWidgetView: View {
    @Environment(\.widgetFamily) var family
    let entry: PrayerTimelineEntry
    
    var body: some View {
        VStack(spacing: 0) {
            switch family {
            case .systemMedium:
                PrayerWidgetMediumView(entry: entry)
            default:
                PrayerWidgetSmallView(entry: entry)
            }
        }
        .widgetBackground {
            LinearGradient(colors: [.gradientStart, .gradientEnd], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

//#Preview(as: .systemSmall) {
//    PrayerWidget()
//} timeline: {
//    PrayerTimelineEntry.placeholder()
//}
//
//#Preview(as: .systemMedium) {
//    PrayerWidget()
//} timeline: {
//    PrayerTimelineEntry.placeholder()
//}
