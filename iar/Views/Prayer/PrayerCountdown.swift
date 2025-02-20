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
    
    var badgeColor: Color {
        if viewModel.upcoming == nil {
            return .clear
        } else {
            return Color(.badgeBackground)
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text(nextPrayer)
                .padding(.vertical, 4)
                .padding(.horizontal, 9)
                .scalingFont(size: 16, weight: .medium)
                .background(badgeColor)
                .cornerRadius(8)
            Text(countdown)
                .font(.system(size: 48))
        }
        .foregroundStyle(.white)
        .padding(.top, 36)
    }
}

#if DEBUG
#Preview {
    PrayerCountdown(upcoming: PrayerTime(prayer: .maghrib, adhan: Date().addingTimeInterval(600), iqamah: Date().addingTimeInterval(900)))
        .background(Color.black)
}

#Preview("no upcoming") {
    PrayerCountdown(upcoming: nil)
        .background(Color.black)
}
#endif
