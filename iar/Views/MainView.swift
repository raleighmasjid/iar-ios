//
//  MainView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var prayerTimesViewModel = PrayerTimesViewModel(provider: NetworkPrayerProvider())
    
    @StateObject var newsViewModel = NewsViewModel(provider: NetworkNewsProvider())
    
    @Environment(\.scenePhase) var scenePhase
    @State var didEnterBackground = false

    let dayChange = NotificationCenter.default.publisher(for: .NSCalendarDayChanged).receive(on: RunLoop.main)

    var body: some View {
        TabView {
            NavigationView {
                PrayerScreen(viewModel: prayerTimesViewModel)
                    .navigationTitle("Prayer Times")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Label("Prayer", image: "tab-prayer")
            }
            
            if #available(iOS 15.0, *) {
                NavigationView {
                    NewsScreen(viewModel: newsViewModel)
                        .navigationTitle("News")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .navigationViewStyle(.stack)
                .tabItem {
                    Label("News", image: "tab-news")
                }
                .badge(newsViewModel.badge)
            } else {
                NavigationView {
                    NewsScreen(viewModel: newsViewModel)
                        .navigationTitle("News")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .navigationViewStyle(.stack)
                .tabItem {
                    Label("News", image: "tab-news")
                }
            }
            
            NavigationView {
                DonateScreen()
                    .navigationTitle("Donate")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Label("Donate", image: "tab-donate")
            }
            
            NavigationView {
                MoreScreen()
                    .navigationTitle("More")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(.stack)
            .tabItem {
                Label("More", image: "tab-more")
            }
        }
        .environmentObject(prayerTimesViewModel.notificationSettings)
        .accentColor(.Theme.tabForeground)
        .onAppear {
            if prayerTimesViewModel.prayerDays.isEmpty {
                prayerTimesViewModel.fetchLatest()
            }
            if newsViewModel.announcements == nil {
                newsViewModel.fetchLatest()
            }
        }
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .background:
                didEnterBackground = true
            case .active:
                if didEnterBackground {
                    didEnterBackground = false
                    prayerTimesViewModel.fetchLatest()
                    newsViewModel.fetchLatest()
                }
            default:
                break
            }
        }
        .onReceive(dayChange) { _ in
            prayerTimesViewModel.fetchLatest()
            newsViewModel.fetchLatest()
        }
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif
