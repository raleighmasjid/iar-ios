//
//  MoreScreen.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/16/22.
//

import SwiftUI
import OneSignalFramework
import Contacts

struct MoreScreen: View {
    
    @State var path: [WebLink] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                ScrollView {
                    SettingsList(path: $path)
                }
                
                SettingsFooter()
            }
            .largeNavigationTitle("Settings")
            .background(.appBackground)
            .navigationDestination(for: WebLink.self) { webLink in
                WebView(webLink)
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
