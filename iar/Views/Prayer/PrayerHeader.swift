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
    
    let buttonSize: CGFloat = 32
    
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
                Image("chevron-left")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(Color.Theme.darkGreen)
                    .frame(width: buttonSize, height: buttonSize)
                    .padding(.horizontal, 20)
            }
            .disabled(!hasPreviousDays)
            .opacity(hasPreviousDays ? 1 : 0.5)

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
                Image("chevron-right")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(Color.Theme.darkGreen)
                    .frame(width: buttonSize, height: buttonSize)
                    .padding(.horizontal, 20)
            }
            .disabled(!hasNextDays)
            .opacity(hasNextDays ? 1 : 0.5)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 12)

    }
}

#if DEBUG
struct PrayerHeader_Previews: PreviewProvider {
    static var previews: some View {
        PrayerHeader(prayerDays: [.mock(), .mock()], dayOffset: .constant(0))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
#endif
