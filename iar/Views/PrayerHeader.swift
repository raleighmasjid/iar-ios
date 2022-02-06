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
    
    var countdown: String {
        guard let upcoming = upcoming else {
            return " "
        }

        return "\(upcoming.prayer.title) is in \(remaining.formattedInterval())"
    }
    
    var date: String {
        guard let prayerDay = prayerDay else {
            return "Loading..."
        }

        return Formatter.dayFormatter.string(from: prayerDay.date)
    }
    
    var hijri: String {
        guard let prayerDay = prayerDay else {
            return " "
        }

        return prayerDay.hijri.formatted()
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(countdown)
                    .font(.system(size: 22, weight: .medium))
                VStack(alignment: .leading, spacing: 2) {
                    Text(date)
                    Text(hijri)
                        .italic()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
        }
    }
    
   
}

#if DEBUG
struct PrayerHeader_Previews: PreviewProvider {
    static var previews: some View {
        PrayerHeader(prayerDay: PrayerDay.mock(), upcoming: PrayerTime(prayer: .maghrib, adhan: Date().addingTimeInterval(600), iqamah: Date().addingTimeInterval(900)), remaining: 600)
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
#endif
