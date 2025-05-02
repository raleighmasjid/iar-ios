//
//  SpecialAnnouncement.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/12/22.
//

import SwiftUI

struct SpecialAnnouncement: View {
    
    let special: Post
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .center) {
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
        .buttonStyle(PrimaryContainerButtonStyle(size: .large))
    }
}

#if DEBUG
#Preview {
    SpecialAnnouncement(special: News.mocks().announcements.special!) {}
        .padding(16)
}
#endif
