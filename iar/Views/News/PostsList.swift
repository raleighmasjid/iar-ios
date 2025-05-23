//
//  PostsList.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/12/22.
//

import SwiftUI

struct PostsList: View {
    
    let announcements: Announcements?
    @Binding var path: [Post]
    
    var body: some View {
        List {
            Group {
                if let special = announcements?.special {
                    SpecialAnnouncement(special: special) {
                        path.append(special)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .listRowSeparator(.hidden)
                }
                
                ForEach(announcements?.allPosts ?? []) { post in
                    Button {
                        path.append(post)
                    } label: {
                        PostRow(post: post)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .buttonStyle(RowButtonStyle())
                    .listRowSeparatorTint(.outline)
                    .alignmentGuide(.listRowSeparatorLeading) { _ in
                        16
                    }
                    .alignmentGuide(.listRowSeparatorTrailing) { dimensions in
                        dimensions[.trailing] - 16
                    }
                }
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

#if DEBUG
#Preview {
    PostsList(announcements: News.mocks().announcements, path: .constant([]))
}
#endif
