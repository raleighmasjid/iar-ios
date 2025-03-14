//
//  PrayerCountdown.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/1/22.
//

import SwiftUI

struct PrayerCountdown: View {
    @ObservedObject var viewModel: PrayerCountdownViewModel
    let mode: Mode
    @Binding var textHeight: CGFloat
    
    init(upcoming: PrayerTime?, mode: Mode, textHeight: Binding<CGFloat>) {
        self.viewModel = PrayerCountdownViewModel(upcoming: upcoming)
        self.mode = mode
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
            return .white.opacity(0.15)
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: mode.spacing) {
            Text(nextPrayer)
                .padding(.vertical, 4)
                .padding(.horizontal, 9)
                .scalingFont(size: 16, weight: .medium)
                .background(badgeColor)
                .cornerRadius(8)
            Text(countdown)
                .scalingFont(size: mode.countdownFontSize)
                .onGeometryChange(for: CGFloat.self) { proxy in
                    proxy.size.height
                } action: { newValue in
                    textHeight = newValue
                }
        }
        .foregroundStyle(.white)
        .padding(.vertical, mode.verticalPadding)
    }
    
    enum Mode {
        case small
        case large
        
        var verticalPadding: CGFloat {
            switch self {
            case .small:
                return 28
            case .large:
                return 40
            }
        }
        
        var countdownFontSize: CGFloat {
            switch self {
            case .small:
                return 36
            case .large:
                return 48
            }
        }
        
        var spacing: CGFloat {
            switch self {
            case .small:
                return 4
            case .large:
                return 12
            }
        }
    }
}

#if DEBUG
#Preview {
    PrayerCountdown(upcoming: PrayerTime(prayer: .maghrib, adhan: Date().addingTimeInterval(600), iqamah: Date().addingTimeInterval(900)),
                    mode: .large,
                    textHeight: .constant(0))
        .background(.black)
}

#Preview("no upcoming") {
    PrayerCountdown(upcoming: nil, mode: .large, textHeight: .constant(0))
        .background(.black)
}
#endif
