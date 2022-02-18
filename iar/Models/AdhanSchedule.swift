//
//  AdhanSchedule.swift
//  iar
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import Foundation

struct AdhanSchedule: Codable, Equatable {
    let fajr: Date
    let shuruq: Date
    let dhuhr: Date
    let asr: Date
    let maghrib: Date
    let isha: Date
}
