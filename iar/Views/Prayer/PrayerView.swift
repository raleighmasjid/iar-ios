//
//  PrayerView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import SwiftUI

struct PrayerView: View {
    let prayerDay: PrayerDay?
    let currentPrayer: Prayer?
    @EnvironmentObject var notifications: NotificationSettings

    init(prayerDay: PrayerDay?) {
        print(">> init prayerview")
        self.prayerDay = prayerDay
        self.currentPrayer = prayerDay?.currentPrayer()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(Prayer.allCases, id: \.self) { prayer in
                PrayerRow(prayer: prayer,
                          adhan: prayerDay?.adhan(for: prayer),
                          iqamah: prayerDay?.iqamah(for: prayer),
                          current: currentPrayer == prayer,
                          notificationEnabled: notifications.boundValue(for: prayer))
            }
        }
        .frame(maxWidth: .infinity)
        
    }
}

#if DEBUG
struct PrayerView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerView(prayerDay: .mock())
            .environmentObject(NotificationSettings())
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
#endif
