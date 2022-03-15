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
    let showTaraweeh: Bool
    @EnvironmentObject var notifications: NotificationSettings
    
    var rowSpacing: CGFloat {
        UIScreen.isShort ? 8 : 12
    }
    
    var body: some View {
        VStack(spacing: rowSpacing) {
            ForEach(Prayer.allCases, id: \.self) { prayer in
                PrayerRow(prayer: prayer.title,
                          adhan: prayerDay?.adhan(for: prayer),
                          iqamah: prayerDay?.iqamah(for: prayer),
                          current: currentPrayer == prayer,
                          displayAlarm: true,
                          notificationEnabled: notifications.boundValue(for: prayer))
                    
            }
            
            if (showTaraweeh) {
                PrayerRow(prayer: "Taraweeh",
                          adhan: nil,
                          iqamah: prayerDay?.iqamah.taraweeh,
                          current: false,
                          displayAlarm: false,
                          notificationEnabled: .constant(false))
            }
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        
    }
}

#if DEBUG
struct PrayerDayView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerDayView(prayerDay: .mock(), currentPrayer: .asr, showTaraweeh: true)
            .environmentObject(NotificationSettings())
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
#endif
