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
    
    var body: some View {
        VStack(spacing: 0) {
            columnHeaders
            
            ForEach(Prayer.allCases, id: \.self) { prayer in
                Divider()
                    .overlay(.outline)
                    .padding(.horizontal, 16)
                    
                PrayerRow(prayer: prayer.title,
                          adhan: prayerDay?.adhan(for: prayer),
                          iqamah: prayerDay?.iqamah(for: prayer),
                          current: currentPrayer == prayer,
                          displayAlarm: true,
                          notificationEnabled: notifications.boundValue(for: prayer))
            }
            
            if (showTaraweeh) {
                Divider()
                    .overlay(.outline)
                    .padding(.horizontal, 16)
                    
                PrayerRow(prayer: "Taraweeh",
                          adhan: nil,
                          iqamah: prayerDay?.iqamah.taraweeh,
                          current: false,
                          displayAlarm: false,
                          notificationEnabled: .constant(false))
                    .opacity(prayerDay?.iqamah.taraweeh == nil ? 0.7 : 1.0)
            }
        }
        .frame(maxWidth: .infinity)
        
    }
    
    var columnHeaders: some View {
        HStack(spacing: 0) {
            Text("Prayer")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Adhan")
                .frame(maxWidth: .infinity, alignment: .center)
            Text("Iqamah")
                .frame(maxWidth: .infinity, alignment: .trailing)
            Spacer().frame(width: 52)
        }
        .padding(.vertical, 18)
        .padding(.horizontal, 16)
        .scalingFont(size: 17, weight: .semibold, maxSize: 23)
        .lineLimit(1)
    }
}

#if DEBUG
#Preview {
    PrayerDayView(prayerDay: .mock(), currentPrayer: .asr, showTaraweeh: true)
        .environmentObject(NotificationSettings())
}
#endif
