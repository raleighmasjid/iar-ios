//
//  iarApp.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import SwiftUI
import OneSignal

@main
struct iarApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(resource: .indicatorActive)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(resource: .indicatorInactive)
        UIPageControl.appearance().tintColor = UIColor(resource: .indicatorInactive)

        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(resource: .darkGreen)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(resource: .darkGreen)], for: .normal)
        UISegmentedControl.appearance().backgroundColor = UIColor(resource: .segmentedBackground)
        
        UINavigationBar.appearance().tintColor = UIColor(resource: .darkGreen)
        
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = UIColor(resource: .tabBackground)
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

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        OneSignal.setLocationShared(false)
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId("01fcf852-7b3f-4b53-a733-4cb8241bd193")

        OneSignal.promptForPushNotifications(userResponse: { accepted in
         print("User accepted notification: \(accepted)")
        })

        return true
    }
}
