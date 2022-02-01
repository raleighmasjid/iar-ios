//
//  PrayerView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import SwiftUI

struct PrayerView: View {
    @StateObject var prayerController = PrayerController()
    
    var body: some View {
        VStack {
            if let prayerDay = prayerController.current {
                ForEach(Prayer.allCases, id: \.self) { prayer in
                    PrayerRow(prayer: prayer, prayerDay: prayerDay)
                }
            } else {
                Text("Loading...")
            }
        }
        .task {
            await prayerController.loadTimes()
        }
    }
}

struct PrayerView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerView()
    }
}
