//
//  PrayerWidgetSmallView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/19/25.
//

import SwiftUI
import WidgetKit

struct PrayerWidgetSmallView: View {
    let entry: PrayerTimelineEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            HijriView(components: entry.prayerDay.hijri)
            VStack(alignment: .leading) {
                Text("\(entry.nextPrayer.prayer.title) is in")
                    .scalingFont(size: 13, weight: .semibold)
                Text(entry.nextPrayer.adhan, style: .relative)
                    .scalingFont(size: 28, weight: .bold)
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                    .allowsTightening(true)
            }
            .frame(maxHeight: .infinity)
            HStack {
                Text(entry.nextPrayer.prayer.title)
                Spacer(minLength: 16)
                Text(entry.nextPrayer.adhan.formatted(date: .omitted, time: .shortened))
            }
            .scalingFont(size: 15, weight: .semibold)
            .allowsTightening(true)
            .minimumScaleFactor(0.5)
            .lineLimit(1)
        }
        .foregroundStyle(.white)
        .padding(16)
    }
}

#Preview(as: .systemSmall) {
    PrayerWidget()
} timeline: {
    PrayerTimelineEntry.placeholder()
}
