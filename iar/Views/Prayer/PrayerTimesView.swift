//
//  PrayerTimesView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/20/22.
//

import SwiftUI

struct PrayerTimesView: View {
    
    let days: [IndexedPrayerDay]
    @Binding var dayOffset: Int
    
    init(prayerDays: [PrayerDay], dayOffset: Binding<Int>) {
        days = prayerDays.enumerated().map { (index, day) in
            IndexedPrayerDay(prayerDay: day, index: index)
        }
        self._dayOffset = dayOffset
    }
    
    var body: some View {
        columnHeaders
                            
        TabView(selection: $dayOffset) {
            ForEach(days, id: \.self) {
                PrayerDayView(prayerDay: $0.prayerDay)
                    .tag($0.index)
            }
            if days.isEmpty {
                PrayerDayView(prayerDay: nil)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 275)
        .id(days.hashValue)
    }
    
    var columnHeaders: some View {
        HStack() {
            Text("Prayer")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Adhan")
                .frame(maxWidth: .infinity, alignment: .center)
            Text("Iqamah")
                .frame(maxWidth: .infinity, alignment: .trailing)
            Spacer().frame(width: 43)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .font(.system(size: 16, weight: .regular))
        .foregroundColor(.white)
        .background(Color.Theme.darkGreen)
    }
}

