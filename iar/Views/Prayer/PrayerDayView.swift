//
//  PrayerDayView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import SwiftUI

struct PrayerDayView: View {
    let prayerDay: PrayerDay?
    let currentPrayer: Prayer?
    @EnvironmentObject var notifications: NotificationSettings

    init(prayerDay: PrayerDay?) {
        print(">> init PrayerDayView for \(String(describing: prayerDay?.date))")
        self.prayerDay = prayerDay
        self.currentPrayer = prayerDay?.currentPrayer()
    }
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(Prayer.allCases, id: \.self) { prayer in
                PrayerRow(prayer: prayer,
                          adhan: prayerDay?.adhan(for: prayer),
                          iqamah: prayerDay?.iqamah(for: prayer),
                          current: currentPrayer == prayer,
                          notificationEnabled: notifications.boundValue(for: prayer))
                    .padding(.horizontal, 16)
            }
        }
        .frame(maxWidth: .infinity)
        
    }
}

#if DEBUG
struct PrayerDayView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerDayView(prayerDay: .mock())
            .environmentObject(NotificationSettings())
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
#endif