//
//  PrayerView.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import SwiftUI

struct PrayerView: View {
    let prayerDay: PrayerDay?
    @ObservedObject var alarmSetting: AlarmSetting

    var body: some View {
        VStack(spacing: 0) {
            columnHeaders
            ForEach(Prayer.allCases, id: \.self) { prayer in
                PrayerRow(prayer: prayer,
                          adhan: prayerDay?.adhan(for: prayer),
                          iqamah: prayerDay?.iqamah(for: prayer),
                          current: prayerDay?.currentPrayer() == prayer,
                          alarm: alarmSetting,
                          alarmEnabled: alarmSetting.isEnabled(prayer: prayer))
            }
        }
        .frame(maxWidth: .infinity)
        
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

#if DEBUG
struct PrayerView_Previews: PreviewProvider {
    static let viewModel = PrayerTimesViewModel(provider: MockProvider())
    static var previews: some View {
        PrayerView(prayerDay: .mock(), alarmSetting: AlarmSetting())
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
#endif
