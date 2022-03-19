//
//  News.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 3/8/22.
//

import Foundation

struct News: Codable {
    let special: SpecialAnnouncement?
    let featured: Announcement?
    let announcements: [Announcement]
    let events: [Event]
}
