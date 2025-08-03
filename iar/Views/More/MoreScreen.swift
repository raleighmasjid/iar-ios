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
    @State var footerHeight: CGFloat = 0
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                ScrollView {
                    SettingsList(path: $path)
                        .padding(.bottom, footerHeight)
                }
                
                SettingsFooter()
                    .onGeometryChange(for: CGFloat.self) { proxy in
                        proxy.size.height
                    } action: { newValue in
                        footerHeight = newValue
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .toolbarTitleDisplayMode(.inlineLarge)
            .navigationTitle("Settings")
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
