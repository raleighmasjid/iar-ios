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
    @State var settingsSize: CGSize = .zero
    @State var footerSize: CGSize = .zero
    @State var screenSize: CGSize = .zero
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(spacing: 0) {
                    SettingsList(path: $path)
                        .onGeometryChange(for: CGSize.self) { proxy in
                            proxy.size
                        } action: { newValue in
                            settingsSize = newValue
                        }

                    Spacer()
                        .frame(height: max(0, screenSize.height - (settingsSize.height + footerSize.height)))
                    
                    SettingsFooter()
                        .onGeometryChange(for: CGSize.self) { proxy in
                            proxy.size
                        } action: { newValue in
                            footerSize = newValue
                        }
                }
            }
            .largeNavigationTitle("Settings")
            .background(.appBackground)
            .navigationDestination(for: WebLink.self) { webLink in
                WebView(webLink)
            }
            .onGeometryChange(for: CGSize.self) { proxy in
                proxy.size
            } action: { newValue in
                screenSize = newValue
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
