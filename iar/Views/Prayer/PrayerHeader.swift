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
    
    let buttonSize: CGFloat = 48
    
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
                    .foregroundColor(hasPreviousDays ? Color(.action) : .primary.opacity(0.3))
                    .frame(width: buttonSize, height: buttonSize)
                    .padding(4)
            }
            .disabled(!hasPreviousDays)

            Button {
                withAnimation {
                    dayOffset = 0
                }
            } label: {
                VStack(spacing: 2) {
                    Text(date)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 4)
                    Text(hijri)
                        .font(.system(size: 12))
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.secondaryText)
                }
                .padding(.vertical, 6)
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
                    .foregroundColor(hasNextDays ? .action : .primary.opacity(0.3))
                    .frame(width: buttonSize, height: buttonSize)
                    .padding(4)
            }
            .disabled(!hasNextDays)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 10)

    }
}

#if DEBUG
struct PrayerHeader_Previews: PreviewProvider {
    static var previews: some View {
        PrayerHeader(prayerDays: [PrayerDayViewModel(prayerDay: .mock(), index: 0), PrayerDayViewModel(prayerDay: .mock(), index: 1)], dayOffset: .constant(0))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
#endif
