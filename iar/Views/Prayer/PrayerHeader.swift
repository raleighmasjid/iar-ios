//
//  PrayerHeader.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/17/22.
//

import SwiftUI

struct PrayerHeader: View {
    let prayerDays: [PrayerDayViewModel]
    @Binding var dayOffset: Int
    
    let buttonSize: CGFloat = 56
    
    var hasPreviousDays: Bool {
        dayOffset > 0
    }
    
    var hasNextDays: Bool {
        dayOffset < prayerDays.count - 1
    }
    
    var date: String {
        guard let viewModel = prayerDays[safe: dayOffset] else {
            return "Loading..."
        }

        return Formatter.dayFormatter.string(from: viewModel.prayerDay.date)
    }
    
    var hijri: String {
        guard let viewModel = prayerDays[safe: dayOffset] else {
            return " "
        }

        return viewModel.prayerDay.hijri.formatted()
    }
    
    var body: some View {
        HStack {
            Button {
                if hasPreviousDays {
                    withAnimation {
                        dayOffset -= 1
                    }
                }
            } label: {
                Image(.chevronLeft)
                    .foregroundColor(hasPreviousDays ? .accent : .tertiaryText)
                    .frame(width: buttonSize)
                    .frame(maxHeight: .infinity)
            }
            .disabled(!hasPreviousDays)

            Button {
                withAnimation {
                    dayOffset = 0
                }
            } label: {
                VStack(spacing: 4) {
                    Text(date)
                        .scalingFont(size: 16, weight: .semibold)
                        .frame(maxWidth: .infinity)
                    Text(hijri)
                        .scalingFont(size: 12)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.secondaryText)
                }
                .padding(.vertical, 16)
            }
            .animation(nil, value: date)
            .buttonStyle(.plain)
            
            Button {
                if hasNextDays {
                    withAnimation {
                        dayOffset += 1
                    }
                }
            } label: {
                Image(.chevronRight)
                    .foregroundColor(hasNextDays ? .accent : .tertiaryText)
                    .frame(width: buttonSize)
                    .frame(maxHeight: .infinity)
            }
            .disabled(!hasNextDays)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
#Preview {
    PrayerHeader(
        prayerDays: [
            PrayerDayViewModel(prayerDay: .mock(), index: 0),
            PrayerDayViewModel(prayerDay: .mock(), index: 1)],
        dayOffset: .constant(0)
    )
}
#endif
