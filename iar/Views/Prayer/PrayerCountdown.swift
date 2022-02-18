//
//  PrayerCountdown.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import SwiftUI

struct PrayerCountdown: View {
    
    let upcoming: PrayerTime?
    let remaining: TimeInterval
    
    var countdown: String {
        guard let upcoming = upcoming else {
            return " "
        }

        return "\(upcoming.prayer.title) is in \(remaining.formattedInterval())"
    }
    
    var body: some View {
        Text(countdown)
            .font(.system(size: 22, weight: .medium))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.bottom, 2)
    }
    
   
}

#if DEBUG
struct PrayerCountdown_Previews: PreviewProvider {
    static var previews: some View {
        PrayerCountdown(upcoming: PrayerTime(prayer: .maghrib, adhan: Date().addingTimeInterval(600), iqamah: Date().addingTimeInterval(900)), remaining: 600)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
#endif
