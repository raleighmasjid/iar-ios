//
//  PrayerView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import SwiftUI

struct PrayerView: View {
    let prayerDay: PrayerDay
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(Prayer.allCases, id: \.self) { prayer in
                PrayerRow(prayer: prayer, prayerDay: prayerDay, current: prayer == prayerDay.currentPrayer())
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#if DEBUG
struct PrayerView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerView(prayerDay: .mock())
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
#endif
