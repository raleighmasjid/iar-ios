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
                    .frame(height: safeArea.top + 42, alignment: .top)
                    .frame(maxWidth: .infinity)
                    .clipped()
            Text(countdown)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.white)
                .padding(.top, safeArea.top + 8)
        }
    }
}

#Preview {
    SmallPrayerCountdown(upcoming: PrayerTime(prayer: .maghrib, adhan: Date().addingTimeInterval(600), iqamah: Date().addingTimeInterval(900)))
}

#Preview {
    SmallPrayerCountdown(upcoming: nil)
}
