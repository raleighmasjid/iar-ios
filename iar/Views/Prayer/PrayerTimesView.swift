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
    @State var dayOffset = 0
    @Environment(\.scenePhase) var scenePhase
    
    init(prayerDays: [PrayerDay]) {
        days = prayerDays.enumerated().map { (index, day) in
            PrayerDayViewModel(prayerDay: day, index: index)
        }
        self.showTaraweeh = prayerDays.contains(where: { $0.hasTaraweeh })
    }
    
    var body: some View {
        VStack(spacing: 0) {
            PrayerHeader(prayerDays: days, dayOffset: $dayOffset)
            ZStack(alignment: .top) {
                PrayerDayView(prayerDay: nil,
                              currentPrayer: nil,
                              showTaraweeh: showTaraweeh)
                .opacity(days.isEmpty ? 1 : 0)
                if !days.isEmpty {
                    TabView(selection: $dayOffset) {
                        ForEach(days, id: \.self) { prayerItem in
                            PrayerDayView(prayerDay: prayerItem.prayerDay,
                                          currentPrayer: prayerItem.currentPrayer,
                                          showTaraweeh: showTaraweeh)
                            .tag(prayerItem.index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .opacity(days.isEmpty ? 0 : 1)
                    .id(days.hashValue)
                }
            }
        }
        .background(.surfaceContainer)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 25, x: 0, y: 5)
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .background:
                dayOffset = 0
            default:
                break
            }
        }
    }
}

#if DEBUG
#Preview {
    PrayerTimesView(prayerDays: [.mock()])
        .environmentObject(NotificationSettings())
}
#endif
