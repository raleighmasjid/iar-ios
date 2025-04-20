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
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let backgroundTaskIdentifier = "com.lemosys.IARMasjid.localNotificationsRefresh"
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: backgroundTaskIdentifier, using: nil) { bgTask in
            Task {
                await self.refreshNotifications()
                self.scheduleAppRefresh()
                bgTask.setTaskCompleted(success: true)
            }
        }
        OneSignal.initialize("01fcf852-7b3f-4b53-a733-4cb8241bd193", withLaunchOptions: launchOptions)
        scheduleAppRefresh()
        return true
    }
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: backgroundTaskIdentifier)
        request.earliestBeginDate = Date().addingTimeInterval(60 * 60 * 24)
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Error scheduling background task \(error)")
        }
    }
    
    func refreshNotifications() async {
        let prayerProvider = NetworkPrayerProvider()
        guard let schedule = try? await prayerProvider.fetchPrayers(forceRefresh: false) else {
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
