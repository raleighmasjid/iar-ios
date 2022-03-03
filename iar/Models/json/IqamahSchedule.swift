//
//  IqamahSchedule.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import Foundation

struct IqamahSchedule: Codable, Equatable, Hashable {
    let fajr: Date
    let dhuhr: Date
    let asr: Date
    let maghrib: Date
    let isha: Date
    let taraweeh: Date?
}
