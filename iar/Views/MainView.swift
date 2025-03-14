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
    @State var newsPath: [Post] = []

    let dayChange = NotificationCenter.default.publisher(for: .NSCalendarDayChanged).receive(on: RunLoop.main)

    var body: some View {
        TabView {
            PrayerScreen(viewModel: prayerTimesViewModel)
            .tabItem {
                Label("Prayer", image: "tab-prayer")
            }
            
            NavigationStack {
                QiblaScreen(viewModel: compassViewModel)
                    .largeNavigationTitle("Qibla")
                    .background(.appBackground)
            }
            .tabItem {
                Label("Qibla", image: "tab-qibla")
            }
            
            NavigationStack(path: $newsPath) {
                NewsScreen(viewModel: newsViewModel, path: $newsPath)
                    .largeNavigationTitle("News")
                    .background(.appBackground)
            }
            .tabItem {
                Label("News", image: newsViewModel.badge ? "tab-news-badge" : "tab-news")
            }
            
            DonateScreen()
                .background(.appBackground)
            .tabItem {
                Label("Donate", image: "tab-donate")
            }
            
            NavigationStack {
                MoreScreen()
                    .largeNavigationTitle("Settings")
                    .background(.appBackground)
            }
            .tabItem {
                Label("Settings", image: "tab-settings")
            }
        }
        .tint(.accent)
        .environmentObject(prayerTimesViewModel.notificationSettings)
        .onAppear {
            styleTabBar()
            
            if prayerTimesViewModel.prayerDays.isEmpty {
                prayerTimesViewModel.loadData()
            }
            if newsViewModel.announcements == nil {
                newsViewModel.loadData()
            }
        }
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .background:
                didEnterBackground = true
            case .active:
                if didEnterBackground {
                    didEnterBackground = false
                    prayerTimesViewModel.loadData()
                    newsViewModel.loadData()
                }
            default:
                break
            }
        }
        .onReceive(dayChange) { _ in
            prayerTimesViewModel.loadData()
            newsViewModel.loadData()
        }
    }
    
    func styleTabBar() {
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithDefaultBackground()
        tabAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(resource: .secondaryText)
        tabAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(resource: .secondaryText)]
        UITabBar.appearance().standardAppearance = tabAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabAppearance
    }
}

#if DEBUG
#Preview {
    MainView()
}
#endif
