//
//  iarApp.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import SwiftUI

@main
struct iarApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: PrayerTimesViewModel(provider: NetworkPrayerProvider()))
        }
    }
}
