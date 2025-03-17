//
//  SmallPrayerCountdown.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 5/15/24.
//

import SwiftUI

struct SmallPrayerCountdown: View {

    let upcoming: PrayerTime?
    
    let verticalPadding: CGFloat
    let safeArea: CGFloat
    @Binding var textHeight: CGFloat
    
    init(upcoming: PrayerTime?, verticalPadding: CGFloat, safeArea: CGFloat, textHeight: Binding<CGFloat>) {
        self.upcoming = upcoming
        self.verticalPadding = verticalPadding
        self.safeArea = safeArea
        self._textHeight = textHeight
    }

    var body: some View {
        ZStack(alignment: .top) {
                Image(.prayerHeader)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: textHeight + safeArea, alignment: .top)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .ignoresSafeArea(edges: .top)
            Group {
                if let upcoming = upcoming {
                    HStack(spacing: 0) {
                        Text("\(upcoming.prayer.title) is in ")
                        Text(upcoming.adhan, style: .relative)
                    }
                } else {
                    Text(" ")
                }
            }
            .scalingFont(size: 17, weight: .semibold)
            .monospacedDigit()
            .foregroundStyle(.white)
            .lineLimit(1)
            .minimumScaleFactor(0.1)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, 30)
            .onGeometryChange(for: CGFloat.self) { proxy in
                proxy.frame(in: .global).height
            } action: { newValue in
                self.textHeight = newValue
            }
        }
    }
}

//#if DEBUG
//#Preview {
//    @Previewable @State var textHeight: Double = 0
//    SmallPrayerCountdown(upcoming: PrayerTime(prayer: .maghrib, adhan: Date().addingTimeInterval(600), iqamah: Date().addingTimeInterval(900)), safeArea: .zero, textHeight: $textHeight)
//}
//
//#Preview {
//    @Previewable @State var textHeight: Double = 0
//    SmallPrayerCountdown(upcoming: nil, safeArea: .zero, textHeight: $textHeight)
//}
//#endif

