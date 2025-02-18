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
    
    @StateObject var compassViewModel: CompassViewModel = {
        #if targetEnvironment(simulator)
        let provider = MockLocationProvider()
        #else
        let provider = CoreLocationProvider()
        #endif
        return CompassViewModel(provider: provider)
    }()
    
    @Environment(\.scenePhase) var scenePhase
    @State var didEnterBackground = false

    let dayChange = NotificationCenter.default.publisher(for: .NSCalendarDayChanged).receive(on: RunLoop.main)

    var body: some View {
        TabView {
            PrayerScreen(viewModel: prayerTimesViewModel)
            .tabItem {
                Label("Prayer", image: "tab-prayer")
            }
            
            QiblahScreen(viewModel: compassViewModel)
            .tabItem {
                Label("Qiblah", image: "tab-qibla")
            }
            .accentColor(.darkGreen)
            
            NavigationStack {
                NewsScreen(viewModel: newsViewModel)
                    .navigationTitle("News")
            }
            .tabItem {
                Label("News", image: "tab-news")
            }
            .badge(newsViewModel.badge)
            .accentColor(.darkGreen)
            
            DonateScreen()
            .tabItem {
                Label("Donate", image: "tab-donate")
            }
            .accentColor(.darkGreen)
            
            NavigationStack {
                MoreScreen()
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Settings", image: "tab-settings")
            }
            .accentColor(.darkGreen)
        }
        .environmentObject(prayerTimesViewModel.notificationSettings)
        .accentColor(.tabSelected)
        .onAppear {
            styleTabBar()

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
    
    func styleTabBar() {
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithDefaultBackground()
        tabAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(resource: .tabUnselected)
        tabAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(resource: .tabUnselected)]
        UITabBar.appearance().standardAppearance = tabAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabAppearance
    }
}

#if DEBUG
#Preview {
    MainView()
}
#endif
