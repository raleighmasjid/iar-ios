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
                    Button {
                        path.append(special)
                    } label: {
                        SpecialAnnouncement(special: special)
                    }
                    .buttonStyle(AnnouncementButtonStyle())
                    .padding(.horizontal, 16)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                
                ForEach(announcements?.allPosts ?? []) { post in
                    Button {
                        path.append(post)
                    } label: {
                        PostRow(post: post)
                    }
                    .buttonStyle(AnnouncementButtonStyle())
                    .listRowBackground(Color.clear)
                }
            }.listRowInsets(EdgeInsets())
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
