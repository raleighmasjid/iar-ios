//
//  MainView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import SwiftUI

struct MainView: View {
    
    let prayerTimesViewModel = PrayerTimesViewModel(provider: NetworkPrayerProvider())
    
    var body: some View {
        TabView {
            PrayerScreen(viewModel: prayerTimesViewModel)
                .tabItem {
                    Text("Prayers")
                }
            SettingsScreen()
                .tabItem {
                    Text("Settings")
                }
        }.environmentObject(prayerTimesViewModel.notificationSettings)
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif
