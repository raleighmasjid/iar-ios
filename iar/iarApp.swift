//
//  iarApp.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import SwiftUI
import BackgroundTasks
import WidgetKit
import FirebaseCore
import FirebaseMessaging
import UserNotifications

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

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
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

        scheduleAppRefresh()
        FirebaseApp.configure()
        
        // Set delegates
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self

        // Register for remote notifications on APNs
        application.registerForRemoteNotifications()
        
        return true
    }
    
    // Capture the APNs token and assign it to FCM
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // Receive the FCM registration token
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM registration token: \(String(describing: fcmToken))")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  willPresent notification: UNNotification,
                                  withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
          
          let userInfo = notification.request.content.userInfo
          
          // This forces iOS to show the banner and play sound even if the app is wide open
          completionHandler([[.banner, .sound, .badge]])
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
