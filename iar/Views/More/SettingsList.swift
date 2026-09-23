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
    
    var body: some View {
        List {
            SettingsRowPicker(
                image: Image(.adhanSoundIcon),
                title: "Adhan Sound",
                selection: $notifications.type
            ) { $0.title }
            .listRowSeparator(.hidden, edges: .top)
            
            SettingsRowButton(image: Image(.notificationsIcons), title: "Notifications") {
                handleNotifications()
            }
            
            SettingsRowButton(image: Image(.fullWebsiteIcon), title: "View Full Website") {
                path.append(
                    WebLink(url: "https://raleighmasjid.org/", title: "Islamic Association of Raleigh")
                )
            }
            
            SettingsRowText(text: version())
                .listRowSeparator(.hidden, edges: .bottom)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
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
