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
                    Label("Prayers", image: "tab-prayer")
                }
            NewsScreen()
                .tabItem {
                    Label("News", image: "tab-news")
                }
            DonateScreen()
                .tabItem {
                    Label("Donate", image: "tab-donate")
                }
            MoreScreen()
                .tabItem {
                    Label("More", image: "tab-more")
                }
        }
        .environmentObject(prayerTimesViewModel.notificationSettings)
        .accentColor(.white)
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif
