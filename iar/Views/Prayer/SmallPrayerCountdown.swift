//
//  SmallPrayerCountdown.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 5/15/24.
//

import SwiftUI

struct SmallPrayerCountdown: View {

    @ObservedObject var viewModel: PrayerCountdownViewModel
    
    @Environment(\.safeAreaInsets) var safeArea
    @State private var backgroundHeight: Double = 42
    
    
    init(upcoming: PrayerTime?) {
        viewModel = PrayerCountdownViewModel(upcoming: upcoming)
    }

    var countdown: String {
        guard let upcoming = viewModel.upcoming else {
            return " "
        }

        return "\(upcoming.prayer.title) is in \(viewModel.timeRemaining.formattedInterval())"
    }

    var body: some View {
        ZStack(alignment: .top) {
                Image(.prayerHeader)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: backgroundHeight + 8, alignment: .top)
                    .frame(maxWidth: .infinity)
                    .clipped()
            Text(countdown)
                .scalingFont(size: 17, weight: .semibold)
                .foregroundStyle(.white)
                .padding(.top, safeArea.top + 8)
                .background(GeometryReader { geometry in
                    Color.clear
                        .preference(key: TextHeightPreferenceKey.self, value: geometry.frame(in: .global).height)
                })
                .onPreferenceChange(TextHeightPreferenceKey.self) { value in
                    self.backgroundHeight = value
                }
                
        }
    }
}

struct TextHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 42
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    }
}

#if DEBUG
#Preview {
    SmallPrayerCountdown(upcoming: PrayerTime(prayer: .maghrib, adhan: Date().addingTimeInterval(600), iqamah: Date().addingTimeInterval(900)))
}

#Preview {
    SmallPrayerCountdown(upcoming: nil)
}
#endif

