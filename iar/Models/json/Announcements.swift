//
//  Announcements.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/19/22.
//

import Foundation

struct Announcements: Codable, Equatable {
    let special: Post?
    let featured: Post?
    let posts: [Post]
    
    func postIDs() -> [Int] {
        var ids = posts.map { $0.id }
        if let special = special {
            ids.append(special.id)
        }
        if let featured = featured {
            ids.append(featured.id)
        }
        
        return ids
    }
}
