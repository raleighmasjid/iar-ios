//
//  DecodingTests.swift
//  DecodingTests
//
//  Created by Ameir Al-Zoubi on 1/24/22.
//

import XCTest
@testable import IAR

class DecodingTests: XCTestCase {
    
    let format = Date.FormatStyle(date: .numeric, time: .shortened, locale: Locale(identifier: "en_US"), timeZone: TimeZone(identifier: "America/New_York")!)
    
    func sampleData() -> [PrayerDay] {
        let jsonPath = Bundle(for: DecodingTests.self).url(forResource: "prayerday", withExtension: "json")!
        let data = try! Data(contentsOf: jsonPath)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try! decoder.decode([PrayerDay].self, from: data)
    }
    
    func testPrayerDayDecoding() {
        let prayerDays = sampleData()
        XCTAssertEqual(prayerDays.count, 15)
    }
    
    func testAdhanTime() {
        let prayerDays = sampleData()
        XCTAssertEqual(prayerDays[0].adhan.fajr.formatted(format), "1/24/2022, 5:52 AM")
        XCTAssertEqual(prayerDays[0].adhan.shuruq.formatted(format), "1/24/2022, 7:21 AM")
        XCTAssertEqual(prayerDays[0].adhan.dhuhr.formatted(format), "1/24/2022, 12:32 PM")
        XCTAssertEqual(prayerDays[0].adhan.asr.formatted(format), "1/24/2022, 3:14 PM")
        XCTAssertEqual(prayerDays[0].adhan.maghrib.formatted(format), "1/24/2022, 5:36 PM")
        XCTAssertEqual(prayerDays[0].adhan.isha.formatted(format), "1/24/2022, 6:59 PM")
    }
    
    func testIqamahTime() {
        let prayerDays = sampleData()
        XCTAssertEqual(prayerDays[0].iqamah.fajr.formatted(format), "1/24/2022, 6:15 AM")
        XCTAssertEqual(prayerDays[0].iqamah.dhuhr.formatted(format), "1/24/2022, 1:35 PM")
        XCTAssertEqual(prayerDays[0].iqamah.asr.formatted(format), "1/24/2022, 3:30 PM")
        XCTAssertEqual(prayerDays[0].iqamah.maghrib.formatted(format), "1/24/2022, 5:46 PM")
        XCTAssertEqual(prayerDays[0].iqamah.isha.formatted(format), "1/24/2022, 7:30 PM")
        XCTAssertEqual(prayerDays[0].iqamah.taraweeh, nil)
    }

    func testHijriComponents() {
        let prayerDays = sampleData()
        XCTAssertEqual(prayerDays[0].hijri.monthName, "Jumada al-thani")
        XCTAssertEqual(prayerDays[0].hijri.day, 21)
        XCTAssertEqual(prayerDays[0].hijri.month, 6)
        XCTAssertEqual(prayerDays[0].hijri.year, 1443)
    }
}
