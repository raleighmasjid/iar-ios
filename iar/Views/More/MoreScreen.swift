//
//  MoreScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/16/22.
//

import SwiftUI
import OneSignalFramework

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
            
            if !OneSignal.Notifications.permission {
                Section {
                    Button("Enable Notifications") {
                        OneSignal.Notifications.requestPermission({ accepted in
                            #if DEBUG
                            print("User accepted notifications: \(accepted)")
                            #endif
                        }, fallbackToSettings: true)
                    }
                }
            }
            
            Section(footer:
                VStack(alignment: .center) {
                    Text("The Islamic Association of Raleigh")
                    Text(version())
            }.frame(maxWidth: .infinity)
                .padding(.top, 50)
            ) {
                NavigationLink("App Feedback", destination: WebView(WebLink(url: "https://raleighmasjid.org/appfeedback", title: "App Feedback")))
                NavigationLink("Visit Full Website", destination: WebView(WebLink(url: "https://raleighmasjid.org", title: "IAR")))
            }
        }
    }
    
    func version() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        return "Version \(version) (\(build))"
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        MoreScreen()
            .environmentObject(NotificationSettings())
    }
}
