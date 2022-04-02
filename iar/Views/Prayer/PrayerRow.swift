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
        current ? Color.Theme.prayerBackground : .clear
    }
    
    var borderColor: Color {
        current ? Color.Theme.prayerBorderCurrent : Color.Theme.prayerBorder
    }
    
    var rowOpacity: CGFloat {
        guard let adhan = adhan,
              (current || adhan >= Date()) else {
                  return 0.9
              }

        return 1
    }
    
    var body: some View {
        HStack() {
            Text(prayer)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: titleSize, weight: .semibold))
            .minimumScaleFactor(0.5)
            .lineLimit(1)
            
            Text(adhanFormatted)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: timeSize, weight: .medium))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            
            Text(iqamahFormatted)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.system(size: timeSize, weight: .medium))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            
            Toggle("Alarm", isOn: $notificationEnabled)
                .toggleStyle(.alarm)
                .frame(width: 48, height: alarmHeight)
                .padding(.vertical, verticalPadding)
                .opacity(displayAlarm ? 1.0 : 0.0)
                .disabled(!displayAlarm)
            
        }
        .padding(.leading, 12)
        .background(bgColor)
        .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: 1.0))
        .cornerRadius(8)
        .opacity(rowOpacity)
    }
    
    var alarmHeight: CGFloat {
        UIScreen.isTiny ? 16 : 18
    }
    
    var verticalPadding: CGFloat {
        UIScreen.isTiny ? 10 : 15
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
        PrayerRow(prayer: Prayer.fajr.title,
                  adhan: Date(),
                  iqamah: Date().addingTimeInterval(600),
                  current: true,
                  displayAlarm: true,
                  notificationEnabled: .constant(true))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
        PrayerRow(prayer: Prayer.dhuhr.title,
                  adhan: nil,
                  iqamah: nil,
                  current: false,
                  displayAlarm: true,
                  notificationEnabled: .constant(false))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
        PrayerRow(prayer: Prayer.maghrib.title,
                  adhan: Date(),
                  iqamah: Date().addingTimeInterval(600),
                  current: false,
                  displayAlarm: true,
                  notificationEnabled: .constant(true))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
#endif
