//
//  iarApp.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import SwiftUI

@main
struct iarApp: App {
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = Color.Theme.indicatorActive.uiColor
        UIPageControl.appearance().pageIndicatorTintColor = Color.Theme.indicatorInactive.uiColor
        UIPageControl.appearance().tintColor = Color.Theme.indicatorInactive.uiColor

        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = Color.Theme.darkGreen.uiColor
        tabAppearance.stackedLayoutAppearance.normal.iconColor = .white.withAlphaComponent(0.5)
        tabAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        UITabBar.appearance().standardAppearance = tabAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabAppearance
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
