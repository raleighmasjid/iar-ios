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
            ZStack {
                if current {
                    Image(systemName: "circlebadge.fill")
                        .resizable()
                        .frame(width: 6, height: 6)
                        .offset(x: -28, y: 0)
                }
                Text(prayerName)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 22, weight: .semibold))
            
            Text(adhanTime.formatted(date: .omitted, time: .shortened))
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 20, weight: .medium))
            
            Text(iqamahTime?.formatted(date: .omitted, time: .shortened) ?? " ")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.system(size: 20, weight: .medium))
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color.green.opacity(current ? 0.1 : 0))
        
        
    }
}

struct PrayerRow_Previews: PreviewProvider {
    static var previews: some View {
        PrayerRow(prayer: .fajr, prayerDay: .mock(), current: true)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
        PrayerRow(prayer: .dhuhr, prayerDay: .mock(), current: false)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
