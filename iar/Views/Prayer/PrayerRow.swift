//
//  PrayerRow.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import SwiftUI

struct PrayerRow: View {
    let prayer: Prayer
    let adhan: Date?
    let iqamah: Date?
    let current: Bool
    @Binding var notificationEnabled: Bool
    
    var adhanFormatted: String {
        adhan?.timeFormatted() ?? "-:--"
    }
    
    var iqamahFormatted: String {
        iqamah?.timeFormatted() ?? " "
    }
    
    var body: some View {
        HStack() {
            ZStack(alignment: .leading) {
                Image(systemName: "circlebadge.fill")
                    .resizable()
                    .frame(width: 6, height: 6)
                    .offset(x: -12, y: 0)
                    .opacity(current ? 1 : 0)
                Text(prayer.title)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: titleSize, weight: .semibold))
            
            Text(adhanFormatted)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: timeSize, weight: .medium))
            
            Text(iqamahFormatted)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.system(size: timeSize, weight: .medium))
            
            Toggle("Alarm", isOn: $notificationEnabled)
                .toggleStyle(.alarm)
                .frame(width: 35, height: 16, alignment: .trailing)
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color.green.opacity(current ? 0.1 : 0))
    }
    
    var timeSize: CGFloat {
        UIScreen.isTiny ? 15 : 17
    }
    
    var titleSize: CGFloat {
        UIScreen.isTiny ? 16 : 19
    }
}

#if DEBUG
struct PrayerRow_Previews: PreviewProvider {
    static var previews: some View {
        PrayerRow(prayer: .fajr,
                  adhan: Date(),
                  iqamah: Date().addingTimeInterval(600),
                  current: true,
                  notificationEnabled: .constant(true))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
        PrayerRow(prayer: .dhuhr,
                  adhan: nil,
                  iqamah: nil,
                  current: false,
                  notificationEnabled: .constant(false))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
        PrayerRow(prayer: .maghrib,
                  adhan: Date(),
                  iqamah: Date().addingTimeInterval(600),
                  current: false,
                  notificationEnabled: .constant(true))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
#endif
