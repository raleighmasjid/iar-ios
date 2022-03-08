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
            NavigationView {
                PrayerScreen(viewModel: prayerTimesViewModel)
                    .navigationTitle("Prayer Times")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Prayer", image: "tab-prayer")
            }
            
            NavigationView {
                NewsScreen()
                    .navigationTitle("News")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("News", image: "tab-news")
            }
            
            NavigationView {
                DonateScreen()
                    .navigationTitle("Donate")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Donate", image: "tab-donate")
            }
            
            NavigationView {
                MoreScreen()
                    .navigationTitle("More")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("More", image: "tab-more")
            }
        }
        .environmentObject(prayerTimesViewModel.notificationSettings)
        .accentColor(.Theme.tabForeground)
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif
