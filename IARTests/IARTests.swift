//
//  IARTests.swift
//  IARTests
//
//  Created by Ameir Al-Zoubi on 3/14/25.
//

import Testing
@testable import IAR

struct IARTests {

    @Test func testNormalizedSmallestAngleAlreadyValid() {
        let angle1 = CompassAngle.valid(10)
        #expect(angle1.normalizedSmallestAngle == 10)
        
        let angle2 = CompassAngle.valid(-10)
        #expect(angle2.normalizedSmallestAngle == -10)
    }
    
    @Test func testNormalizedSmallestAngleInvalid() {
        let angle1 = CompassAngle.invalid
        #expect(angle1.normalizedSmallestAngle == nil)
        
        let angle2 = CompassAngle.pending
        #expect(angle2.normalizedSmallestAngle == nil)
        
        let angle3 = CompassAngle.accessDenied
        #expect(angle3.normalizedSmallestAngle == nil)
    }
    
    @Test func testNormalizedSmallestAngleWindDown() {
        let angle1 = CompassAngle.valid(370)
        #expect(angle1.normalizedSmallestAngle == 10)
        
        let angle2 = CompassAngle.valid(1070)
        #expect(angle2.normalizedSmallestAngle == -10)
        
        let angle3 = CompassAngle.valid(540)
        #expect(angle3.normalizedSmallestAngle == 180)
        
        let angle4 = CompassAngle.valid(541)
        #expect(angle4.normalizedSmallestAngle == -179)
    }
    
    @Test func testNormalizedSmallestAngleWindUp() {
        let angle1 = CompassAngle.valid(-370)
        #expect(angle1.normalizedSmallestAngle == -10)
        
        let angle2 = CompassAngle.valid(-1070)
        #expect(angle2.normalizedSmallestAngle == 10)
        
        let angle3 = CompassAngle.valid(-540)
        #expect(angle3.normalizedSmallestAngle == 180)
        
        let angle4 = CompassAngle.valid(-541)
        #expect(angle4.normalizedSmallestAngle == 179)
    }

    @Test func adjustedEnd() {
        let adjusted1 = CompassAngle.adjustedEnd(from: 350, to: 10)
        #expect(adjusted1 == 370)
        
        let adjusted2 = CompassAngle.adjustedEnd(from: 10, to: 350)
        #expect(adjusted2 == -10)
        
        let adjusted3 = CompassAngle.adjustedEnd(from: 170, to: 190)
        #expect(adjusted3 == 190)
        
        let adjusted4 = CompassAngle.adjustedEnd(from: 180, to: 359)
        #expect(adjusted4 == 359)
        
        let adjusted5 = CompassAngle.adjustedEnd(from: 180, to: 1)
        #expect(adjusted5 == 1)
        
        let adjusted6 = CompassAngle.adjustedEnd(from: 400, to: 50)
        #expect(adjusted6 == 410)
    }
}
