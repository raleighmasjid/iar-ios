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
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "IndicatorActive")
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(named: "IndicatorInactive")
        UIPageControl.appearance().tintColor = UIColor(named: "IndicatorInactive")
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
