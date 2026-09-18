//
//  SettingsList.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/17/25.
//

import SwiftUI
import UserNotifications

struct SettingsList: View {
    
    @Binding var path: [WebLink]
    @EnvironmentObject var notifications: NotificationSettings
    @Environment(\.openURL) private var openURL
    
    var rowDivider: some View {
        Divider()
            .overlay(.outline)
            .padding(.horizontal, 16)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SettingsPickerRow(image: Image(.adhanSoundIcon), title: "Adhan Sound") {
                Picker("Adhan Sound", selection: $notifications.type) {
                    ForEach(NotificationType.allCases, id:\.self) { type in
                        Text(type.title).tag(type)
                    }
                }
                .pickerStyle(.menu)
                .tint(.accent)
            }
            
            rowDivider
            
            Button {
                handleNotifications()
            } label: {
                SettingsRow(image: Image(.notificationsIcons), title: "Notifications")
            }
            .buttonStyle(RowButtonStyle())
            
            rowDivider
            
            Button {
                path.append(
                    WebLink(url: "https://raleighmasjid.org/", title: "Islamic Association of Raleigh")
                )
            } label: {
                SettingsRow(image: Image(.fullWebsiteIcon), title: "View Full Website")
            }
            .buttonStyle(RowButtonStyle())
            
            rowDivider
            
            Text(version())
            .padding(16)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.secondaryText)
            .font(.system(size: 11))
        }
    }
    
    func version() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        return "App version \(version) (\(build))"
    }
    
    
    func handleNotifications() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
                    print("Permission granted: \(granted)")
                }
            default:
                openURL(URL(string: UIApplication.openSettingsURLString)!)
            }
        }
    }
}

#Preview {
    SettingsList(path: .constant([]))
        .environmentObject(NotificationSettings())
        .background(.appBackground)
}
