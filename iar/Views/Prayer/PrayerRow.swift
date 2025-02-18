//
//  PrayerRow.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import SwiftUI

struct PrayerRow: View {
    let prayer: String
    let adhan: Date?
    let iqamah: Date?
    let current: Bool
    let displayAlarm: Bool
    @Binding var notificationEnabled: Bool
    
    var adhanFormatted: String {
        adhan?.timeFormatted() ?? " "
    }
    
    var iqamahFormatted: String {
        iqamah?.timeFormatted() ?? " "
    }
    
    var bgColor: Color {
        current ? Color(.prayerBackground) : .clear
    }
    
    var textColor: Color {
        current ? Color.action : Color.primary
    }
    
    var body: some View {
        HStack() {
            Text(prayer)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 17, weight: .semibold))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            
            Text(adhanFormatted)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 17, weight: .regular))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            
            Text(iqamahFormatted)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.system(size: 17, weight: .regular))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            
            Toggle("Alarm", isOn: $notificationEnabled)
                .toggleStyle(.alarm)
                .frame(width: 52, height: 18)
                .padding(.vertical, 18)
                .opacity(displayAlarm ? 1.0 : 0.0)
                .disabled(!displayAlarm)
        }
        .padding(.leading, 16)
        .background(bgColor)
        .foregroundStyle(textColor)
    }
}

#if DEBUG
#Preview {
    PrayerRow(prayer: Prayer.fajr.title,
              adhan: Date(),
              iqamah: Date().addingTimeInterval(600),
              current: true,
              displayAlarm: true,
              notificationEnabled: .constant(true))
}

#Preview {
    PrayerRow(prayer: Prayer.dhuhr.title,
              adhan: nil,
              iqamah: nil,
              current: false,
              displayAlarm: true,
              notificationEnabled: .constant(false))
}

#Preview {
    PrayerRow(prayer: Prayer.maghrib.title,
              adhan: Date(),
              iqamah: Date().addingTimeInterval(600),
              current: false,
              displayAlarm: true,
              notificationEnabled: .constant(true))
}
#endif
