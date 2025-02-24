//
//  iarApp.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import SwiftUI
import OneSignalFramework
import BackgroundTasks
import WidgetKit

@main
struct iarApp: App {
    
    @Environment(\.scenePhase) private var phase
    
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate
    
    let backgroundTaskIdentifier = "com.lemosys.IARMasjid.localNotificationsRefresh"

    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .onChange(of: phase) { newPhase in
            switch newPhase {
            case .active:
                scheduleAppRefresh()
            default: break
            }
        }.backgroundTask(.appRefresh(backgroundTaskIdentifier)) {
            await scheduleAppRefresh()

            let prayerProvider = NetworkPrayerProvider()
            guard let schedule = try? await prayerProvider.fetchPrayers() else {
                return
            }
            
            let notificationSettings = NotificationSettings()
            let notificationController = NotificationController()
            let enabledPrayers = Prayer.allCases.filter { notificationSettings.isEnabled(for: $0) }
                    
            await notificationController.scheduleNotifications(prayerDays: schedule.prayerDays,
                                                               enabledPrayers: enabledPrayers,
                                                               notificationType: notificationSettings.type)
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: backgroundTaskIdentifier)
        request.earliestBeginDate = Date().addingTimeInterval(60 * 60 * 24)
        try? BGTaskScheduler.shared.submit(request)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        OneSignal.initialize("01fcf852-7b3f-4b53-a733-4cb8241bd193", withLaunchOptions: launchOptions)
        OneSignal.Notifications.requestPermission({ accepted in
            #if DEBUG
            print("User accepted notifications: \(accepted)")
            #endif
        }, fallbackToSettings: true)
        return true
    }
}
