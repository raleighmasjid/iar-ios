//
//  PrayerHeader.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import SwiftUI

struct PrayerHeader: View {
    
    let prayerDay: PrayerDay?
    let upcoming: PrayerTime?
    let remaining: TimeInterval
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                if let upcoming = upcoming {
                    Text("\(upcoming.prayer.title) is in \(remaining.formattedInterval())")
                        .font(.system(size: 22, weight: .medium))
                }
                VStack(alignment: .leading, spacing: 2) {
                    if let prayerDay = prayerDay {
                        Text(Formatter.dayFormatter.string(from: prayerDay.date))
                        Text(prayerDay.hijri.formatted())
                            .italic()
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            
            columnHeaders
        }
    }
    
    var columnHeaders: some View {
        HStack() {
            Text("Prayer")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Adhan")
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text("Iqamah")
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .font(.system(size: 16, weight: .regular))
        .foregroundColor(.white)
        .background(Color.Theme.darkGreen)
    }
}

#if DEBUG
struct PrayerHeader_Previews: PreviewProvider {
    static var previews: some View {
        PrayerHeader(prayerDay: PrayerDay.mock(), upcoming: PrayerTime(prayer: .maghrib, adhan: Date().addingTimeInterval(600), iqamah: Date().addingTimeInterval(900)), remaining: 600)
            .previewLayout(PreviewLayout.sizeThatFits)
        PrayerHeader(prayerDay: nil, upcoming: nil, remaining: 0)
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
#endif
