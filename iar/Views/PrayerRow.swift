//
//  PrayerRow.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import SwiftUI

struct PrayerRow: View {
    let prayerName: String
    let adhanTime: Date
    let iqamahTime: Date?
    
    init(prayer: Prayer, prayerDay: PrayerDay) {
        prayerName = prayer.title
        adhanTime = prayer.adhan(from: prayerDay)
        iqamahTime = prayer.iqamah(from: prayerDay)
    }
    
    var body: some View {
        HStack {
            Text(prayerName)
            Text(adhanTime.formatted(date: .omitted, time: .shortened))
            
        }
    }
}

//struct PrayerRow_Previews: PreviewProvider {
//    static var previews: some View {
//        PrayerRow()
//    }
//}
