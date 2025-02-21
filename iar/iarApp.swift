//
//  iarApp.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import SwiftUI
import OneSignalFramework

@main
struct iarApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        OneSignal.initialize("01fcf852-7b3f-4b53-a733-4cb8241bd193", withLaunchOptions: launchOptions)
//        OneSignal.Notifications.requestPermission({ accepted in
//            #if DEBUG
//            print("User accepted notifications: \(accepted)")
//            #endif
//        }, fallbackToSettings: true)
        return true
    }
}
