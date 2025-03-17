//
//  SpecialAnnouncement.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/12/22.
//

import SwiftUI

struct SpecialAnnouncement: View {
    
    let special: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(.announcementIcon)
                    .foregroundStyle(.accent)
                Text(special.title)
                    .foregroundStyle(.accent)
                    .scalingFont(size: 15, weight: .semibold)
            }
            Text(special.text)
                .foregroundStyle(.accent)
                .scalingFont(size: 13)
                .lineLimit(3)
                .lineSpacing(5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
#Preview {
    SpecialAnnouncement(special: News.mocks().announcements.special!)
}
#endif
