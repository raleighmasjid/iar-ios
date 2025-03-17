//
//  SettingsList.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/17/25.
//

import SwiftUI
import OneSignalFramework

struct SettingsList: View {
    
    @Binding var path: [WebLink]
    @EnvironmentObject var notifications: NotificationSettings
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        VStack(spacing: 0) {
            SettingsPickerRow(image: Image(.adhanSoundIcon), title: "Adhan Sound") {
                Picker("Prayer Alert", selection: $notifications.type) {
                    ForEach(NotificationType.allCases, id:\.self) { type in
                        Text(type.title).tag(type)
                    }
                }
                .pickerStyle(.menu)
                .tint(.accent)
            }
            
            Divider()
                .overlay(.outline)
                .padding(.horizontal, 16)
            
            Button {
                if OneSignal.Notifications.canRequestPermission {
                    OneSignal.Notifications.requestPermission({ _ in }, fallbackToSettings: true)
                } else {
                    openURL(URL(string: UIApplication.openSettingsURLString)!)
                }
            } label: {
                SettingsRow(image: Image(.notificationsIcons), title: "Notifications")
            }
            .buttonStyle(RowButtonStyle())
            
            Divider()
                .overlay(.outline)
                .padding(.horizontal, 16)
            
            Button {
                path.append(
                    WebLink(url: "https://raleighmasjid.org/", title: "Islamic Association of Raleigh")
                )
            } label: {
                SettingsRow(image: Image(.fullWebsiteIcon), title: "View Full Website")
            }
            .buttonStyle(RowButtonStyle())
        }
    }
}

#Preview {
    SettingsList(path: .constant([]))
        .environmentObject(NotificationSettings())
        .background(.appBackground)
}
