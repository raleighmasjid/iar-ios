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
    
    var bgColor: Color {
        current ? .tertiaryContainer : .clear
    }
    
    var textColor: Color {
        current ? .accent : .primaryText
    }
    
    var body: some View {
        HStack {
            HStack {
                Text(prayer)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .scalingFont(size: 17, weight: .semibold, maxSize: 24)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                
                Group {
                    if let adhan = adhan {
                        Text(adhan.formatted(date: .omitted, time: .shortened))
                    } else {
                        Text(" ")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .scalingFont(size: 17, weight: .regular, maxSize: 22)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                
                Group {
                    if let iqamah = iqamah {
                        Text(iqamah.formatted(date: .omitted, time: .shortened))
                    } else {
                        Text(" ")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .scalingFont(size: 17, weight: .regular, maxSize: 22)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            }
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            
            Toggle("Alarm", isOn: $notificationEnabled)
                .toggleStyle(.alarm)
                .frame(width: 52)
                .frame(maxHeight: .infinity)
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
