//
//  PrayerCountdown.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import SwiftUI

struct PrayerCountdown: View {
    @ObservedObject var viewModel: PrayerCountdownViewModel
    
    init(upcoming: PrayerTime?) {
        viewModel = PrayerCountdownViewModel(upcoming: upcoming)
    }
    
    var nextPrayer: String {
        guard let upcoming = viewModel.upcoming else {
            return " "
        }

        return "\(upcoming.prayer.title) is in"
    }
    
    var countdown: String {
        guard viewModel.upcoming != nil else {
            return " "
        }

        return viewModel.timeRemaining.formattedInterval()
    }
    
    var countdownSize: CGFloat {
        UIScreen.isTiny ? 28 : 32
    }
    
    var badgeColor: Color {
        if viewModel.upcoming == nil {
            return .clear
        } else {
            return Color.Theme.badgeBackground
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(nextPrayer)
                .padding(.vertical, 4)
                .padding(.horizontal, 9)
                .font(.system(size: 16, weight: .medium))
                .background(badgeColor)
                .cornerRadius(8)
            Text(countdown)
                .font(.system(size: countdownSize, weight: .semibold))
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
struct PrayerCountdown_Previews: PreviewProvider {
    static var previews: some View {
        PrayerCountdown(upcoming: PrayerTime(prayer: .maghrib, adhan: Date().addingTimeInterval(600), iqamah: Date().addingTimeInterval(900)))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
        PrayerCountdown(upcoming: nil)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
#endif
