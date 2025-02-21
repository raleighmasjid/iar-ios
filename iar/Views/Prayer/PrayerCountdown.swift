//
//  PrayerCountdown.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import SwiftUI

struct PrayerCountdown: View {
    @ObservedObject var viewModel: PrayerCountdownViewModel
    let verticalPadding: CGFloat
    @Binding var textHeight: CGFloat
    
    init(upcoming: PrayerTime?, verticalPadding: CGFloat, textHeight: Binding<CGFloat>) {
        self.viewModel = PrayerCountdownViewModel(upcoming: upcoming)
        self.verticalPadding = verticalPadding
        self._textHeight = textHeight
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
                .scalingFont(size: 48)
                .onGeometryChange(for: CGFloat.self) { proxy in
                    proxy.size.height
                } action: { newValue in
                    textHeight = newValue
                }
        }
        .foregroundStyle(.white)
        .padding(.vertical, verticalPadding)
    }
}

#if DEBUG
#Preview {
    PrayerCountdown(upcoming: PrayerTime(prayer: .maghrib, adhan: Date().addingTimeInterval(600), iqamah: Date().addingTimeInterval(900)),
                    verticalPadding: 40,
                    textHeight: .constant(0))
        .background(Color.black)
}

#Preview("no upcoming") {
    PrayerCountdown(upcoming: nil, verticalPadding: 40, textHeight: .constant(0))
        .background(Color.black)
}
#endif
