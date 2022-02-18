//
//  PrayerHeader.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 2/17/22.
//

import SwiftUI

struct PrayerHeader: View {
    let prayerDays: [PrayerDay]
    @Binding var dayOffset: Int
    
    var hasPreviousDays: Bool {
        dayOffset > 0
    }
    
    var hasNextDays: Bool {
        dayOffset < prayerDays.count - 1
    }
    
    var date: String {
        guard let prayerDay = prayerDays[safe: dayOffset] else {
            return "Loading..."
        }

        return Formatter.dayFormatter.string(from: prayerDay.date)
    }
    
    var hijri: String {
        guard let prayerDay = prayerDays[safe: dayOffset] else {
            return " "
        }

        return prayerDay.hijri.formatted()
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
                Image(systemName: "chevron.left.circle.fill")
                    .resizable()
                    .frame(width: 28, height: 28)
            }
            .foregroundColor(.Theme.darkGreen)
            .disabled(!hasPreviousDays)
            .opacity(hasPreviousDays ? 1 : 0.3)

            Button {
                withAnimation {
                    dayOffset = 0
                }
            } label: {
                VStack(spacing: 2) {
                    Text(date)
                        .font(.system(size: 15, weight: .semibold))
                        .frame(maxWidth: .infinity)
                    Text(hijri)
                        .font(.system(size: 13))
                        .frame(maxWidth: .infinity)
                }
            }
            .animation(nil)
            .buttonStyle(.plain)
            
            Button {
                if hasNextDays {
                    withAnimation {
                        dayOffset += 1
                    }
                }
            } label: {
                Image(systemName: "chevron.right.circle.fill")
                    .resizable()
                    .frame(width: 28, height: 28)
            }
            .foregroundColor(.Theme.darkGreen)
            .disabled(!hasNextDays)
            .opacity(hasNextDays ? 1 : 0.3)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)

    }
}

#if DEBUG
struct PrayerHeader_Previews: PreviewProvider {
    static let viewModel = PrayerTimesViewModel(provider: MockProvider())
    static var previews: some View {
        PrayerHeader(prayerDays: viewModel.prayerDays, dayOffset: .constant(0))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
#endif
