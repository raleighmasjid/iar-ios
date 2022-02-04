//
//  MainView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import SwiftUI

struct MainView: View {
    @StateObject var prayerController: PrayerController
    
    var body: some View {
        NavigationView {
            VStack {
                PrayerHeader(prayerDay: prayerController.current)
                if let prayerDay = prayerController.current {
                    PrayerView(prayerDay: prayerDay)
                } else {
                    Text("Loading...")
                }
                Spacer(minLength: 10)
            }
            .onAppear {
                prayerController.loadTimes()
            }
            .navigationTitle("Prayer Times")
        }
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(prayerController: PrayerController(provider: MockProvider()))
    }
}
#endif
