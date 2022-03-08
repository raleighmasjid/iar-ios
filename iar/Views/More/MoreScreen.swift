//
//  MoreScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/16/22.
//

import SwiftUI

struct MoreScreen: View {
    @EnvironmentObject var notifications: NotificationSettings
    
    var body: some View {
        List {
            Picker("Notification Sound", selection: $notifications.type) {
                ForEach(NotificationType.allCases, id:\.self) { type in
                    Text(type.title).tag(type)
                }
            }
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        MoreScreen()
            .environmentObject(NotificationSettings())
    }
}
