//
//  SpecialHeader.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/12/22.
//

import SwiftUI

struct SpecialHeader: View {
    let special: Post
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(.announcementIcon)
                    .foregroundStyle(.action)
                Text(special.title)
                    .foregroundStyle(.action)
                    .font(.system(size: 15, weight: .semibold))
            }
            Text(special.text)
                .foregroundStyle(.action)
                .font(.system(size: 13))
                .lineLimit(3)
                .lineSpacing(5)
        }
        .padding(16)
        .background(.specialAnnouncement)
        .cornerRadius(16)
    }
}

#if DEBUG
struct specialHeader_Previews: PreviewProvider {
    static var previews: some View {
        SpecialHeader(special: News.mocks().announcements.special!)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
#endif
