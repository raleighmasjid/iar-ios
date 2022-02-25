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
        VStack(spacing: 0) {
            columnHeaders
                              
            ZStack {
                PrayerDayView(prayerDay: nil)
                    .opacity(days.isEmpty ? 1 : 0)
                TabView(selection: $dayOffset) {
                    ForEach(days, id: \.self) {
                        PrayerDayView(prayerDay: $0.prayerDay)
                            .tag($0.index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .opacity(days.isEmpty ? 0 : 1)
                .id(days.hashValue)
            }
        }
    }
    
    var columnHeaders: some View {
        HStack() {
            Text("Prayer")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Adhan")
                .frame(maxWidth: .infinity, alignment: .center)
            Text("Iqamah")
                .frame(maxWidth: .infinity, alignment: .trailing)
            Spacer().frame(width: 55)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 28)
        .font(.system(size: 16, weight: .bold))
    }
}

#if DEBUG
struct PrayerTimesView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PrayerTimesView(prayerDays: [.mock()],
                            dayOffset: .constant(0))
            Spacer(minLength: 10)
        }
            .environmentObject(NotificationSettings())
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
#endif
