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
        Form {
            Section {
                Picker("Prayer Alert", selection: $notifications.type) {
                    ForEach(NotificationType.allCases, id:\.self) { type in
                        Text(type.title).tag(type)
                    }
                }
            }
            
            Section {
                Link("Visit Full Website", destination: URL(string: "https://raleighmasjid.org")!)
                    .foregroundColor(.primary)
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
