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
        self.prayerDay = prayerDay
        self.currentPrayer = prayerDay?.currentPrayer()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            columnHeaders
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
    
    var columnHeaders: some View {
        HStack() {
            Text("Prayer")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Adhan")
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text("Iqamah")
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            Spacer().frame(width: 43)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .font(.system(size: 16, weight: .regular))
        .foregroundColor(.white)
        .background(Color.Theme.darkGreen)
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
