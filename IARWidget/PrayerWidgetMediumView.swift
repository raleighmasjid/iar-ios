//
//  PrayerWidgetMediumView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/19/25.
//

import SwiftUI
import WidgetKit

struct PrayerWidgetMediumView: View {
    let entry: PrayerTimelineEntry
    
    @ViewBuilder func listPrayers(_ prayers: [Prayer]) -> some View {
        VStack(spacing: 0) {
            ForEach(prayers, id: \.self) { prayer in
                HStack {
                    Text(prayer.title)
                    Spacer(minLength: 20)
                    Text(entry.prayerDay.adhan(for: prayer).formatted(date: .omitted, time: .shortened))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(prayerColor(prayer))
                .lineLimit(1)
                .allowsTightening(true)
                .minimumScaleFactor(0.5)
            }
            
        }
    }
    
    func prayerColor(_ prayer: Prayer) -> Color {
        if prayer == entry.currentPrayer?.prayer {
            return .currentPrayer
        } else if (entry.prayerDay.adhan(for: prayer) < Date()) {
            return .white.opacity(0.5)
        } else {
            return .white
        }
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("\(entry.nextPrayer.prayer.title) is in")
                        .font(.system(size: 13, weight: .semibold))
                    Text(entry.nextPrayer.adhan, style: .relative)
                        .font(.system(size: 20, weight: .semibold))
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                        .allowsTightening(true)
                }
                .padding(.top, 4)
                .foregroundStyle(.white)
                Spacer()
                HijriView(components: entry.prayerDay.hijri)
            }
            
            HStack(spacing: 14) {
                listPrayers([.fajr, .shuruq, .dhuhr])
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Divider()
                    .frame(minWidth: 1)
                    .overlay(.white.opacity(0.25))
                    
                listPrayers([.asr, .maghrib, .isha])
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding([.horizontal, .bottom], 16)
        .padding(.top, 12)
    }
}

#Preview(as: .systemMedium) {
    PrayerWidget()
} timeline: {
    PrayerTimelineEntry.placeholder()
}
