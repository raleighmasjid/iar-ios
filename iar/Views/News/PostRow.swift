//
//  PostRow.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/12/22.
//

import SwiftUI
import Kingfisher

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
            KFImage.url(postImageURL)
                .placeholder {Image("news-placeholder") }
                .fade(duration: 0.2)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 54, height: 54)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            VStack(alignment: .leading, spacing: 8) {
                Text(post.title)
                    .font(.system(size: 16, weight: .semibold))
                    .lineLimit(2)
                Text(post.text)
                    .font(.system(size: 14))
                    .lineLimit(3)
                    .foregroundColor(.Theme.secondaryText)
                Text(Formatter.dayFormatter.string(from: post.date))
                    .font(.system(size: 12))
                    .foregroundColor(.Theme.tertiaryText)
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
