//
//  PrayerRow.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import SwiftUI

struct PrayerRow: View {
    let prayerName: String
    let adhanTime: Date
    let iqamahTime: Date?
    let current: Bool
    
    init(prayer: Prayer, prayerDay: PrayerDay, current: Bool) {
        prayerName = prayer.title
        adhanTime = prayerDay.adhan(for: prayer)
        iqamahTime = prayerDay.iqamah(for: prayer)
        self.current = current
    }
    
    var body: some View {
        HStack() {
            ZStack(alignment: .leading) {
                if current {
                    Image(systemName: "circlebadge.fill")
                        .resizable()
                        .frame(width: 6, height: 6)
                        .offset(x: -12, y: 0)
                }
                Text(prayerName)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 22, weight: .semibold))
            
            Text(adhanTime.timeFormatted())
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 20, weight: .medium))
            
            Text(iqamahTime?.timeFormatted() ?? " ")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.system(size: 20, weight: .medium))
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color.green.opacity(current ? 0.1 : 0))
    }
}

#if DEBUG
struct PrayerRow_Previews: PreviewProvider {
    static var previews: some View {
        PrayerRow(prayer: .fajr, prayerDay: .mock(), current: true)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
        PrayerRow(prayer: .dhuhr, prayerDay: .mock(), current: true)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
        PrayerRow(prayer: .maghrib, prayerDay: .mock(), current: true)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
        PrayerRow(prayer: .dhuhr, prayerDay: .mock(), current: false)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
#endif
