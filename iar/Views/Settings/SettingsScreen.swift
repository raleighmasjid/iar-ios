//
//  SettingsScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/16/22.
//

import SwiftUI

struct SettingsScreen: View {
    @EnvironmentObject var notifications: NotificationSettings
    
    var body: some View {
        NavigationView {
            List {
                Picker("Notification Sound", selection: $notifications.type) {
                    ForEach(NotificationType.allCases, id:\.self) { type in
                        Text(type.title).tag(type)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}
