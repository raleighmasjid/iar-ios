//
//  SpecialHeader.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/12/22.
//

import SwiftUI

struct SpecialHeader: View {
    let special: SpecialAnnouncement
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Image(systemName: "exclamationmark.circle")
                    .font(.system(size: 18.0, weight: .semibold))
                    .foregroundColor(.Theme.darkGreen)
                Text(special.title)
                    .foregroundColor(.Theme.darkGreen)
                    .font(.system(size: 16, weight: .semibold))
            }
            Text(special.text)
                .font(.system(size: 14))
                .lineLimit(5)
                .lineSpacing(3)
        }
        .padding(16)
        .background(Color.Theme.prayerBackground)
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.Theme.darkGreen, lineWidth: 0.5))
        
    }
}

struct specialHeader_Previews: PreviewProvider {
    static var previews: some View {
        SpecialHeader(special: News.mocks().special!)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
