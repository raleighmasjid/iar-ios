//
//  PrayerTimesView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/20/22.
//

import SwiftUI

struct PrayerTimesView: View {
    
    let days: [PrayerDayViewModel]
    let showTaraweeh: Bool
    @Binding var dayOffset: Int
    
    init(prayerDays: [PrayerDay], dayOffset: Binding<Int>) {
        days = prayerDays.enumerated().map { (index, day) in
            PrayerDayViewModel(prayerDay: day, index: index)
        }
        self._dayOffset = dayOffset
        self.showTaraweeh = prayerDays.contains(where: { $0.hasTaraweeh })
    }
    
    var body: some View {
        VStack(spacing: 0) {
            columnHeaders
                              
            ZStack {
                PrayerDayView(prayerDay: nil,
                              currentPrayer: nil,
                              showTaraweeh: showTaraweeh)
                    .opacity(days.isEmpty ? 1 : 0)
                
                TabView(selection: $dayOffset) {
                    ForEach(days, id: \.self) { prayerItem in
                        VStack {
                            PrayerDayView(prayerDay: prayerItem.prayerDay,
                                          currentPrayer: prayerItem.currentPrayer,
                                          showTaraweeh: showTaraweeh)
                            Spacer(minLength: 0)
                        }
                        .tag(prayerItem.index)
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
