//
//  PostRow.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/12/22.
//

import SwiftUI
import NukeUI

struct PostRow: View {
    let post: Post
    
    var postImageURL: URL? {
        if let imageUrlString = post.image {
            return URL(string: imageUrlString)
        } else {
            return nil
        }
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            LazyImage(url: postImageURL, transaction: .init(animation: .easeIn(duration: 0.2))) { state in
                    if let image = state.image {
                        image.resizable()
                    } else {
                        Image(.newsPlaceholder)
                    }
                }
                .aspectRatio(contentMode: .fill)
                .frame(width: 96, height: 96)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            VStack(alignment: .leading, spacing: 8) {
                Text(post.title)
                    .font(.system(size: 17, weight: .semibold))
                    .lineLimit(2)
                HStack {
                    Image(.calendarIcon)
                        .foregroundStyle(.action)
                    Text(Formatter.dayFormatter.string(from: post.date))
                        .font(.system(size: 12))
                        .foregroundColor(.action)
                }
                Text(post.text)
                    .font(.system(size: 13))
                    .lineLimit(3)
                    .foregroundColor(.secondaryText)
            }
        }
        .padding(.vertical, 8)
    }
}

#if DEBUG
struct AnnouncementRow_Previews: PreviewProvider {
    static var previews: some View {
        PostRow(post: News.mocks().announcements.posts.first!)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
#endif
