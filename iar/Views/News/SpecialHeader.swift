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
                    .scalingFont(size: 15, weight: .semibold)
            }
            Text(special.text)
                .foregroundStyle(.action)
                .scalingFont(size: 13)
                .lineLimit(3)
                .lineSpacing(5)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.specialAnnouncement)
        .cornerRadius(16)
    }
}

#if DEBUG
#Preview {
    SpecialHeader(special: News.mocks().announcements.special!)
}
#endif
